# Neovim Keybinds Cheatsheet

## Custom binds (this config)

### LSP — `plugins/lsp.lua`
| Bind | Action |
|------|--------|
| `]d` | Next diagnostic (with float) |
| `[d` | Previous diagnostic (with float) |

### Debugger — `debugger/dap.lua`
| Bind | Action |
|------|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Open REPL |

### Pickers — `plugins/telescope.lua` / `plugins/mini-pick.lua`
| Bind | Action |
|------|--------|
| `<leader>k` | Find files |
| `<leader>g` | Live grep |
| `<leader>0` | Buffers |
| `<leader>f` | Find (scoped) |
| `<leader>F` | Find (alt scope) |

### Other plugins
| Bind | Action | Source |
|------|--------|--------|
| `<leader>ob` | Snipe buffers | `plugins/snipe.lua` |
| `<leader>i` | Auto-import | `plugins/auto-import.lua` |

## Neovim LSP defaults (0.12)

From `:help lsp-defaults`. Set automatically — no config needed.

### Global (always active)
| Bind | Mode | Action |
|------|------|--------|
| `grn` | n | Rename |
| `gra` | n, v | Code action |
| `grr` | n | References |
| `gri` | n | Implementation |
| `grt` | n | Type definition |
| `grx` | n | Run codelens *(0.12)* |
| `gO` | n | Document symbols |
| `<C-S>` | i | Signature help |
| `an` / `in` | x, o | LSP selection range *(0.12, fallback if no treesitter)* |
| `gx` | n | Open `textDocument/documentLink` *(0.12)* |

### Buffer-local (on `LspAttach`, if server supports)
| Bind | Action |
|------|--------|
| `K` | Hover (unless `keywordprg` or custom `K` set) |
| `<C-]>`, `<C-W>]`, `<C-W>}` | Go-to-definition via `tagfunc` |
| `<C-X><C-O>` (insert) | Completion via `omnifunc` |
| `gq` | Format range via `formatexpr` (use `gw` to opt out) |

### Diagnostics (built-in since 0.11)
| Bind | Action |
|------|--------|
| `]d` / `[d` | Next / previous diagnostic |

### 0.11 → 0.12 additions
- `grx` (codelens)
- `an` / `in` (LSP selection range text objects)
- `gx` honors `documentLink`
- Document color highlighting on attach

## Native vertical movement

### Line / display-line
| Bind | Action |
|------|--------|
| `j` / `k` | Line down / up |
| `gj` / `gk` | Display-line down / up (wrapped) |

### Paging / scrolling
| Bind | Action |
|------|--------|
| `<C-d>` / `<C-u>` | Half-page down / up |
| `<C-f>` / `<C-b>` | Full-page down / up |
| `<C-e>` / `<C-y>` | Scroll viewport down / up by one line |

### Viewport jumps
| Bind | Action |
|------|--------|
| `H` / `M` / `L` | Top / middle / bottom of viewport |
| `zz` / `zt` / `zb` | Center / top / bottom current line in viewport |

### File / text-object jumps
| Bind | Action |
|------|--------|
| `gg` / `G` | Top / bottom of file |
| `<N>G` or `:<N>` | Jump to line N |
| `<N>%` | Jump to N% through file |
| `{` / `}` | Previous / next paragraph |
| `(` / `)` | Previous / next sentence |
| `[[` / `]]` / `[]` / `][` | Section jumps |
| `%` | Matching bracket |

### History
| Bind | Action |
|------|--------|
| `''` / `` `` `` | Jump back to previous position |
| `<C-o>` / `<C-i>` | Jumplist back / forward |
