require('md-nanny.core.title').start(true)
require('md-nanny.core.codeblock').setup(true)
vim.o.conceallevel = 2

---------------
-- local ns_id = vim.api.nvim_create_namespace("test")
-- local buf = vim.api.nvim_get_current_buf()
-- vim.api.nvim_buf_set_extmark(buf, ns_id, 0, 0, {
--   id = 1,
--   end_col = 1,
--   conceal = 'A'
-- })
