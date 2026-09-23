# Neovim config

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup for Neovim, tuned for Rust, Go, TypeScript and Markdown work.
Plugins are managed by lazy.nvim, with opt-in extras declared in `lazyvim.json` and per-plugin overrides in `lua/plugins/`.
Language tooling (LSP servers, formatters, linters, debug adapters) is installed through Mason, and personal keymaps live in `lua/config/keymaps.lua`.

## Install

```sh
git clone https://github.com/NBAFrigge/nvim-config /tmp/nvim-config \
  && /tmp/nvim-config/install.sh
```

The installer backs up any existing `~/.config/nvim`, deploys this config, and
syncs plugins headlessly. Flags:

```sh
./install.sh --symlink   # symlink files instead of copying (edits track the repo)
./install.sh --no-sync   # deploy only, skip headless plugin sync
./install.sh --dry-run   # print actions, change nothing
NVIM_CONFIG=/custom/path ./install.sh
```

Requires `git` and `nvim` (>=0.9), plus a Nerd Font for icons. On first launch
LazyVim finishes installing any remaining plugins and Mason tools.
