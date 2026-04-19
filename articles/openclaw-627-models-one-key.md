# How to Use 627+ AI Models in OpenClaw with One API Key

OpenClaw is a powerful AI agent framework, but out of the box it needs a model provider. Most guides tell you to use OpenAI directly, or set up Ollama locally. But what if you want access to GPT-5.4, Claude, Gemini, DeepSeek, and Grok — all from one endpoint, with one key?

That's what Crazyrouter does. And now there's a one-command setup to connect the two.

## What Is Crazyrouter?

Crazyrouter is an AI API gateway. You get one API key, and it routes your requests to 627+ models across OpenAI, Anthropic, Google, DeepSeek, xAI, and more.

It's OpenAI-compatible, which means any tool that works with the OpenAI API format works with Crazyrouter — including OpenClaw.

Key benefits:

- **One key, all models** — no need to manage separate API keys for each provider
- **Lower cost** — aggregated pricing is often cheaper than going direct
- **Zero vendor lock-in** — switch models by changing one string
- **Same API format** — drop-in replacement for OpenAI endpoints

## Connecting OpenClaw to Crazyrouter

I published a small open-source project that does this in one command:

<https://github.com/xujfcn/openclaw-crazyrouter>

### Windows

```powershell
irm https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.ps1 | iex
```

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.sh | bash
```

The script will:

1. Ask for your Crazyrouter API key
2. Ask which model you want (default: `gpt-5.4`)
3. Write the OpenClaw config
4. Restart the gateway

After that, OpenClaw uses Crazyrouter for all model requests.

## Switching Models

Once configured, switching models is one command:

```bash
openclaw config set agents.defaults.model.primary "crazyrouter/claude-opus-4-7"
openclaw gateway restart
```

Popular model options:

| Model | Use Case |
|-------|----------|
| `gpt-5.4` | General-purpose, strongest reasoning |
| `gpt-5.4-mini` | Fast, cheap, good for high-volume |
| `claude-opus-4-7` | Deep reasoning, coding, long context |
| `claude-sonnet-4-5` | Balanced speed and quality |
| `gemini-2.5-pro` | Multimodal, large context window |
| `deepseek-r1` | Open-source, strong at math/code |
| `grok-3` | xAI's latest |

Full model list: [crazyrouter.com/models](https://crazyrouter.com/models)

## Why Not Just Use OpenAI Directly?

You can. But here's what you lose:

- **No fallback** — if OpenAI is down, your agent is down
- **No model diversity** — stuck with one provider's strengths and weaknesses
- **Higher cost** — direct pricing without aggregation discounts
- **Vendor lock-in** — switching providers means rewriting config

With Crazyrouter as a gateway, you get resilience, flexibility, and cost savings without changing your code.

## Adding Telegram (Bonus)

Once OpenClaw is connected to Crazyrouter, you can also bind it to Telegram in two commands:

```bash
openclaw config set channels.telegram.botToken "YOUR_BOT_TOKEN"
openclaw gateway restart
```

Create a bot via @BotFather on Telegram, paste the token, and your AI agent is live on Telegram — powered by whatever model you chose.

## Get Started

1. Get a Crazyrouter API key at [crazyrouter.com](https://crazyrouter.com)
2. Run the one-click setup: <https://github.com/xujfcn/openclaw-crazyrouter>
3. Start chatting with your AI agent

The whole process takes under 2 minutes.
