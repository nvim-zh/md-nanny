local filetype = require('md-nanny.core.config').filetype
local q = require('vim.treesitter.query')
local M = {}

function M.get_link_nodes(bufnr, start_line, end_line)
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
    (list (list_item (task_list_marker_checked) @list_task))
  )
  ]])
  local links = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local node = captures[id]
    table.insert(links, node)
  end
  return links
end

function M.get_link_nodes_minus(bufnr, start_line, end_line)
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
    (list (list_item (list_marker_minus) @list_task))
  )
  ]])
  local links = {}
  for id, captures, _ in query:iter_matches(root, bufnr, start_line, end_line) do
    local node = captures[id]
    table.insert(links, node)
  end
  return links
end

return M
