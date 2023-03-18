local M = {}

-- in base al linguaggio cosa segnala la radice
local cose_in_radice = {
      ["rust"] = {},
      ["python"] = {},
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
  return 'python3 -i ' .. file
end

-- TODO: sistemare la necesstià di un percorso e non fare più affidamento sulla robustezza di cargo
local comandi = {
      ["rust"] = command_rust,
      ["python"] = command_python,
      ["lua"] = command_lua,
      ["cpp"] = command_cpp,
}


return M
