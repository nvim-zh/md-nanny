local q = require('vim.treesitter.query')
local code_block_query = require('md-nanny.treesitter_utils.codeblock_query')
local tools = require('md-nanny.utils.query')
local mdorg = require('md-nanny.core.mdorg')
local config = require('md-nanny.core.config')
local highlight = require('md-nanny.core.highlight')
local code_block_walk = require('md-nanny.walk.codeblock_walk')
local api = vim.api
local ns_id = vim.api.nvim_create_namespace('md-codeblaock')

local M = {}

--- 渲染代码块
---@param bufnr
function M.syntax_code_block(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  local code_blocks = code_block_query.get_code_book_scope(bufnr, start_line, end_line)
  for _, code_block in pairs(code_blocks) do
    M.syntax_code_block_symbol(bufnr, code_block, config.codeblock)
  end
end

--- 设置代码块背景色
---@param bufnr
---@param node
function M.syntax_code_block_symbol(bufnr, node, h)
  local start_row, start_col = node:start()
  local end_row, end_col = node:end_()
  local opts = {
    virt_text = { { h.symbol.start, h.highlight.symbol } },
    virt_text_pos = 'overlay'
  }
  -- symbol line
  local symbol_line = code_block_walk.get_max_line(bufnr, node)
  vim.notify(symbol_line)

  -- start line
  api.nvim_buf_set_extmark(bufnr, ns_id, start_row, start_col, opts)

  -- end line
  opts.virt_text = { { h.symbol.end_, h.highlight.symbol } }
  api.nvim_buf_set_extmark(bufnr, ns_id, end_row - 1, end_col, opts)
end

--- 渲染代码块背景
---@param bufnr
---@param node
function M.syntax_code_block_background(bufnr, node)
  vim.notify(bufnr .. node)
end

--- 快速编辑当前代码块
---@param bufnr
---@param start_line
---@param end_line
function M.edit_current_code_block(bufnr, node)
  mdorg.EditBufferCodeBlock()
end

-- 运行当前代码块
---@param bufnr
---@param start_line
---@param end_line
function M.run_current_code_block(bufnr, node)
end

-- 创建代码结果段
---@param bufnr
---@param start_line
function M.set_code_block_results_of(bufnr, start_line)
end

function M.setup(status)
  if status then
    api.nvim_create_autocmd({ 'WinEnter', 'TextChanged', 'TextChangedI' }, {
      callback = function(opts)
        if opts.event == "TextChanged" or opts.event == 'TextChangedI' then
          local start_line, end_line = tools.create_query_scope(opts.buf)
          vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, start_line, end_line)
        end
        if opts.event == 'WinEnter' then
          highlight.hl_code_block()
        end
        M.syntax_code_block(opts.buf)
      end
    })
  end
end

return M
