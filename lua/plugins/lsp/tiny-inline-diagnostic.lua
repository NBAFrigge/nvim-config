return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000, -- load early so it can hook into diagnostics
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "modern",
      options = {
        show_source = false,
        multilines = { enabled = true, always_show = false },
        show_all_diags_on_cursorline = false,
        enable_on_insert = false,
      },
    })
    -- NOTE: virtual_text is disabled centrally in lsp.lua (opts.diagnostics),
    -- which is the single source of truth for vim.diagnostic.config. This
    -- plugin only owns the inline rendering, not the global diagnostic config.
  end,
}
