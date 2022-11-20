local tools = require('md-nanny.utils.query')
local table_query = require('md-nanny.element_query.table_query')
local highlight = require('md-nanny.core.highlight')
local api = vim.api
local fn = vim.fn
local ns_id = api.nvim_create_namespace('table')
local table_walk = require('md-nanny.walk.table_walk')
local q = require('vim.treesitter.query')
local M = {}

--- 渲染表格
---@param bufnr
function M.syntax_tables_symbol(bufnr)
  local start_line, end_line = tools.create_query_scope(bufnr)
  local table_node = table_query.get_table_nodes(bufnr, start_line, end_line)
  for _, node in pairs(table_node) do
    --M.syntax_table_symbol(node)
    M.get_table_data(node, bufnr)
  end
end

--- 获取表格数据
---@param node: 表格的节点
---@return: 返回表格数据
-- {
--   heading = {},
--   align = {{left=bool,right=bool}},
--   data = {}
-- }
function M.get_table_data(node, bufnr)
  local data = { heading = {}, align = {}, data = {} }
  for i = 0, node:child_count() - 1 do
    local n = node:child(i)
    --- 表格标题
    --vim.notify(tostring(n))
    if n:type() == 'pipe_table_header' then
      table_walk.get_heading_data(n, data, bufnr)
    end
    -- 表格对齐
    if n:type() == 'pipe_table_delimiter_row' then
      table_walk.get_table_align(n, data, bufnr)
    end
    -- 表格数据
    if n:type() == 'pipe_table_row' then
      table_walk.get_table_row(n, data, bufnr)
    end
  end
  return data
end

--- 格式化表格
function M.format_table(node, bufnr)
  local tb = M.get_table_data(node, bufnr)
  -- @todo: 格式化表格
end

--- 对表格进行渲染
---@param node
function M.syntax_table_symbol(node, bufnr)

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
        M.syntax_tables_symbol(opts.buf)
      end
    })
  end
end

return M
