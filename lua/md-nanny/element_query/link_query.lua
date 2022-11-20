local get_nodes_table = require('md-nanny.element_query.query_root').get_nodes_table
local M = {}

--- 获取代办list的类型
---@param bufnr
---@param start_line
---@param end_line
---@return
function M.get_link_nodes(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
  return get_nodes_table(bufnr, start_line, end_line, [[
  (
    (list (list_item (task_list_marker_checked) @list_task))
  )
  ]])
end

function M.get_link_nodes_minus(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
  return get_nodes_table(bufnr, start_line, end_line, [[
  (
    (list (list_item (list_marker_minus) @list_task))
  )
  ]])
end

return M
