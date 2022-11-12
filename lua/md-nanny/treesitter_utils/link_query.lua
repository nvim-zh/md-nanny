local filetype = require('md-nanny.core.config').filetype
local M = {}

function M.get_link_nodes(bufnr, start_line, end_line)
  ---{{{ 测试
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  start_line = start_line or 0
  end_line = end_line or -1
  ---}}}
end

return M
