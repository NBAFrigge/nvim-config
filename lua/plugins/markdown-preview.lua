return {
  "iamcco/markdown-preview.nvim",
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  ft = { "markdown", "quarto" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown: Toggle Browser Preview" },
    { "<leader>mP", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown: Stop Browser Preview" },
  },
  init = function()
    vim.g.mkdp_page_title = "${name}"
    vim.g.mkdp_filetypes = { "markdown", "quarto" }
    vim.g.mkdp_theme = "dark"
  end,
}
