return function (opts)
  local Terminal  = require('toggleterm.terminal').Terminal

  Terminal.new(opts)

  Terminal:toogle()
end
