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
    -- Let tiny-inline-diagnostic own the virtual text so they don't double up.
    vim.diagnostic.config({ virtual_text = false })
  end,
}
