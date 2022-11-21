local link_queue = require('md-nanny.element_query.link_query')
local tools = require('md-nanny.utils.query')
local q = require('vim.treesitter.query')
local highlight = require('md-nanny.core.highlight')
local api = vim.api
local ns_id = api.nvim_create_namespace("md-link")
local link_utils = require('md-nanny.utils.link_utils')
local M = {}


--- 渲染link样式
---@param bufnr
function M.syntax_link_todo(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  links = link_queue.get_link_nodes(bufnr, start_line, end_line)
  for key, node in pairs(links) do
    --vim.notify(tostring(q.get_node_text(node, bufnr)))
    local row, col = node:start()
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col, {
      hl_group = 'String',
      end_col = col + 3,
      conceal = link_utils.todo_symbol(tostring(q.get_node_text(node, bufnr)))
    })
    -- @TODO: 支持其他类型代办选项
  end
end

--- 链接跳转
function M.jump_link(bufnr)
end

--- 替换 list 符号
---@param bufnr
function M.syntax_link_minus(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  links = link_queue.get_link_nodes_minus(bufnr, start_line, end_line)
  for key, node in pairs(links) do
    local row, col = node:start()
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col, {
      hl_group = "Comment",
      end_col = col + 1,
      conceal = '•',
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
        if opts.event == 'WinEnter' then
          highlight.hl_util()
        end
        M.syntax_link_todo(opts.buf)
        M.syntax_link_minus(opts.buf)
      end
    })
  end
end

return M
