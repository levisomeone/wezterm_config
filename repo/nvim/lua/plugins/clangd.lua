-- Usa o clangd do PATH e o gcc do MSYS2 para achar stdio.h e cia.
-- Ajuste o caminho do gcc em --query-driver se o seu for diferente.
return {
  { "neovim/nvim-lspconfig", opts = { servers = { clangd = {
    mason = false,
    cmd = { "clangd", "--background-index", "--header-insertion=iinfo", "--query-driver=C:/msys64/mingw64/bin/gcc.exe" },
  } } } },
}
