local config = require('md-nanny.core.config')
local activity = require('md-nanny.utils.hl').activity
local api = vim.api
local M = {}

local activity_bg = api.nvim_get_hl_by_name("CursorLine", true)["background"]

function M.hl_title()
  for key, value in pairs(config.title) do
    if type(value) == 'table' then
      vim.api.nvim_set_hl(0, value.highlight, { fg = value.fg, bg = value.bg })
      vim.api.nvim_set_hl(0, activity(value.highlight),
        { fg = value.fg, bg = activity_bg })
    end
  end
end

function M.hl_code_block()
  --- 符号颜色
  vim.api.nvim_set_hl(0, config.codeblock.highlight.symbol,
    { bg = config.codeblock.symbol.bg, fg = config.codeblock.symbol.fg })
  --- 代码块背景色
  vim.api.nvim_set_hl(0, config.codeblock.highlight.code_block, { bg = config.codeblock.code_block.bg })

  --- 活动背景色
  vim.api.nvim_set_hl(0, activity(config.codeblock.highlight.symbol),
    { bg = activity_bg, fg = config.codeblock.symbol.fg })
  vim.api.nvim_set_hl(0, activity(config.codeblock.highlight.code_block), { bg = activity_bg })
end

function M.init()
  M.hl_title()
  M.hl_code_block()
end

return M
