param([switch]$CheckOnly)

$ErrorActionPreference = 'Stop'
try {
    $Host.UI.RawUI.WindowTitle = 'Lucy 菜单 · 简体中文注入'
    $runtimeDirectory = Join-Path $PSScriptRoot 'runtime'
    $injector = Join-Path $runtimeDirectory 'DebugCompiler.exe'
    $payload = Join-Path $PSScriptRoot 'Lucy-Menu-zh-CN.gscc'
    $manifest = Join-Path $PSScriptRoot 'SHA256SUMS.txt'
    foreach ($required in @($injector, $payload, $manifest)) {
        if (-not (Test-Path -LiteralPath $required -PathType Leaf)) {
            throw '文件不完整，请完整解压压缩包后再运行。'
        }
    }
    foreach ($line in [System.IO.File]::ReadAllLines($manifest)) {
        if ($line -notmatch '^([A-Fa-f0-9]{64})  (.+)$') { throw '校验清单格式错误。' }
        $expectedHash = $Matches[1]
        $relativePath = $Matches[2]
        $filePath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot $relativePath))
        $packageRoot = [System.IO.Path]::GetFullPath($PSScriptRoot).TrimEnd('\') + '\'
        if (-not $filePath.StartsWith($packageRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw '校验清单包含无效路径。'
        }
        if ((Get-FileHash -LiteralPath $filePath -Algorithm SHA256).Hash -ne $expectedHash) {
            throw "文件校验失败：$relativePath，请重新解压原始压缩包。"
        }
    }
    $bytes = [System.IO.File]::ReadAllBytes($payload)
    if ($bytes.Length -lt 0x60 -or [BitConverter]::ToString($bytes, 0, 8) -ne '80-47-53-43-0D-0A-00-36') {
        throw '中文成品不是预期的 BO4 T8 脚本。'
    }
    # The byte search is only a second check; the manifest verifies the complete payload.
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    if (-not $text.Contains('Lucy 菜单') -or -not $text.Contains('无敌模式')) {
        throw '成品缺少中文文字，请使用本包中的原始脚本。'
    }
    $netFramework = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release -ErrorAction SilentlyContinue
    if (-not $netFramework -or $netFramework.Release -lt 528040) {
        throw '需要安装 Microsoft .NET Framework 4.8 或更高版本。'
    }
    Write-Host '文件与中文成品校验通过。' -ForegroundColor Green
    if ($CheckOnly) { exit 0 }
    if (-not (Get-Process -Name 'blackops4' -ErrorAction SilentlyContinue)) {
        throw '未找到 BlackOps4.exe。请启动游戏、进入僵尸模式私人大厅，再双击一键注入.cmd。'
    }
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        $powerShell = Join-Path $PSHOME 'powershell.exe'
        $scriptPath = Join-Path $PSScriptRoot 'Inject.ps1'
        $elevated = Start-Process -FilePath $powerShell -Verb RunAs -Wait -PassThru -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $scriptPath)
        exit $elevated.ExitCode
    }
    Write-Host '请确认游戏停在僵尸模式私人大厅。' -ForegroundColor Cyan
    Write-Host '注入成功后保持窗口打开，游戏过程中不要按键。' -ForegroundColor Yellow
    Push-Location -LiteralPath $runtimeDirectory
    try {
        # Inject the compiled UTF-8 payload directly; never rebuild it with this tool.
        & $injector $payload T8 'scripts/zm_common/load.gsc' --inject --noupdate
        if ($LASTEXITCODE -ne 0) { throw "注入工具退出码：$LASTEXITCODE" }
        Write-Host '注入工具已结束，请以上方 Injected 或 Failed to Inject 的输出为准。'
    } finally {
        Pop-Location
    }
} catch {
    Write-Host ("失败：" + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
