-- =============================================================================
-- LSP plugin group
-- =============================================================================
-- lazy.nvim's top-level `{ import = "plugins" }` only scans the plugins/ folder
-- itself; it enters a subfolder ONLY through that subfolder's init.lua and does
-- NOT auto-scan sibling files. So every file in plugins/lsp/ must be listed
-- here explicitly.
--
-- Files in this group:
--   * lspconfig.lua              -> nvim-lspconfig: diagnostics + per-server opts
--   * rust-config.lua            -> rustaceanvim (rust-analyzer, bypasses lspconfig)
--   * tiny-inline-diagnostic.lua -> inline diagnostic rendering
-- =============================================================================

return {
  { import = "plugins.lsp.lspconfig" },
  { import = "plugins.lsp.rust-config" },
  { import = "plugins.lsp.tiny-inline-diagnostic" },
}
