-- Biome owns JS/TS/JSON/CSS formatting (via lang.typescript.biome extra).
-- Prettier is kept only for filetypes Biome does not support, so markdown,
-- html and yaml still format on save.
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Filetypes Biome handles -> Biome only (no prettier, no eslint).
      local biome_fts = {
        "astro",
        "css",
        "graphql",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "scss",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      }
      for _, ft in ipairs(biome_fts) do
        opts.formatters_by_ft[ft] = { "biome-check" }
      end

      -- Filetypes Biome does NOT handle -> keep prettier.
      local prettier_fts = {
        "handlebars",
        "html",
        "less",
        "markdown",
        "markdown.mdx",
        "yaml",
      }
      for _, ft in ipairs(prettier_fts) do
        opts.formatters_by_ft[ft] = { "prettier" }
      end

      opts.formatters = opts.formatters or {}
      opts.formatters["biome-check"] = vim.tbl_deep_extend("force", opts.formatters["biome-check"] or {}, {
        require_cwd = true,
      })
    end,
  },
}
