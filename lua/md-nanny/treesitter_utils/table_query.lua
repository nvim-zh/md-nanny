local filetype = require('md-nanny.core.config').filetype
local q = require('vim.treesitter.query')
local M = {}

function M.get_table_nodes(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(filetype, [[
  (
    (pipe_table) @table
  )
  ]])
  local tables = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local n_root = captures[id]
    table.insert(tables, n_root)
  end
  return tables
end

return M
