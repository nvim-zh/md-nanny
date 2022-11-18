local config = require('md-nanny.core.config').todolist
local M = {}
function M.todo_symbol(value)
  for _, v in pairs(config) do
    if value == v.match then
      return v.symbol
    end
  end
end

return M
