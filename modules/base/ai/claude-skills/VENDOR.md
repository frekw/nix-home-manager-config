# Vendored pstack skills

These skills come from the `pstack` plugin in
[cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack), MIT licensed
(`pstack/LICENSE` upstream). They are vendored as source rather than installed as a plugin, and
`modules/base/ai/claude.nix` maps every directory here onto `~/.claude/skills/<name>/` through
`programs.claude-code.skills`.

## Pin

- Upstream path: `pstack/skills`
- Commit: `6fecddba65801f9b9c08b8b328d998ee5b09d290` (2026-08-27, the last commit touching `pstack/skills`)

## What was taken

Eight workflow skills (`architect`, `arena`, `blast-radius`, `how`, `interrogate`,
`show-me-your-work`, `unslop`, `why`) with their `references/` and `scripts/` subdirectories, plus
all 21 `principle-*` skills.

`arena` is not optional: `architect` phase B and `blast-radius` step 6 both delegate to it.
`interrogate` is cited by `architect` phase C, `show-me-your-work` by `principle-prove-it-works`.

Deliberately left behind: `poteto-mode`, `swarm`, `reflect`, `recall`, `tdd`, `teach`, `bro`,
`figure-it-out`, `automate-me`, `no-comments`, `setup-pstack`, `technical-writing`,
`typescript-best-practices`, `make-bot-ui`, `create-verification-skill`,
`maintain-verification-skill`, and the plugin's `agents/` and `automations/` directories.

## What was changed

Upstream targets Cursor. The prose, phase structure, and rubrics are untouched; only the runtime
mechanics were translated. All 21 `principle-*` skills are byte-for-byte copies, as is every file
under `why/references/sources/`.

| Upstream (Cursor) | Here (Claude Code) |
| --- | --- |
| `subagent_type: generalPurpose` | `subagent_type: general-purpose` |
| `readonly: true` | `subagent_type: Explore`, the read-only search agent |
| `readonly: false` "agent mode, keeps MCP access" | `general-purpose`, with a note that the subagent calls `ToolSearch` itself to load MCP schemas |
| `model: claude-fable-5-thinking-max` | `model: fable` |
| `model: claude-opus-5-thinking-xhigh` | `model: opus` |
| `model: grok-4.6-fast-xhigh` | `model: sonnet` |
| `model: gpt-5.6-sol-max` | dropped, no non-Anthropic models available |
| roster read from `~/.cursor/rules/pstack-models.mdc` | dropped, the roster is written inline |
| "spawn a Task subagent" | "call the Agent tool" |
| "run the **how** skill" | "invoke the `how` skill with the Skill tool" |
| `~/.cursor/projects/*/`, `agent-transcripts/` | `~/.claude/projects/<project-slug>/` |
| "inspect the `mcps/` directory Cursor exposes" | enumerate `mcp__*` tools, pulling deferred schemas in with `ToolSearch` |
| `scripts/log.sh` | `${CLAUDE_SKILL_DIR}/scripts/log.sh`, plus a matching `allowed-tools` grant |

Two changes went beyond substitution:

- **Runner diversity.** Upstream fans `arena`, `architect`, `interrogate`, and `how` critique mode
  out across four vendors. Only Anthropic models are reachable here, so each of those skills now
  says the framing has to carry the diversity: give every runner a distinct angle, or the candidates
  converge for the wrong reason.
- **`arena` candidate isolation.** Phase A wanted "a git worktree where possible". That is now
  named outright as the Agent tool's `isolation: "worktree"`.

## Additional skills

- `improve-codebase-architecture` & `codebase-design`: Vendored from `mattpocock/skills` (MIT licensed).
  Surface architectural friction, propose deepening opportunities as an HTML visual report, and design deep module interfaces.

## Re-syncing

```sh
tmp=$(mktemp -d)
git clone --depth 1 https://github.com/cursor/plugins "$tmp"
for d in modules/base/ai/claude-skills/*/; do
  diff -ru "$tmp/pstack/skills/$(basename "$d")" "$d"
done
```

Expect diffs only in the files named in the table above. Anything else is a genuine upstream change
worth pulling. Bump the pinned commit here when you do.
