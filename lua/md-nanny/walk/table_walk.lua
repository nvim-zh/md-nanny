local q = require('vim.treesitter.query')
local M = {}

--- 获取表格对题数据
---@param node
---@param data
---@param bufnr
function M.get_heading_data(node, data, bufnr)
  for n in node:iter_children() do
    if n:type() == 'pipe_table_cell' then
      local text = q.get_node_text(n, bufnr)
      text = string.gsub(text, ' +$', '')
      table.insert(data.heading, text)
    end
  end
end

--- 获取表格对齐方式
---@param node
---@param data
---@param bufnr
function M.get_table_align(node, data, bufnr)
  for i = 0, node:child_count() - 1 do
    local n = node:child(i)
    if n:type() == 'pipe_table_delimiter_cell' then
      local opts = { left = false, right = false }
      if n:child(0):type() == 'pipe_table_align_left' then
        opts.left = true
      end
      if n:child(n:child_count() - 1):type() == 'pipe_table_align_right' then
        opts.right = true
      end
      table.insert(data.align, opts)
    end
  end
end

--- 获取表格中的数据
---@param node
---@param data
---@param bufnr
function M.get_table_row(node, data, bufnr)
  local opts = {}
  for i = 0, node:child_count() - 1 do
    local n = node:child(i)
    if n:type() == 'pipe_table_cell' then
      local text = q.get_node_text(n, bufnr)
      text = string.gsub(text, ' +$', "")
      table.insert(opts, text)
    end
  end
  table.insert(data.data, opts)
end

--- 获取表格的col中字符串最长的一行
---@param data
---@return : max size
function M.get_table_max_size_row(col, data)
  local max = string.len(data.heading[col])
  for i = 1, #data.data do
    local da = data.data[i]
    if da[col] ~= nil then
      local size = string.len(da[col])
      if max < size then
        max = size
      end
    end
  end
  return max
end

--- 对列中的str按对齐方式格式化
---@param str
---@param left
---@param right
---@param maxlen
---@return
function M.format_table_row(str, left, right, maxlen)
  local text
  local len = string.len(str)
  if left and right then
    -- 居中显示
    local left_len = math.floor((maxlen - len) / 2) + 1
    local right_len = math.ceil((maxlen - len) / 2) + 1
    text = string.rep(" ", left_len) .. str .. string.rep(" ", right_len)
  elseif right then
    -- 右对齐
    text = string.rep(" ", maxlen - len + 1) .. str .. " "
  else
    -- 左对齐
    text = " " .. str .. string.rep(" ", maxlen - len + 1)
  end
  return text
end

return M
