local filetype = require('md-nanny.core.config').filetype
local M = {}
function M.get_nodes_table(bufnr, start_line, end_line, parse_query_text)
  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(filetype, parse_query_text)
  local tables = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local n_root = captures[id]
    table.insert(tables, n_root)
  end
  return tables
end

return M
