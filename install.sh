#!/usr/bin/env bash
# Re-import our Claude Code plugins + MCP servers on any machine.
# Usage:  curl -fsSL <raw-url>/install.sh | bash   (or clone + run)
# No secrets here — plugin repos and the Recraft MCP URL are public; the
# claude.ai account MCPs arrive automatically once you sign into the same
# Claude account (see README).
set -uo pipefail
export PATH="$HOME/.local/bin:$PATH"
command -v claude >/dev/null || { echo "Claude Code CLI not found. Install it first:"; echo "  curl -fsSL https://claude.ai/install.sh | bash"; exit 1; }

echo "== plugin marketplaces =="
for m in thedotmack/claude-mem DietrichGebert/ponytail egorfedorov/claude-context-optimizer anthropics/claude-plugins-official; do
  claude plugin marketplace add "$m" 2>&1 | tail -1 || true
done

echo "== plugins =="
claude plugin install claude-mem@thedotmack            2>&1 | tail -1 || true   # memory + mcp-search MCP (needs bun)
claude plugin install ponytail@ponytail                2>&1 | tail -1 || true   # lazy/minimal coding mode
claude plugin install claude-context-optimizer@cco     2>&1 | tail -1 || true   # token/context optimizer (cco)

echo "== MCP servers (CLI-addable) =="
# Recraft image-gen MCP (HTTP; OAuth on first use via your Claude account)
claude mcp add --transport http recraft https://mcp.recraft.ai/mcp 2>&1 | tail -1 || true

echo "== bun (claude-mem needs it for hooks + mcp-search) =="
command -v bun >/dev/null || { echo "  installing bun..."; curl -fsSL https://bun.sh/install | bash >/dev/null 2>&1 && echo "  bun installed"; }

echo
echo "DONE. Then run 'claude' and sign into the SAME Claude account to pull the"
echo "account-connector MCPs (Gmail, Google Drive/Calendar, Claude Docs, Era, Playwright)."
echo "Verify with:  claude plugin list   and   claude mcp list"
