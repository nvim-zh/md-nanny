local q = require('vim.treesitter.query')
local fn = vim.fn
local M = {}


--- 获取最长的一行
---@param node
function M.get_max_line(bufnr, node)
  local start_line = node:start()
  local end_line = node:end_()
  local _l = 0
  local max_line = ''
  local line_range = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
  for _, line in pairs(line_range) do
    local len = string.len(line)
    if len > _l then
      _l = len
      max_line = line
    end
  end
  return max_line
end

return M
