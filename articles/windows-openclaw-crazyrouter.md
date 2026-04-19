# One Command to Connect OpenClaw to Crazyrouter on Windows

If you've already installed OpenClaw on Windows, the next question is usually simple: how do I actually plug it into a real model provider without manually editing config files?

That's exactly why I made this small project:

<https://github.com/xujfcn/openclaw-crazyrouter>

It gives you a one-click setup script that connects OpenClaw to Crazyrouter as an OpenAI-compatible provider, sets your default model, backs up your old config, and restarts the gateway.

## The Problem

Most users who install OpenClaw can get the app running, but they get stuck on the provider setup step:

- Where is the config file?
- What if OpenClaw is installed in a non-default folder?
- How do I configure a custom provider?
- How do I switch to GPT-5.4 or Claude without breaking the rest of the setup?

For many people, that is where the onboarding flow becomes annoying.

## The Fix

Instead of asking users to manually edit `openclaw.json`, this script does it for them.

On Windows, the usage is just:

```powershell
irm https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.ps1 | iex
```

Then it prompts for:

- your Crazyrouter API key
- the model you want to use, like `gpt-5.4`, `claude-opus-4-7`, or `gemini-2.5-pro`

That's it.

## Why This Approach Works

The script does four things:

1. detects the OpenClaw user config path automatically
2. backs up the existing config if there is one
3. adds Crazyrouter as a provider using the OpenAI-compatible API format
4. sets the selected model as default and restarts the gateway

So the user doesn't need to care where OpenClaw was installed with npm. The setup is based on the user config directory, not the install directory.

## Why Crazyrouter

Crazyrouter gives you one API key for 627+ models across multiple providers. That means you can use OpenClaw with:

- GPT-5.4
- Claude Opus 4.7
- Claude Sonnet 4.5
- Gemini 2.5 Pro
- DeepSeek R1
- Grok
- and more

Instead of hardwiring OpenClaw to a single vendor, you can swap models anytime by changing one config value.

## GitHub Project

Repo:

<https://github.com/xujfcn/openclaw-crazyrouter>

The project includes:

- `setup.ps1` for Windows
- `setup.sh` for Linux/macOS
- README with usage instructions
- backup-and-switch flow for safer onboarding

## Who This Is For

This is useful if:

- you've already installed OpenClaw
- you want a faster setup path for non-technical users
- you want to switch OpenClaw to Crazyrouter in one step
- you want to avoid hand-editing JSON config files

## Final Thought

A lot of AI tools are technically powerful but still lose users during setup. Small one-click utilities like this matter because they remove friction exactly where people normally give up.

If you use OpenClaw and want a faster provider setup flow, this repo should save you a few minutes.

Repo again:

<https://github.com/xujfcn/openclaw-crazyrouter>
