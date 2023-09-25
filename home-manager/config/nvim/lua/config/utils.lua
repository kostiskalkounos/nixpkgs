local M = {}

local count_bufs_by_type = function(loaded_only)
  loaded_only = (loaded_only == nil and true or loaded_only)
  local count = {
    acwrite = 0,
    help = 0,
    nofile = 0,
    normal = 0,
    nowrite = 0,
    prompt = 0,
    quickfix = 0,
    terminal = 0,
  }
  local buftypes = vim.api.nvim_list_bufs()
  for _, bufname in pairs(buftypes) do
    if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
      local buftype = vim.api.nvim_buf_get_option(bufname, "buftype")
      buftype = buftype ~= "" and buftype or "normal"
      count[buftype] = count[buftype] + 1
    end
  end
  return count
end

function M.close_buffer()
  local bufTable = count_bufs_by_type()
  if bufTable.normal <= 1 then
    vim.cmd(":q")
  else
    vim.cmd(":bd")
  end
end

return M
