vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  local ft = vim.bo.filetype
  local f = vim.fn.shellescape(vim.fn.expand("%"))
  local out = vim.fn.shellescape(vim.fn.expand("%:r") .. ".exe")
  local cc = vim.fn.executable("gcc") == 1 and "gcc" or "clang"
  if ft == "c" then
    vim.cmd("botright 12split | terminal " .. cc .. " -g -Wall " .. f .. " -o " .. out .. " && " .. out)
  elseif ft == "python" then
    vim.cmd("botright 12split | terminal python " .. f)
  end
end, { desc = "Compilar e rodar" })
