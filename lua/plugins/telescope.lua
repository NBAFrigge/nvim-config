return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
      },
    },
    opts = {
      extensions = {
        frecency = {
          -- Scope frecency ranking to the current working directory...
          default_workspace = "CWD",
          -- ...but still list files that aren't in the frecency db yet,
          -- so this behaves like a normal file finder augmented by frecency.
          show_unindexed = true,
          show_scores = false,
          matcher = "fuzzy",
        },
      },
    },
    keys = function(_, keys)
      for _, key in ipairs(keys) do
        if key[1] == "<leader>fg" then
          key[2] = "<cmd>Telescope live_grep<cr>"
          key.desc = "Grep Files (cwd)"
          break
        end
      end
      -- Frecency-ranked file search, combined with a normal file listing.
      vim.list_extend(keys, {
        {
          "<leader>ff",
          "<cmd>Telescope frecency workspace=CWD<cr>",
          desc = "Find Files (frecency, cwd)",
        },
        {
          "<leader>fF",
          "<cmd>Telescope find_files<cr>",
          desc = "Find Files (plain, cwd)",
        },
      })
      return keys
    end,
  },
}
