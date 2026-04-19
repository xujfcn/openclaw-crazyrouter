# OpenClaw × Crazyrouter — One-Click Setup

One command to configure [OpenClaw](https://github.com/openclaw/openclaw) with [Crazyrouter](https://crazyrouter.com) as your AI model provider.

Crazyrouter is an AI API gateway — one API key, 627+ models (GPT-5.4, Claude, Gemini, DeepSeek, etc.) at lower cost.

## Quick Start

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.ps1 | iex
```

Or manually:

```powershell
.\setup.ps1 -ApiKey "sk-your-key" -Model "gpt-5.4"
```

### Linux / macOS (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.sh | bash
```

Or manually:

```bash
./setup.sh --api-key "sk-your-key" --model "gpt-5.4"
```

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| API Key | *(prompted)* | Your Crazyrouter API key from [crazyrouter.com](https://crazyrouter.com) |
| Model | `gpt-5.4` | Model to use (e.g. `gpt-5.4`, `claude-opus-4-7`, `gemini-2.5-pro`, `deepseek-r1`) |

## Supported Models

All 627+ models on Crazyrouter are supported. Popular choices:

- `gpt-5.4` — OpenAI's latest flagship
- `gpt-5.4-mini` — Fast and cheap
- `claude-opus-4-7` — Anthropic's strongest
- `claude-sonnet-4-5` — Great balance of speed/quality
- `gemini-2.5-pro` — Google's best
- `deepseek-r1` — Open-source reasoning model
- `grok-3` — xAI's model

Full list: [crazyrouter.com/models](https://crazyrouter.com/models)

## What It Does

1. Detects your OpenClaw config file location (works regardless of install path)
2. Backs up existing config (if any)
3. Adds Crazyrouter as a provider with your API key
4. Sets your chosen model as the default
5. Restarts the OpenClaw gateway

## Get Your API Key

1. Go to [crazyrouter.com](https://crazyrouter.com)
2. Sign up / Log in
3. Go to Dashboard → API Keys
4. Create a new key
5. Use it with this script

## Uninstall

To revert, restore your backup:

```powershell
# Windows
Copy-Item "$env:USERPROFILE\.openclaw\openclaw.json.bak" "$env:USERPROFILE\.openclaw\openclaw.json"
openclaw gateway restart
```

```bash
# Linux/macOS
cp ~/.openclaw/openclaw.json.bak ~/.openclaw/openclaw.json
openclaw gateway restart
```

## License

MIT
