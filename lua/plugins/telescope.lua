return {
  "nvim-telescope/telescope.nvim",
  keys = function(_, keys)
    for _, key in ipairs(keys) do
      if key[1] == "<leader>fg" then
        key[2] = "<cmd>Telescope live_grep<cr>"
        key.desc = "Grep Files (cwd)"
        break
      end
    end
    return keys
  end,
}
