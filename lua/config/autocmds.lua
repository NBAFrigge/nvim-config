-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function resolve_symlink()
  local cwd = vim.uv.cwd()
  local real_cwd = cwd and vim.uv.fs_realpath(cwd)

  if real_cwd and cwd ~= real_cwd then
    vim.api.nvim_set_current_dir(real_cwd)

    vim.defer_fn(function()
      vim.notify("Symlink resolved: " .. real_cwd, vim.log.levels.INFO)
    end, 200)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = resolve_symlink,
})
