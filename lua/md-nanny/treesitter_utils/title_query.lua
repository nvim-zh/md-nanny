local M = {}
local filetype = require('md-nanny.core.config').filetype

--- 获取标题的节点
---@param bufnr
---@param start_line
---@param end_line
---@return
function M.get_title_nodes_pos(bufnr, start_line, end_line)
  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(filetype, [[
    (
    (atx_heading) @heading (#match? @heading "^\#.+$")
    )
  ]])
  local titles = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local n_root = captures[id]
    local scope = n_root:parent()
    local symbol = n_root:child(0)
    local opts = { scope = scope, symbol = symbol }
    table.insert(titles, opts)
  end
  return titles
end

return M
