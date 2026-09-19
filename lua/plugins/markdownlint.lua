return {
  "mfussenegger/nvim-lint",
  opts = function()
    -- Make markdownlint-cli2 always use our global config, which disables
    -- MD013 (the 80-char-per-line line-length warning) for all markdown files.
    local config = vim.fn.stdpath("config") .. "/markdownlint.jsonc"
    local linter = require("lint").linters["markdownlint-cli2"]
    if linter then
      linter.args = { "--config", config, "-" }
    end
  end,
}
