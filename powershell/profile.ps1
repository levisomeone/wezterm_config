# Perfil do PowerShell 7  ($PROFILE)

# Prompt (Starship)
Invoke-Expression (&starship init powershell)

# Visual e usabilidade
Import-Module Terminal-Icons
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -Colors @{ InlinePrediction = '#565f89' }
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Atalhos estilo Linux
function ll { Get-ChildItem -Force @args }
function la { Get-ChildItem -Force -Hidden @args }
function touch { param($f) if (Test-Path $f) { (Get-Item $f).LastWriteTime = Get-Date } else { New-Item $f -ItemType File | Out-Null } }
function which { param($c) (Get-Command $c).Source }
function .. { Set-Location .. }
Set-Alias vim nvim
Set-Alias vi nvim

# ---- Tela de boas-vindas (imagem + fastfetch) ----

# Desenha a imagem (WezTerm imgcat)
function ffimg {
  $wz = (Get-Command wezterm -ErrorAction SilentlyContinue).Source
  if (-not $wz) { $wz = "C:\Program Files\WezTerm\wezterm.exe" }
  & $wz imgcat --width 38 --height 19 "$HOME\Pictures\image_neofetchlike.png"
}

# Imagem à esquerda e informações do fastfetch ao lado
function ff {
  [Console]::OutputEncoding = [Text.UTF8Encoding]::new()
  $e = [char]27
  $col = 42   # coluna onde começa o texto (imagem de 38 colunas + 3 de espaço)
  Clear-Host
  ffimg
  $global:FFHist = (Get-History).Count
  $lines = @(fastfetch -c "$HOME\.config\fastfetch\config.jsonc" --logo none --pipe false)
  $row = 1
  foreach ($l in $lines) {
    Write-Host -NoNewline "${e}[${row};${col}H$l"
    $row++
  }
  # cursor abaixo do bloco, com ~2 cm de espaço antes do prompt
  $fim = [Math]::Max($row, 20) + 3
  Write-Host -NoNewline "${e}[${fim};1H"
}

# O nvim usa tela alternativa e a imagem some ao sair; redesenha só a imagem
function nvim {
  $exe = (Get-Command nvim.exe -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1).Source
  & $exe @args
  if (-not $env:NVIM -and ((Get-History).Count - $global:FFHist) -le 2) {
    $e = [char]27
    Write-Host -NoNewline "${e}7${e}[1;1H"
    ffimg
    Write-Host -NoNewline "${e}8"
  }
}

if (-not $env:NVIM) { ff }
