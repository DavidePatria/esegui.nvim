local utili = require('utili')

local M = {}
-- local percorso = require('comandi')

-- TODO: sistemare la necesstià di un percorso e non fare più affidamento sulla robustezza di cargo
local comandi = {
  ["rust"] = 'cargo run ',
  ["python"] = 'python -i ',
  ["lua"] = 'lua ',
}

--==================================================

local _DEFAULT_BUF_OPTIONS = {bufhidden = "wipe"}
local _DEFAULT_WIN_OPTIONS = {}

--==================================================

-- supponendo ci sia un solo terminale
-- function M.get_terminal()
--   -- local terminal_chans = {}
--   for _, chan in pairs(vim.api.nvim_list_chans()) do
--     if chan["mode"] == "terminal" then
--         -- table.insert(terminal_chans, chan)
--       local id = chan["id"]
--       print(id)
--       return tonumber(chan["id"])
--     end
--   end
-- end

vim.keymap.set('n', '<leader>x', function () M.esegui() end)
vim.api.nvim_create_user_command("Esegui", function () utili.esegui() end, {} )

return M
