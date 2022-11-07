local M = {}
local q = require("vim.treesitter.query")
local lang = 'markdown'

function M.get_title_node_pos()
  local bufnr = vim.api.nvim_get_current_buf()
  local language_tree = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = language_tree:parse()
  local root = syntax_tree[1]:root()
  local query = vim.treesitter.parse_query(lang, [[
  ((section) @heading (#offset! @heading)) ]])
  local head = vim.treesitter.parse_query(lang, [[ ((atx_heading) @heading) ]])
  for _, captures, metadata in query:iter_matches(root, bufnr) do
    for _, c, m in head:iter_matches(captures[1]:root(), bufnr) do
      if string.len(q.get_node_text(c[1], bufnr)) > 0 then
        vim.notify(vim.inspect(metadata))
        break
      end
    end
  end

end

return M
