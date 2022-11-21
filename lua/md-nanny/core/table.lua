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
    M.format_table(node, bufnr)
    M.syntax_table_symbol(node)
  end
end

--- 获取表格数据
-- 返回数据
-- {
--   heading = {},
--   align = {{left=bool,right=bool}},
--   data = {}
-- }
---@param node: 表格的节点
---@return: 返回表格数据
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
---@param node
---@param bufnr
function M.format_table(node, bufnr)
  local tb    = M.get_table_data(node, bufnr)
  local start = node:start()
  local end_  = node:end_()
  local text  = {}
  local s     = ""
  -- 标题
  for i = 1, #tb.heading do
    local size = table_walk.get_table_max_size_row(i, tb)
    local heading = tb.heading[i]
    if i == 1 then
      s = "|" .. table_walk.format_table_row(heading, tb.align[i].left, tb.align[i].right, size) .. "|"
    else
      s = s .. table_walk.format_table_row(heading, tb.align[i].left, tb.align[i].right, size) .. "|"
    end
  end
  table.insert(text, s)
  -- 格式化方式
  for i = 1, #tb.align do
    local size = table_walk.get_table_max_size_row(i, tb)
    local align = tb.align[i]
    local s_ = ""
    if align.left and align.right then
      s_ = " :" .. string.rep("-", size - 2) .. ": "
    elseif align.right then
      s_ = " " .. string.rep("-", size - 1) .. ": "
    else
      s_ = " :" .. string.rep("-", size - 1) .. " "
    end
    if i == 1 then
      s = "|" .. s_ .. "|"
    else
      s = s .. s_ .. "|"
    end
  end
  -- 表格数据
  table.insert(text, s)
  for i = 1, #tb.data do
    for n = 1, #tb.data[i] do
      local size = table_walk.get_table_max_size_row(n, tb)
      local row = tb.data[i][n]
      if n == 1 then
        s = "|" .. table_walk.format_table_row(row, tb.align[n].left, tb.align[n].right, size) .. "|"
      else
        s = s .. table_walk.format_table_row(row, tb.align[n].left, tb.align[n].right, size) .. "|"
      end
    end
    table.insert(text, s)
  end
  api.nvim_buf_set_lines(bufnr, start, end_, false, text)
  return text
end

--- 对表格进行渲染
---@param node
function M.syntax_table_symbol(node, bufnr)
  vim.cmd [[syntax match TabeLine /|/ conceal cchar=│]]
end

function M.setup(status)
  if status then
    api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave' }, {
      pattern = { "*.md" },
      callback = function(opts)
        if opts.event == "TextChanged" or opts.event == 'TextChangedI' then
          local start_line, end_line = tools.create_query_scope(opts.buf)
          vim.api.nvim_buf_clear_namespace(opts.buf, ns_id, start_line, end_line)
        end
        highlight.hl_util()
        M.syntax_tables_symbol(opts.buf)
      end
    })
  end
end

return M
