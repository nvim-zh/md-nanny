local tools = require('md-nanny.utils.query')
local highlight = require('md-nanny.core.highlight')
local config = require('md-nanny.core.config')
local api = vim.api
local ns_id = api.nvim_create_namespace("block")
local M = {}
function M.syntax_block_quote(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  links = require('md-nanny.element_query.block_query').get_block_node(buffer)
  for key, node in pairs(links) do
    local row, col = node:start()
    for i = 0, col do
      api.nvim_buf_set_extmark(bufnr, ns_id, row, i, {
        hl_group = config.block_quote_marker.hl_group,
        end_col = i + 1,
        conceal = config.block_quote_marker.symbol
      })
    end
  end
end

function M.setup(status)
  if status then
    api.nvim_create_autocmd({ 'WinEnter', 'TextChanged', 'TextChangedI' }, {
      pattern = { "*.md" },
      callback = function(opts)
        if opts.event == "TextChanged" or opts.event == 'TextChangedI' then
          local start_line, end_line = tools.create_query_scope(opts.buf)
          vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, start_line, end_line)
        end
        if opts.event == 'WinEnter' then
          highlight.hl_util()
        end
        M.syntax_block_quote(opts.buf)
      end
    })
  end
end

return M
