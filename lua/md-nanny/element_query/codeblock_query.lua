local get_nodes_table = require('md-nanny.element_query.query_root').get_nodes_table
local M = {}


--- 获取代码块的节点
---@param bufnr
---@param start_line
---@param end_line
---@return
function M.get_code_book_scope(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}

  return get_nodes_table(bufnr, start_line, end_line, [[
  (
    (fenced_code_block) @code_block
  )
  ]])
end

return M
