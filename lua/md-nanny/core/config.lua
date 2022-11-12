local M = {}
local bg = vim.api.nvim_get_hl_by_name("Normal", true)["background"]
M.filetype = 'markdown'

-- 代码块配置
M.codeblock = {
  symbol = {
    enable = true,
    start = '>',
    end_ = '<',
    bg = '#111019',
    fg = '#64607A'
  },
  code_block = {
    enable = true,
    bg = '#111019',
  },
  highlight = {
    symbol = 'codeblock_symbol',
    code_block = 'codeblock'
  }
}

-- 标题配置
M.title = {
  enable = true,
  atx_h1_marker = {
    fg = '#343A4B',
    bg = bg,
    symbol = '○',
    highlight = 'h1_hi'
  },
  atx_h2_marker = {
    fg = '#343A5B',
    bg = bg,
    symbol = ' ○ ',
    highlight = 'h2_hi',
  },
  atx_h3_marker = {
    fg = '#343A65',
    bg = bg,
    symbol = '  ○ ',
    highlight = 'h3_hi'
  },
  atx_h4_marker = {
    fg = '#343A70',
    bg = bg,
    symbol = '   ○ ',
    highlight = 'h4_hi'
  },
  atx_h5_marker = {
    fg = '#343A85',
    bg = bg,
    symbol = '    ○ ',
    highlight = 'h5_hi'
  },
  atx_h6_marker = {
    fg = '#343A85',
    bg = bg,
    symbol = '     ○ ',
    highlight = 'h6_hi'
  }
}

return M
