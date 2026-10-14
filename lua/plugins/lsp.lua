-- Central LSP configuration

-- LazyVim assembles LSP from several plugins automatically:
--   * nvim-lspconfig      -> server definitions + this opts table
--   * mason.nvim          -> installs the server binaries
--   * mason-lspconfig     -> bridges Mason <-> lspconfig
--   * blink.cmp           -> completion (advertises capabilities)
-- The `lang.*` extras in `lazyvim.json` are what actually enable each server
-- (gopls, vtsls, pyright, lua_ls, taplo, marksman, biome, eslint, ...).
--
-- THIS FILE is the single documented home for:
--   * diagnostic display        -> opts.diagnostics  (one source of truth)
--   * per-server setting tweaks  -> opts.servers
--
-- NOTE: Rust is intentionally NOT configured here. rust-analyzer is driven by
-- rustaceanvim (see rust-config.lua), which bypasses nvim-lspconfig by design.

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Diagnostics: single source of truth for how diagnostics are displayed.
      -- This deep-merges with LazyVim's defaults, so signs/icons are inherited.
      --
      -- virtual_text is OFF here on purpose: tiny-inline-diagnostic.nvim owns
      -- the inline virtual text (see tiny-inline-diagnostic.lua). Do NOT also
      -- call vim.diagnostic.config() elsewhere — change it here instead.
      diagnostics = {
        virtual_text = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      },

      -- -----------------------------------------------------------------------
      -- Per-server settings.
      -- Servers are installed/enabled by the lang.* extras + Mason; you only
      -- need an entry below to OVERRIDE a server's defaults.
      --
      -- Currently active servers (from your extras): gopls, vtsls, pyright,
      -- lua_ls, taplo, marksman, biome, eslint, bashls, jsonls.
      --
      -- Examples (uncomment / adapt as needed):
      -- -----------------------------------------------------------------------
      servers = {
        -- lua_ls = {
        --   settings = {
        --     Lua = {
        --       workspace = { checkThirdParty = false },
        --       codeLens = { enable = true },
        --       hint = { enable = true }, -- inlay hints
        --     },
        --   },
        -- },
        -- gopls = {
        --   settings = {
        --     gopls = {
        --       gofumpt = true,
        --       analyses = { unusedparams = true },
        --       hints = { assignVariableTypes = true, rangeVariableTypes = true },
        --     },
        --   },
        -- },
        -- pyright = {
        --   settings = {
        --     python = {
        --       analysis = { typeCheckingMode = "basic" },
        --     },
        --   },
        -- },
      },
    },
  },
}
