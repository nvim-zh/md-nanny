local get_nodes_table = require('md-nanny.element_query.query_root').get_nodes_table
local M = {}

function M.get_block_node(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
  return get_nodes_table(bufnr, start_line, end_line, [[
  ((block_quote (block_quote_marker) @block))
  ]])
end

return M
