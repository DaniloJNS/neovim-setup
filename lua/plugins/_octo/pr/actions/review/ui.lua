local ui = require('libs.ui')

return function (callback)
    vim.ui.select({"Add", "Remove"}, {
        prompt = "Select command",
        telescope = require("telescope.themes").get_cursor(),
        format_item = function (item)
            return item .. " reviewer"
        end
    }, callback)
end
