local config = require('md-nanny.core.config')
local no_activity = require('md-nanny.api.hl').no_activity
local api = vim.api
local M = {}

function M.hl_title()
  for key, value in pairs(config.title) do
    if type(value) == 'table' then
      vim.api.nvim_set_hl(0, value.highlight, { fg = value.fg, bg = value.bg })
      vim.api.nvim_set_hl(0, no_activity(value.highlight),
        { fg = value.fg, bg = api.nvim_get_hl_by_name("Normal", true)["background"] })
    end
  end
end

function M.init()
  M.hl_title()
end

return M
