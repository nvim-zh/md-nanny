local M = {}
local bg = vim.api.nvim_get_hl_by_name("Normal", true)["background"]
M.filetype = 'markdown'

-- 分割线
M.Break = {
  symbol = '─',
  hl_group = "Break",
  fg = '#6E6A86',
  bg = bg
}

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
    bg = '#152329',
  },
  hl_group = {
    symbol = 'codeblock_symbol',
    code_block = 'codeblock'
  }
}

-- link 参数渲染
M.list = {
  fg = "#16161E",
  bg = bg,
  symbol = '',
  hl_group = 'md_list'
}

-- todo list
M.todolist = {
  Undone = {
    match = '[=]',
    symbol = '□',
    fg = '#1AE51A',
    bg = '#0D0F18',
    hl_group = 'todolist_Undone'
  },
  Done = {
    match = '[x]',
    symbol = '',
    fg = '#2E2B55',
    bg = '#0D0F18',
    hl_group = 'todolist_Done'
  }
}

-- block quote symbol
M.block_quote_marker = {
  symbol = '▌',
  fg = '#434C5E',
  bg = bg,
  hl_group = "block_quote_marker"
}

-- 标题配置
M.title = {
  enable = true,
  atx_h1_marker = {
    fg = '#343A4B',
    bg = bg,
    symbol = '○',
    hl_group = 'h1_hi'
  },
  atx_h2_marker = {
    fg = '#343A5B',
    bg = bg,
    symbol = ' ○ ',
    hl_group = 'h2_hi',
  },
  atx_h3_marker = {
    fg = '#343A65',
    bg = bg,
    symbol = '  ○ ',
    hl_group = 'h3_hi'
  },
  atx_h4_marker = {
    fg = '#343A70',
    bg = bg,
    symbol = '   ○ ',
    hl_group = 'h4_hi'
  },
  atx_h5_marker = {
    fg = '#343A85',
    bg = bg,
    symbol = '    ○ ',
    hl_group = 'h5_hi'
  },
  atx_h6_marker = {
    fg = '#343A85',
    bg = bg,
    symbol = '     ○ ',
    hl_group = 'h6_hi'
  }
}

return M
