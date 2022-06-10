vim.g.tokyonight_style = "night" -- The theme comes in three styles, storm, a darker variant night and day.

-- Configure fonts
vim.g.tokyonight_italic_comments = true --Make comments italic
vim.g.tokyonight_italic_keywords = true --Make keywords italic
vim.g.tokyonight_italic_functions = true  --Make functions italic
vim.g.tokyonight_italic_variables = false --Make variables and identifiers italic

--General Configure
vim.g.tokyonight_transparent = false

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

vim.cmd[[colorscheme tokyonight]]
