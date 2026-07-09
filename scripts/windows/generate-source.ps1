param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path -LiteralPath (Join-Path $ScriptDir '..\..')
$UpstreamDir = Join-Path $RepoRoot 'upstream'
$OverlayDir = Join-Path $RepoRoot 'src'
$SourceDir = Join-Path $RepoRoot 'source'

function Assert-UnderRepo {
    param(
        [string]$Path,
        [string]$Name
    )

    $repoPath = [System.IO.Path]::GetFullPath($RepoRoot.Path)
    $fullPath = [System.IO.Path]::GetFullPath($Path)
    if (-not $fullPath.StartsWith($repoPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "$Name path is outside the repository: $fullPath"
    }
}

function Invoke-RobocopyChecked {
    param(
        [string]$From,
        [string]$To,
        [string[]]$ExtraArgs
    )

    $args = @($From, $To) + $ExtraArgs
    & robocopy @args
    $code = $LASTEXITCODE
    if ($code -gt 7) {
        throw "robocopy failed with exit code $code"
    }
}

if (-not (Test-Path -LiteralPath $UpstreamDir)) {
    throw "Missing upstream directory. Run: git submodule update --init --recursive"
}

if (-not (Test-Path -LiteralPath (Join-Path $UpstreamDir 'CMakeLists.txt'))) {
    throw "upstream does not look like a Blender checkout: $UpstreamDir"
}

Assert-UnderRepo -Path $SourceDir -Name 'source'

if (Test-Path -LiteralPath $SourceDir) {
    if (-not $Clean) {
        throw "source already exists. Re-run with -Clean to regenerate it."
    }
    Remove-Item -LiteralPath $SourceDir -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $SourceDir | Out-Null

Write-Host "Copying Blender upstream into source..."
Invoke-RobocopyChecked -From $UpstreamDir -To $SourceDir -ExtraArgs @('/MIR', '/XD', '.git', '/XF', '.git', '/R:2', '/W:2')

if (Test-Path -LiteralPath $OverlayDir) {
    $overlayItems = Get-ChildItem -LiteralPath $OverlayDir -Force | Where-Object { $_.Name -ne '.gitkeep' }
    if ($overlayItems.Count -gt 0) {
        Write-Host "Applying MUNO overlay from src..."
        Invoke-RobocopyChecked -From $OverlayDir -To $SourceDir -ExtraArgs @('/E', '/XD', '.git', '/XF', '.gitkeep', '/R:2', '/W:2')
    }
    else {
        Write-Host "No overlay files found in src; source is a clean Blender copy."
    }
}

Write-Host "Source generation complete: $SourceDir"