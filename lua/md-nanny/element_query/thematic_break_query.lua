local get_nodes_table = require('md-nanny.element_query.query_root').get_nodes_table
local M = {}
function M.get_break_query(bufnr, start_line, end_line)
  ---{{{
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
  return get_nodes_table(bufnr, start_line, end_line, [[
  ((thematic_break)@break)
  ]])
end

return M
