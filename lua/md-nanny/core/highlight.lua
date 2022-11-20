local config = require('md-nanny.core.config')
local activity = require('md-nanny.utils.hl').activity
local api = vim.api
local M = {}


local activity_bg = api.nvim_get_hl_by_name("CursorLine", true)["background"]

function M.hl_title()
  for key, value in pairs(config.title) do
    if type(value) == 'table' then
      vim.api.nvim_set_hl(0, value.hl_group, { fg = value.fg, bg = value.bg })
      vim.api.nvim_set_hl(0, activity(value.hl_group),
        { fg = value.fg, bg = activity_bg })
    end
  end
end

function M.set_hl(hl_group, opts)
  vim.api.nvim_set_hl(0, hl_group, opts)
  vim.api.nvim_set_hl(0, activity(hl_group), opts)
end

local codeblock = config.codeblock
local block_quote_marker = config.block_quote_marker
local Break = config.Break
function M.hl_util()
  --- 符号颜色
  M.set_hl(codeblock.hl_group.symbol, { bg = codeblock.symbol.bg, fg = codeblock.symbol.fg })
  --- 代码块背景色
  M.set_hl(codeblock.hl_group.code_block, { bg = codeblock.code_block.bg })
  -- 注释
  M.set_hl(block_quote_marker.hl_group, { bg = block_quote_marker.bg, fg = block_quote_marker.fg })
  -- 分割线
  M.set_hl(Break.hl_group, { bg = Break.bg, fg = Break.fg })
end

function M.init()
  M.hl_title()
  M.hl_util()
end

return M
