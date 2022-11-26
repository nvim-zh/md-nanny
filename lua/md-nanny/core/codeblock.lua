local q = require('vim.treesitter.query')
local code_block_query = require('md-nanny.element_query.codeblock_query')
local tools = require('md-nanny.utils.query')
local mdorg = require('md-nanny.core.mdorg')
local config = require('md-nanny.core.config')
local highlight = require('md-nanny.core.highlight')
local dot_image = require('md-nanny.utils.show_image')
local fn = vim.fn
local api = vim.api
local ns_id = vim.api.nvim_create_namespace('md-codeblaock')

local M = {}

--- 渲染代码块
---@param bufnr
function M.syntax_code_block(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  local code_blocks = code_block_query.get_code_book_scope(bufnr, start_line, end_line)
  for _, code_block in pairs(code_blocks) do
    M.syntax_code_block_symbol(bufnr, code_block)
    M.syntax_code_block_background(bufnr, code_block)
    --if q.get_node_text(code_block:child(1), bufnr) == 'dot' then
    --  M.syntax_code_dot_imger(bufnr, code_block)
    --end
  end
end

--- 渲染流程图图片
---@param bufnr
---@param node
function M.syntax_code_dot_imger(bufnr, node)
  local dot_string = tostring(q.get_node_text(node:child(3), bufnr))
  if not fn.has("python3") then
    vim.notify("no found python3")
    return
  end
  --M.create_dot_image(dot_string)
  local row, col = node:start()
  dot_image.create_dot_image(dot_string, row, col, bufnr, {})
end

--- 设置代码块符号
---@param bufnr
---@param node
function M.syntax_code_block_symbol(bufnr, node)
  local hl = config.codeblock
  local start_row, start_col = node:start()
  local end_row, end_col = node:end_()
  -- symbol line
  local symbol = string.rep(' ', string.len(fn.getline(start_row + 1)))

  -- otps
  local lang = q.get_node_text(node:child(1), bufnr)

  local opts = {
    virt_text = { { hl.symbol.start .. " " .. lang .. symbol, hl.hl_group.symbol } },
    virt_text_pos = 'overlay'
  }

  -- start line
  api.nvim_buf_set_extmark(bufnr, ns_id, start_row, start_col, opts)

  -- end line
  opts.virt_text = { { hl.symbol.end_ .. " " .. symbol, hl.hl_group.symbol } }
  api.nvim_buf_set_extmark(bufnr, ns_id, end_row - 1, end_col, opts)
end

--- 渲染代码块背景
---@param bufnr
---@param node
function M.syntax_code_block_background(bufnr, node)
  local hl = config.codeblock
  local start_row = node:start()
  local end_row = node:end_()
  local text = string.rep(' ', fn.winwidth(fn.bufwinnr(bufnr)))
  local opts = {
    virt_text = { { text, hl.hl_group.code_block } },
    hl_eol = true,
    virt_text_pos = 'overlay',
  }
  for i = start_row, end_row - 1 do
    api.nvim_buf_add_highlight(bufnr, ns_id, hl.hl_group.code_block, i, 0, -1)
    api.nvim_buf_set_extmark(bufnr, ns_id, i, fn.len(fn.getline(i + 1)), opts)
  end
end

--- 快速编辑当前代码块
---@param bufnr
---@param node
function M.edit_current_code_block(bufnr, node)
  mdorg.EditBufferCodeBlock()
end

-- 运行当前代码块
---@param bufnr
---@param node
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
      pattern = { "*.md" },
      callback = function(opts)
        if opts.event == "TextChanged" or opts.event == 'TextChangedI' then
          local start_line, end_line = tools.create_query_scope(opts.buf)
          vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, start_line, end_line)
        end
        if opts.event == 'WinEnter' then
          highlight.hl_util()
        end
        M.syntax_code_block(opts.buf)
      end
    })
  end
end

return M
