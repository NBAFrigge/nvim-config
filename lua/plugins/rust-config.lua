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
    end,
  },
}
