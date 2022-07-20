local mappings = require('mappings')

mappings.nkeymap("<F5>", ":lua require('dap').continue()<CR>")
mappings.nkeymap("<F1>", ":lua require('dap').step_over()<CR>")
mappings.nkeymap("<F2>", ":lua require('dap').step_into()<CR>")
mappings.nkeymap("<F3>", ":lua require('dap').step_out()<CR>")
mappings.nkeymap("<M-b>", ":lua require('dap').toggle_breakpoint()<CR>")
mappings.nkeymap("<M-B>", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
mappings.nkeymap("<space>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
mappings.nkeymap("<space>dr", ":lua require('dap').repl.open()<CR>")
mappings.nkeymap("<space>dl", ":lua require('dap').run_last()<CR>")
mappings.nkeymap("<space>q", ":lua require('dap').terminate()<CR>")
mappings.nkeymap("<space>td", ":lua require('dap-go').debug_with_args()<CR>")

require('dap-go').setup()
require('dapui').setup()
require('dap-ruby').setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
