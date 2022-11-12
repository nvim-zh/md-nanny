local filetype = require('md-nanny.core.config').filetype

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

  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(filetype, [[
  (
    (fenced_code_block) @code_block
  )
  ]])
  local code_blocks = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local n_root = captures[id]
    --vim.notify(tostring(q.get_node_text(n_root, bufnr)))
    table.insert(code_blocks, n_root)
  end
  return code_blocks
end

return M
