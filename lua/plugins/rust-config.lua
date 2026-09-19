return {
  {
    "mrcjkb/rustaceanvim",
    opts = function(_, opts)
      local on_attach = opts.server.on_attach
      opts.server.on_attach = function(client, bufnr)
        if on_attach then
          on_attach(client, bufnr)
        end

        local function map(lhs, command, desc)
          vim.keymap.set("n", lhs, function()
            vim.cmd.RustLsp(command)
          end, { buffer = bufnr, desc = desc })
        end

        map("<leader>rr", "runnables", "Rust Runnables")
        map("<leader>rt", "testables", "Rust Testables")
        map("<leader>re", "expandMacro", "Rust Expand Macro")
      end

      opts.server.settings = function(project_root, default_settings)
        local settings = default_settings or { ["rust-analyzer"] = {} }
        settings["rust-analyzer"] = settings["rust-analyzer"] or {}
        local uv = vim.uv or vim.loop
        if project_root and uv.fs_stat(project_root .. "/os.json") then
          local ra = settings["rust-analyzer"]
          ra.cargo = vim.tbl_deep_extend("force", ra.cargo or {}, {
            target = "os.json",
            allTargets = false,
            buildScripts = { enable = true },
            extraEnv = { CARGO_UNSTABLE_JSON_TARGET_SPEC = "true" },
          })
          ra.check = vim.tbl_deep_extend("force", ra.check or {}, {
            allTargets = false,
            targets = { "os.json" },
          })
          ra.files = vim.tbl_deep_extend("force", ra.files or {}, {
            excludeDirs = { "benchmarks", "target" },
          })
        end
        return settings
      end
    end,
  },
}
