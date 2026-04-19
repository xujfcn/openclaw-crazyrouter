# OpenClaw Setup Is Still Too Hard — So I Made a One-Click Fix

I like OpenClaw. The core idea is strong: an AI agent that can live in chat, call tools, automate work, and connect to multiple channels.

But the first-run setup is still harder than it should be for normal users.

Not the install step. That's usually fine.

The real friction starts right after installation:

- Which model provider should I use?
- Where is the config file?
- How do I add a custom OpenAI-compatible endpoint?
- What if I want GPT today, Claude tomorrow, and Gemini next week?
- What if OpenClaw was installed in some weird npm directory?

For technical users, these are manageable problems. For everyone else, this is where momentum dies.

So I made a small project to remove that friction:

<https://github.com/xujfcn/openclaw-crazyrouter>

## What It Does

This repo adds a one-click setup flow for using Crazyrouter as the provider behind OpenClaw.

Crazyrouter is an AI API gateway that exposes 627+ models through one API key and one OpenAI-compatible endpoint.

The setup script:

- detects the OpenClaw config path automatically
- prompts for the user's API key
- lets the user choose a model like `gpt-5.4`
- writes the config
- backs up the old config
- restarts the gateway

It works on:

- Windows via PowerShell
- Linux via Bash
- macOS via Bash

## Why This Matters

The installation path should not matter.

If a user installs OpenClaw with npm, the package directory might be somewhere ugly like:

`C:\Users\xinxin\AppData\Roaming\npm\node_modules\openclaw`

That should be irrelevant to onboarding. Users should not have to hunt around inside npm global folders just to connect a provider.

The correct abstraction is the user config directory. That's what this project uses.

## Why I Used Crazyrouter

Because it solves another onboarding problem at the same time.

Normally, if you want to try different models in OpenClaw, you need different providers, different keys, and different configs. That's a lot of switching cost for someone who just wants to test what works best.

With Crazyrouter, you get one key and can switch between:

- GPT-5.4
- Claude Opus 4.7
- Claude Sonnet 4.5
- Gemini 2.5 Pro
- DeepSeek R1
- Grok
- and hundreds more

That makes OpenClaw much easier to recommend, because users are no longer locked into one provider from day one.

## The Commands

Windows:

```powershell
irm https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.ps1 | iex
```

Linux / macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.sh | bash
```

Repo:

<https://github.com/xujfcn/openclaw-crazyrouter>

## The Bigger Point

AI tools don't just compete on model quality. They compete on setup friction.

If it takes ten minutes of config editing to get your first useful result, you've already lost a large percentage of users.

That's why I think these tiny glue projects matter. They aren't glamorous, but they make good software actually usable.

If you're using OpenClaw, or you're trying to onboard other people to it, this repo should make the first five minutes much smoother.
