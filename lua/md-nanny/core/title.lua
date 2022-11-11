local api = vim.api
local tools = require('md-nanny.utils.query')
local config = require('md-nanny.core.config')
local highlight = require('md-nanny.core.highlight')
local ns_id = vim.api.nvim_create_namespace('md_title')
--local q = require("vim.treesitter.query")

local M = {}
-- syntax title
function M.syntax_title(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  local titles = require("md-nanny.treesitter_utils.title_query").get_title_nodes_pos(bufnr, start_line,
    end_line)
  for _, title in pairs(titles) do
    local s_row, s_col = title.scope:start()
    local key = title.symbol:type()
    M.set_extmark(bufnr, s_row, s_col, config.title[key])
  end
end

--- set title virt_text
function M.set_extmark(bufnr, row, col, h)
  local opts = {
    virt_text = { { h.symbol, h.highlight } },
    virt_text_pos = 'overlay'
  }
  vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col, opts)
end

--- start title syntax
function M.start(v)
  vim.notify("title")
  if v then
    api.nvim_create_autocmd({ 'WinEnter', 'TextChanged', 'TextChangedI' }, {
      callback = function(opts)
        if opts.event == "TextChanged" or opts.event == 'TextChangedI' then
          local start_line, end_line = tools.create_query_scope(opts.buf)
          vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, start_line, end_line)
        end
        if opts.event == 'WinEnter' then
          highlight.hl_title()
        end
        M.syntax_title(opts.buf)
      end
    })
  end
end

return M
