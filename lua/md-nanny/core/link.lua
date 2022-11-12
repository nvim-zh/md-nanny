local link_queue = require('md-nanny.treesitter_utils.link_query')
local tools = require('md-nanny.utils.query')
local q = require('vim.treesitter.query')
local M = {}


function M.syntax_link_todo(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  links = link_queue.get_link_nodes(bufnr, start_line, end_line)
  for key, value in pairs(links) do
    vim.notify(q.get_node_text(value, bufnr))
  end
end

return M
