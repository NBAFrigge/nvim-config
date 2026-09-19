return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>m", group = "markdown", icon = "󰍔 " },
      { "<leader>r", group = "rust", icon = " " },
      { "gs", group = "surround", icon = "󰅲 " },
    },
  },
}
