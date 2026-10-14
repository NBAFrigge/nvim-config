# Neovim config

Personal [LazyVim](https://github.com/LazyVim/LazyVim) setup for Neovim, tuned for Rust, Go, TypeScript and Markdown work.
Plugins are managed by lazy.nvim, with opt-in extras declared in `lazyvim.json` and per-plugin overrides in `lua/plugins/`.
Language tooling (LSP servers, formatters, linters, debug adapters) is installed through Mason, and personal keymaps live in `lua/config/keymaps.lua`.
