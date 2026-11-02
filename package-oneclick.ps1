param(
    [string]$RuntimeDirectory = 'C:\t7compiler',
    [string]$PayloadPath = (Join-Path (Split-Path $PSScriptRoot -Parent) 'release-verification\BO4-Lucy-Menu-zh-CN-v1.5.0-zh-CN\release-original\Lucy-Menu-zh-CN.gscc'),
    [string]$OutputDirectory = (Join-Path (Split-Path $PSScriptRoot -Parent) 'release-staging\BO4-Lucy-Menu-zh-CN-v1.5.0-zh-CN')
)

$ErrorActionPreference = 'Stop'
$packageName = 'Lucy-Menu-zh-CN-OneClick-v1.5.0'
$outputZip = Join-Path $OutputDirectory ($packageName + '.zip')
if (Test-Path -LiteralPath $outputZip) { throw "目标压缩包已存在，请指定其他 -OutputDirectory：$outputZip" }
$expectedPayloadHash = '362F3E189F3BE398148D21A707718F949C5C15E68A2A75A6702DBE71AD964685'
if (-not (Test-Path -LiteralPath $PayloadPath -PathType Leaf)) {
    throw '找不到 v1.5.0-zh-CN Release 原始产物，请下载 Lucy-Menu-zh-CN.gscc 并通过 -PayloadPath 指定路径。'
}
if ((Get-FileHash -LiteralPath $PayloadPath -Algorithm SHA256).Hash -ne $expectedPayloadHash) {
    throw '产物与 v1.5.0-zh-CN Release 原始附件不一致，停止打包。'
}
$required = @('DebugCompiler.exe', 'DebugCompiler.exe.config', 'External.dll', 'TreyarchCompiler.dll', 'T89CompilerLib.dll', 'T7CompilerLib.dll', 'Irony.dll', 't8cinternal.dll')
foreach ($name in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $RuntimeDirectory $name) -PathType Leaf)) {
        throw "注入工具文件不完整：$name"
    }
}
$stageRoot = Join-Path $PSScriptRoot ('.package-staging\' + [Guid]::NewGuid().ToString('N'))
$packageRoot = Join-Path $stageRoot $packageName
$runtimeTarget = Join-Path $packageRoot 'runtime'
New-Item -ItemType Directory -Path $runtimeTarget -Force | Out-Null
Get-ChildItem -LiteralPath (Join-Path $PSScriptRoot 'oneclick') -File | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $packageRoot
}
Copy-Item -LiteralPath $PayloadPath -Destination (Join-Path $packageRoot 'Lucy-Menu-zh-CN.gscc')
Get-ChildItem -LiteralPath $RuntimeDirectory -File | Where-Object {
    $_.Extension -eq '.dll' -or $_.Name -like '*.dll.config' -or
    $_.Name -in @('DebugCompiler.exe', 'DebugCompiler.exe.config', 'vm_codes.db2', 'T7PCV2.db')
} | ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $runtimeTarget }
# Windows PowerShell 5.1 needs a BOM for source containing Chinese text.
foreach ($textFile in @((Join-Path $packageRoot 'Inject.ps1'), (Join-Path $packageRoot '使用说明.txt'))) {
    $content = [System.IO.File]::ReadAllText($textFile)
    [System.IO.File]::WriteAllText($textFile, $content, (New-Object System.Text.UTF8Encoding($true)))
}
$launcher = Join-Path $packageRoot '一键注入.cmd'
$launcherText = [System.IO.File]::ReadAllText($launcher) -replace '\r?\n', "`r`n"
[System.IO.File]::WriteAllText($launcher, $launcherText, [System.Text.Encoding]::ASCII)
$manifestLines = Get-ChildItem -LiteralPath $packageRoot -Recurse -File | Sort-Object FullName | ForEach-Object {
    $relativePath = $_.FullName.Substring($packageRoot.Length + 1).Replace('\', '/')
    '{0}  {1}' -f (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash, $relativePath
}
[System.IO.File]::WriteAllLines((Join-Path $packageRoot 'SHA256SUMS.txt'), [string[]]$manifestLines, (New-Object System.Text.UTF8Encoding($false)))
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $packageRoot 'Inject.ps1') -CheckOnly
if ($LASTEXITCODE -ne 0) { throw '压缩前自检失败。' }
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
Compress-Archive -LiteralPath $packageRoot -DestinationPath $outputZip -CompressionLevel Optimal
$zipHash = (Get-FileHash -LiteralPath $outputZip -Algorithm SHA256).Hash
$checksumLine = '{0}  {1}' -f $zipHash, [System.IO.Path]::GetFileName($outputZip)
[System.IO.File]::WriteAllText(($outputZip + '.sha256'), ($checksumLine + "`n"), [System.Text.Encoding]::ASCII)
Write-Host "压缩包：$outputZip"
Get-FileHash -LiteralPath $outputZip -Algorithm SHA256
