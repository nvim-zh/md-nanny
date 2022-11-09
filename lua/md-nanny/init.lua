--require("md-nanny.core.mdorg")
--require('md-nanny.core.markdown').VirMarkDown_start()

local M = {}
function M.setup(opts)
  local config = require('md-nanny.core.config')
  if opts ~= nil and opts ~= {} then
    config = vim.tbl_deep_extend('force', config, opts)
  end
  require('md-nanny.core.highlight').hl_title()
  require('md-nanny.core.title').start(config.title.open)
end

return M
