local Terminal  = require('toggleterm.terminal').Terminal

return function (opts)
  Terminal:new(opts):toggle()
end
