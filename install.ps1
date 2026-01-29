# Spectre Agents Installer for Windows
# Installs craft-oriented agents and skills for Claude Code

$ErrorActionPreference = "Stop"

$RepoUrl = "https://github.com/fvilcot/spectre-agents"
$ClaudeDir = "$env:USERPROFILE\.claude"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Write-Info { param($msg) Write-Host "→ $msg" -ForegroundColor Blue }
function Write-Success { param($msg) Write-Host "✓ $msg" -ForegroundColor Green }
function Write-Error { param($msg) Write-Host "✗ $msg" -ForegroundColor Red; exit 1 }

function Test-LocalInstall {
    return (Test-Path "$ScriptDir\.claude\agents") -and (Test-Path "$ScriptDir\.claude\skills")
}

function Setup-Directories {
    Write-Info "Creating Claude Code directories..."
    New-Item -ItemType Directory -Force -Path "$ClaudeDir\agents" | Out-Null
    New-Item -ItemType Directory -Force -Path "$ClaudeDir\skills" | Out-Null
}

function Install-Local {
    Write-Info "Installing from local repository..."

    # Copy agents
    Get-ChildItem "$ScriptDir\.claude\agents\*.md" -ErrorAction SilentlyContinue | ForEach-Object {
        Copy-Item $_.FullName "$ClaudeDir\agents\" -Force
        Write-Success "Installed agent: $($_.BaseName)"
    }

    # Copy skills
    Get-ChildItem "$ScriptDir\.claude\skills" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        $dest = "$ClaudeDir\skills\$($_.Name)"
        if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
        Copy-Item $_.FullName "$ClaudeDir\skills\" -Recurse
        Write-Success "Installed skill: $($_.Name)"
    }
}

function Install-Remote {
    Write-Info "Cloning Spectre Agents..."

    $tmpDir = Join-Path $env:TEMP "spectre-agents-$(Get-Random)"

    try {
        git clone --depth 1 --quiet $RepoUrl $tmpDir
        if ($LASTEXITCODE -ne 0) { Write-Error "Failed to clone repository" }

        # Copy agents
        Get-ChildItem "$tmpDir\.claude\agents\*.md" -ErrorAction SilentlyContinue | ForEach-Object {
            Copy-Item $_.FullName "$ClaudeDir\agents\" -Force
            Write-Success "Installed agent: $($_.BaseName)"
        }

        # Copy skills
        Get-ChildItem "$tmpDir\.claude\skills" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
            $dest = "$ClaudeDir\skills\$($_.Name)"
            if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
            Copy-Item $_.FullName "$ClaudeDir\skills\" -Recurse
            Write-Success "Installed skill: $($_.Name)"
        }
    }
    finally {
        if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
    }
}

Write-Host "Spectre Agents Installer" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "Craft-oriented agents and skills for Claude Code"
Write-Host ""

Setup-Directories

if (Test-LocalInstall) {
    Install-Local
} else {
    Install-Remote
}

Write-Host ""
Write-Success "Installation complete!"
Write-Host ""
Write-Host "Restart Claude Code to load the new components."
Write-Host "See https://github.com/fvilcot/spectre-agents for documentation."
