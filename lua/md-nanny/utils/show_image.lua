local api = vim.api
local Image = require('hologram.image')
local hologram = require('hologram')
local M = {}
M.images = {}
function M.create_dot_image(dot_string, row, col, buf, opts)
  headle = vim.loop.spawn('python', {
    args = { '/home/aero/.local/share/nvim/site/pack/packer/start/md-nanny/lua/md-nanny/utils/flow_chat_to_image.py',
      dot_string, '/home/aero/teswt/test.png' }
  },
    vim.schedule(function()
      local img = Image:new('/home/aero/teswt/test.png')
      img:display(row, col, buf, opts)
      headle:close()
    end))
end

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  callback = function(au)
    vim.api.nvim_buf_attach(au.buf, false, {
      on_lines = function(_, buf, tick, first, last)
        hologram.buf_delete_images(buf, first, last)
      end,
      on_detach = function(_, buf)
        hologram.buf_delete_images(buf, 0, -1)
      end
    })
  end
})



return M
