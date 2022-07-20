local mappings = require('mappings')

mappings.nkeymap("<space>rq", "<cmd>lua require('plugins._octo.pr.actions.core').call()<CR>")
