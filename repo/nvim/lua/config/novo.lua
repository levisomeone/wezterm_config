-- :Novo <pasta> <arquivo>  -> cria ~/projetos/<pasta>/<arquivo> e abre
-- Espaço n n               -> pergunta a pasta e o arquivo
local base = vim.fn.expand("~") .. "/projetos"

local templates = {
  c = {
    "#include <stdio.h>",
    "",
    "int main(void) {",
    '    printf("Ola, mundo!\\n");',
    "    return 0;",
    "}",
  },
  py = {
    "def main():",
    '    print("Ola, mundo!")',
    "",
    "",
    'if __name__ == "__main__":',
    "    main()",
  },
}

local function novo(pasta, arquivo)
  local dir = base .. "/" .. pasta
  vim.fn.mkdir(dir, "p")
  vim.cmd("cd " .. vim.fn.fnameescape(dir))

  local path = dir .. "/" .. arquivo
  local existia = vim.uv.fs_stat(path) ~= nil
  vim.cmd("silent! %bwipeout")
  vim.cmd("edit " .. vim.fn.fnameescape(path))

  if not existia then
    local ext = arquivo:match("%.(%w+)$")
    if ext and templates[ext] then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, templates[ext])
      vim.cmd("write")
    end
  end
  print("Projeto: " .. dir)
end

vim.api.nvim_create_user_command("Novo", function(opts)
  if #opts.fargs < 2 then
    print("Uso: :Novo <pasta> <arquivo>")
    return
  end
  novo(opts.fargs[1], opts.fargs[2])
end, { nargs = "*" })

vim.keymap.set("n", "<leader>nn", function()
  vim.ui.input({ prompt = "Pasta (ex: c/ola): " }, function(pasta)
    if not pasta or pasta == "" then return end
    vim.ui.input({ prompt = "Arquivo (ex: main.c): " }, function(arquivo)
      if not arquivo or arquivo == "" then return end
      novo(pasta, arquivo)
    end)
  end)
end, { desc = "Novo projeto" })
