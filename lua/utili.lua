local M = {}

--==================================================
function M.esegui()

  local radice_repo = (vim.fs.find('.git', {path=vim.fn.expand('%:p:h'), upward=true})[1]):gsub(".git","")
  vim.cmd('tcd ' .. radice_repo)

  -- acquisire tipo per deterinare il comando da eseguire
  local ft = vim.bo.filetype
  -- se il ft è tra quelli registrati, salvare il comando
  local comando = comandi[ft]
  if comando then
    -- un canale valido dovrebbe sempre essere disponibile
    local chan = utili.get_terminal()
    local percorso_file = vim.fn.expand('%:p'):gsub(radice_repo,"")
    -- pulie altrimenti non scorre da solo
    vim.api.nvim_chan_send(chan, 'clear\n')
    vim.api.nvim_chan_send(chan, comando .. percorso_file .. '\n')
  else
    vim.notify("no available commands for " .. ft .. " filetype")
  end
end

--==================================================

function M.get_terminal()
  -- scheda attuale
  local scheda = vim.api.nvim_get_current_tabpage()
  -- tutte le finestre nella scheda per cercarvi il terminale
  local finestre = vim.api.nvim_tabpage_list_wins(scheda)
  local canale = 0

  -- cercare il terminal tramite la presenza dell'opzione chan (channel != 0)
  for _,finestra in pairs(finestre) do
    local bufnr = vim.api.nvim_win_get_buf(finestra)
    canale = vim.api.nvim_buf_get_option(bufnr, "channel")
    -- il canale è non 0 se il buffer è un terminale
    if canale ~= 0 then
      return canale
    end
  end

    -- crea un terminale e restituisce il canale
  print("canale: ",canale)
  if canale == 0 then
    return M.open_term()
  end
end

--==================================================

function M.open_term()
  -- per segnarsi la finestra da cui si parte
  local fin_da = vim.api.nvim_win_get_number(0)
  local fin_da_id = vim.fn.win_getid(fin_da)
  -- this goes automatically to the new split
  vim.cmd "20split | term"
  -- perciò la fienstra attuale è quella nuova
  local winnr = vim.api.nvim_win_get_number(0)

  -- ci si trova sul terminale, prendere il canale
  local canale = vim.api.nvim_buf_get_option(0, "channel")
  -- così non rimane nella lista dei buffer
  vim.api.nvim_buf_set_option(0,"bufhidden", "wipe")
  -- vim.cmd"set bufhidden=wipe"
  -- tornare a quella precedente alla creazione della divisione
  -- così si torna alla finestra dalla quale si è partiti
  vim.api.nvim_set_current_win(fin_da_id)
  return canale
end

--==================================================


return M
