return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>o", group = "obsidian", icon = "󱓧 " },
      { "<leader>m", group = "markdown", icon = "󰍔 " },
      { "<leader>r", group = "rust", icon = " " },
      { "gs", group = "surround", icon = "󰅲 " },
    },
  },
}
