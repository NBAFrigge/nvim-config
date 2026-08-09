return {
  "epwalsh/obsidian.nvim",
  version = "*",
  cond = vim.fn.isdirectory(vim.fn.expand("~/HDD/UniObsidian")) == 1,
  cmd = {
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianToday",
    "ObsidianFollowLink",
  },
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Obsidian Note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian Notes" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
    { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Link" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/HDD/UniObsidian",
      },
    },
    notes_subdir = "00 Note",

    ---@param title string|nil
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^%w%-]", ""):lower()
      else
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return tostring(os.time()) .. "-" .. suffix
      end
    end,
  },
}
