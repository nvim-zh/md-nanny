local tools       = require('md-nanny.utils.query')
local highlight   = require('md-nanny.core.highlight')
local break_query = require('md-nanny.element_query.thematic_break_query')
local config      = require('md-nanny.core.config')
local api         = vim.api
local fn          = vim.fn
local ns_id       = api.nvim_create_namespace('md_break')

local M = {}
function M.syntax_break_symbol(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  local break_node = break_query.get_break_query(bufnr, start_line, end_line)
  for key, node in pairs(break_node) do
    local row, col = node:start()
    api.nvim_buf_set_extmark(bufnr, ns_id, row, col, {
      virt_text = { { string.rep(config.Break.symbol, fn.winwidth(fn.bufwinnr(bufnr))), config.Break.hl_group } },
      virt_text_pos = 'overlay'
    })
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
        highlight.hl_util()
        M.syntax_break_symbol(opts.buf)
      end
    })
  end
end

return M
