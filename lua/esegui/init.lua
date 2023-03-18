local utili = require('esegui.utili')

local _DEFAULT_BUF_OPTIONS = {bufhidden = "wipe"}
local _DEFAULT_WIN_OPTIONS = {}

vim.keymap.set('n', '<leader>x', function() utili.esegui() end)
vim.api.nvim_create_user_command("Esegui", function() utili.esegui() end, {})
