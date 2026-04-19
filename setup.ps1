#Requires -Version 5.1
<#
.SYNOPSIS
    One-click setup for OpenClaw with Crazyrouter as AI model provider.

.DESCRIPTION
    Configures OpenClaw to use Crazyrouter (https://crazyrouter.com) as the model provider.
    Works regardless of OpenClaw installation directory.

.PARAMETER ApiKey
    Your Crazyrouter API key. If not provided, will prompt interactively.

.PARAMETER Model
    Model to use as default. Default: gpt-5.4

.EXAMPLE
    .\setup.ps1
    .\setup.ps1 -ApiKey "sk-xxx" -Model "claude-opus-4-7"
    irm https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.ps1 | iex
#>

param(
    [string]$ApiKey,
    [string]$Model = "gpt-5.4"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "  ╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║  OpenClaw x Crazyrouter - Quick Setup   ║" -ForegroundColor Cyan
Write-Host "  ║  One API Key, 627+ AI Models            ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# --- Detect config directory ---
$configDir = Join-Path $env:USERPROFILE ".openclaw"
$configFile = Join-Path $configDir "openclaw.json"

Write-Host "[1/5] Config location: $configFile" -ForegroundColor Yellow

# --- Prompt for API key if not provided ---
if (-not $ApiKey) {
    Write-Host ""
    Write-Host "  Get your API key at: https://crazyrouter.com" -ForegroundColor Gray
    Write-Host ""
    $ApiKey = Read-Host "  Enter your Crazyrouter API Key"
    if (-not $ApiKey) {
        Write-Host "  ERROR: API key is required." -ForegroundColor Red
        exit 1
    }
}

Write-Host "[2/5] API Key: $($ApiKey.Substring(0,6))...$($ApiKey.Substring($ApiKey.Length-4))" -ForegroundColor Yellow
Write-Host "[3/5] Model: crazyrouter/$Model" -ForegroundColor Yellow

# --- Create config directory ---
if (!(Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    Write-Host "  Created: $configDir" -ForegroundColor Gray
}

# --- Backup existing config ---
if (Test-Path $configFile) {
    $backupFile = "$configFile.bak"
    Copy-Item $configFile $backupFile -Force
    Write-Host "[4/5] Backed up existing config to openclaw.json.bak" -ForegroundColor Yellow
} else {
    Write-Host "[4/5] No existing config (fresh install)" -ForegroundColor Yellow
}

# --- Write config ---
$config = @"
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "crazyrouter/$Model"
      }
    }
  },
  "models": {
    "providers": {
      "crazyrouter": {
        "baseUrl": "https://crazyrouter.com/v1",
        "apiKey": "$ApiKey",
        "api": "openai-completions",
        "models": [
          {
            "id": "$Model",
            "name": "$Model",
            "reasoning": true,
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 16384
          }
        ]
      }
    }
  }
}
"@

$config | Out-File -Encoding utf8 -FilePath $configFile -Force
Write-Host "[5/5] Config written!" -ForegroundColor Green

# --- Try to restart gateway ---
Write-Host ""
$openclawCmd = Get-Command openclaw -ErrorAction SilentlyContinue
if ($openclawCmd) {
    Write-Host "  Restarting OpenClaw gateway..." -ForegroundColor Gray
    try {
        & openclaw gateway restart 2>&1 | Out-Null
        Write-Host "  Gateway restarted!" -ForegroundColor Green
    } catch {
        Write-Host "  Could not restart gateway. Run manually: openclaw gateway restart" -ForegroundColor Yellow
    }
} else {
    Write-Host "  'openclaw' not in PATH. Restart manually:" -ForegroundColor Yellow
    Write-Host "    openclaw gateway restart" -ForegroundColor White
}

# --- Done ---
Write-Host ""
Write-Host "  ✅ Done! OpenClaw is now using Crazyrouter." -ForegroundColor Green
Write-Host ""
Write-Host "  Provider:  crazyrouter" -ForegroundColor White
Write-Host "  Model:     crazyrouter/$Model" -ForegroundColor White
Write-Host "  Base URL:  https://crazyrouter.com/v1" -ForegroundColor White
Write-Host ""
Write-Host "  Switch model anytime:" -ForegroundColor Gray
Write-Host "    openclaw config set agents.defaults.model.primary `"crazyrouter/claude-opus-4-7`"" -ForegroundColor White
Write-Host ""
Write-Host "  All models: https://crazyrouter.com/models" -ForegroundColor Gray
Write-Host ""
