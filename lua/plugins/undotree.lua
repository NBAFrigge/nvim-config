return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle" },
  keys = {
    { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
  },
  config = function()
    vim.opt.undofile = true
    vim.opt.undolevels = 10000
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
