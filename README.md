# claude-code-setup

One-shot re-import of our Claude Code **plugins + MCP servers** on any machine
(new laptop, a Pi, a server). No secrets in this repo.

## Quick start
```bash
# 1. install Claude Code CLI if needed
curl -fsSL https://claude.ai/install.sh | bash
# 2. run the setup
git clone https://github.com/gdhughey/claude-code-setup && bash claude-code-setup/install.sh
# 3. launch and sign into the SAME Claude account (pulls the account-connector MCPs)
claude
```

## Plugins (from GitHub marketplaces)
| Plugin | Marketplace (repo) | What it does |
|---|---|---|
| `claude-mem` | `thedotmack/claude-mem` | Persistent cross-session memory + `mcp-search` MCP. **Needs `bun`** (installer handles it). |
| `ponytail` | `DietrichGebert/ponytail` | Lazy/minimal coding mode (stdlib-first, shortest diff). |
| `claude-context-optimizer` (`cco`) | `egorfedorov/claude-context-optimizer` | Token/context budgeting + prompt coach. |
| *(available, not installed)* | `anthropics/claude-plugins-official` | Official plugin marketplace — browse with `/plugin`. |

Add a marketplace with just `owner/repo` — **not** a browser URL:
```
/plugin marketplace add owner/repo        # correct
# NOT: .../tree/main/.claude-plugin.git    # this fails to clone
```

## MCP servers
**CLI-addable (in `install.sh`):**
- **recraft** — image generation. HTTP MCP `https://mcp.recraft.ai/mcp` (OAuth on first use).

**Account connectors — NOT CLI-installable.** These attach automatically when you sign
Claude Code into the same Claude account; nothing to configure here:
- Gmail, Google Drive, Google Calendar
- Claude Docs
- Era Context (finance)
- Playwright (browser automation)
- `mcp-search` ships bundled with the `claude-mem` plugin.

## Verify
```bash
claude plugin list
claude mcp list
```
