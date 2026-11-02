param(
    [string]$CompilerPath = ''
)

$ErrorActionPreference = 'Stop'
if (-not $CompilerPath) {
    $CompilerPath = Join-Path (Split-Path $PSScriptRoot -Parent) 'tools\t8-compiler-utf8\DebugCompiler\bin\Release\DebugCompiler.exe'
    if (-not (Test-Path -LiteralPath $CompilerPath -PathType Leaf)) {
        $CompilerPath = 'F:\Project\项目汉化\tools\t8-compiler-utf8\DebugCompiler\bin\Release\DebugCompiler.exe'
    }
}
if (-not (Test-Path -LiteralPath $CompilerPath -PathType Leaf)) {
    throw '找不到 UTF-8 编译器，请使用 -CompilerPath 指定修改版 DebugCompiler.exe 的路径。'
}
$CompilerPath = (Resolve-Path -LiteralPath $CompilerPath).Path
$buildDirectory = Join-Path $PSScriptRoot '.build-zh-CN'
New-Item -ItemType Directory -Path $buildDirectory -Force | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'gsc.conf') -Destination $buildDirectory -Force
$compiledPath = Join-Path $buildDirectory 'compiled.gscc'
if (Test-Path -LiteralPath $compiledPath) {
    Remove-Item -LiteralPath $compiledPath -Force
}
Push-Location -LiteralPath $buildDirectory
try {
    & $CompilerPath (Join-Path $PSScriptRoot 'scripts') T8 --compile --noupdate
    if ($LASTEXITCODE -ne 0) {
        throw "编译失败，退出码：$LASTEXITCODE"
    }
} finally {
    Pop-Location
}

$data = [System.IO.File]::ReadAllBytes($compiledPath)
if ($data.Length -lt 0x60 -or [BitConverter]::ToString($data, 0, 8) -ne '80-47-53-43-0D-0A-00-36') {
    throw '产物不是预期的 BO4 T8 脚本。'
}
$recordCount = [BitConverter]::ToUInt16($data, 0x1c)
$cursor = [long][BitConverter]::ToUInt32($data, 0x24)
$utf8 = New-Object System.Text.UTF8Encoding($false, $true)
$strings = New-Object 'System.Collections.Generic.List[string]'
for ($index = 0; $index -lt $recordCount; $index++) {
    if ($cursor + 8 -gt $data.Length) { throw '字符串记录越界。' }
    $start = [long][BitConverter]::ToUInt32($data, [int]$cursor)
    $referenceCount = [int]$data[$cursor + 4]
    if ($start -ge $data.Length) { throw '字符串指针越界。' }
    $end = $start
    while ($end -lt $data.Length -and $data[$end] -ne 0) { $end++ }
    if ($end -eq $data.Length) { throw '字符串缺少终止符。' }
    $strings.Add($utf8.GetString($data, [int]$start, [int]($end - $start)))
    $next = $cursor + 8 + 4 * $referenceCount
    if ($next -gt $data.Length) { throw '字符串引用表越界。' }
    for ($reference = 0; $reference -lt $referenceCount; $reference++) {
        $address = [BitConverter]::ToUInt32($data, [int]($cursor + 8 + 4 * $reference))
        if ([long]$address + 4 -gt $data.Length) { throw '字符串引用地址越界。' }
    }
    $cursor = $next
}
foreach ($expected in @('Lucy 菜单', '无敌模式', '未定义', '典狱长办公室')) {
    if (-not $strings.Contains($expected)) {
        throw "中文校验失败：缺少「$expected」。请使用 UTF-8 编译器；现有成品未被替换。"
    }
}
$chineseCount = @($strings | Where-Object { $_ -match '[\u4e00-\u9fff]' }).Count
foreach ($filename in @('compiled.gscc', 'Lucy-Menu-zh-CN.gscc')) {
    Copy-Item -LiteralPath $compiledPath -Destination (Join-Path $PSScriptRoot $filename) -Force
}
Write-Host "编译与中文校验通过：$recordCount 条字符串记录，$chineseCount 条含中文。"
Write-Host (Join-Path $PSScriptRoot 'Lucy-Menu-zh-CN.gscc')
Get-FileHash -LiteralPath (Join-Path $PSScriptRoot 'Lucy-Menu-zh-CN.gscc') -Algorithm SHA256
