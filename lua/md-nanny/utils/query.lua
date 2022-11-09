local M = {}
local fn = vim.fn
--- return: query scope

function M.create_query_scope(bufnr)
  local bufwin = fn.bufwinnr(bufnr) -- cur win
  local cur_line = fn.line('.', fn.win_getid(bufwin)) -- cur pos
  local value_range = fn.winheight(bufwin)
  local start_line = (cur_line - value_range) >= 0 and cur_line - value_range or 0
  local end_line = (cur_line + value_range) >= fn.line('$', fn.win_getid(bufwin)) and cur_line + value_range or
      fn.line('$', fn.win_getid(bufwin))
  return start_line, end_line
end

function M.Smarthl(bufnr, line, hl)
  local bufwin = fn.bufwinnr(bufnr)
  if fn.line('.', fn.win_getid(bufwin)) == line then
  else
    return hl
  end
end

return M
