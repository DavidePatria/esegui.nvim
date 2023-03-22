local M = {}

-- in base al linguaggio cosa segnala la radice
M.cose_in_radice = {
      ["rust"] = {},
      ["python"] = {'.git','pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile'},
      ["lua"] = {},
      ["cpp"] = {'.git','CMakeLists.txt'},
}

-- for cmake based project, maybe a way to include specific executable
local function command_cpp()
  return 'make && ./main'
end

local function command_lua()

end

local function command_rust(file)
  return 'cargo run ' .. file
end

local function command_python(file)
  return 'python3 ' .. file
end

-- TODO: sistemare la necesstià di un percorso e non fare più affidamento sulla robustezza di cargo
M.comandi = {
      ["rust"] = command_rust,
      ["python"] = command_python,
      ["lua"] = command_lua,
      ["cpp"] = command_cpp,
}


return M
