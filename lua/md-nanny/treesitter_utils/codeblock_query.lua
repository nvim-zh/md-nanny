local q = require('vim.treesitter.query')
local M = {}

function M.get_code_book_scope(bufnr, lang, start_line, end_line)
  ---{{{ test
  bufnr = vim.api.nvim_get_current_buf()
  lang = 'markdown'
  start_line = 0
  end_line = 39
  ---}}}
  local language_tree = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(lang, [[
  (
    (fenced_code_block) @code_block
  )
  ]])
  local code_blocks = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local n_root = captures[id]
    vim.notify(tostring(q.get_node_text(n_root, bufnr)))
    --table.insert(code_blocks, opts)
  end
  return code_blocks

end

return M
