#!/usr/bin/env bash
#
# One-click setup for OpenClaw with Crazyrouter as AI model provider.
# Usage:
#   ./setup.sh
#   ./setup.sh --api-key "sk-xxx" --model "gpt-5.4"
#   curl -fsSL https://raw.githubusercontent.com/xujfcn/openclaw-crazyrouter/main/setup.sh | bash
#

set -e

# --- Defaults ---
API_KEY=""
MODEL="gpt-5.4"

# --- Parse args ---
while [[ $# -gt 0 ]]; do
    case $1 in
        --api-key|-k)  API_KEY="$2"; shift 2 ;;
        --model|-m)    MODEL="$2"; shift 2 ;;
        --help|-h)
            echo "Usage: ./setup.sh [--api-key KEY] [--model MODEL]"
            echo ""
            echo "Options:"
            echo "  --api-key, -k    Crazyrouter API key (prompted if omitted)"
            echo "  --model, -m      Model name (default: gpt-5.4)"
            exit 0 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# --- Banner ---
echo ""
echo "  ╔══════════════════════════════════════════╗"
echo "  ║  OpenClaw × Crazyrouter - Quick Setup   ║"
echo "  ║  One API Key, 627+ AI Models            ║"
echo "  ╚══════════════════════════════════════════╝"
echo ""

# --- Detect config directory ---
CONFIG_DIR="${HOME}/.openclaw"
CONFIG_FILE="${CONFIG_DIR}/openclaw.json"

echo "[1/5] Config location: ${CONFIG_FILE}"

# --- Prompt for API key if not provided ---
if [ -z "$API_KEY" ]; then
    echo ""
    echo "  Get your API key at: https://crazyrouter.com"
    echo ""
    printf "  Enter your Crazyrouter API Key: "
    read -r API_KEY
    if [ -z "$API_KEY" ]; then
        echo "  ERROR: API key is required."
        exit 1
    fi
fi

MASKED_KEY="${API_KEY:0:6}...${API_KEY: -4}"
echo "[2/5] API Key: ${MASKED_KEY}"
echo "[3/5] Model: crazyrouter/${MODEL}"

# --- Create config directory ---
mkdir -p "$CONFIG_DIR"

# --- Backup existing config ---
if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
    echo "[4/5] Backed up existing config to openclaw.json.bak"
else
    echo "[4/5] No existing config (fresh install)"
fi

# --- Write config ---
cat > "$CONFIG_FILE" <<EOF
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "crazyrouter/${MODEL}"
      }
    }
  },
  "models": {
    "providers": {
      "crazyrouter": {
        "baseUrl": "https://crazyrouter.com/v1",
        "apiKey": "${API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "${MODEL}",
            "name": "${MODEL}",
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
EOF

echo "[5/5] Config written!"

# --- Try to restart gateway ---
echo ""
if command -v openclaw &> /dev/null; then
    echo "  Restarting OpenClaw gateway..."
    openclaw gateway restart 2>/dev/null && echo "  Gateway restarted!" || echo "  Could not restart gateway. Run manually: openclaw gateway restart"
else
    echo "  'openclaw' not in PATH. Restart manually:"
    echo "    openclaw gateway restart"
fi

# --- Done ---
echo ""
echo "  ✅ Done! OpenClaw is now using Crazyrouter."
echo ""
echo "  Provider:  crazyrouter"
echo "  Model:     crazyrouter/${MODEL}"
echo "  Base URL:  https://crazyrouter.com/v1"
echo ""
echo "  Switch model anytime:"
echo "    openclaw config set agents.defaults.model.primary \"crazyrouter/claude-opus-4-7\""
echo ""
echo "  All models: https://crazyrouter.com/models"
echo ""
