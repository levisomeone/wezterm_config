# install.ps1 - aplica as configurações deste repositório no Windows
# Uso (PowerShell, dentro da pasta do repositório):  .\install.ps1

$repo   = $PSScriptRoot
$backup = "$HOME\.config-backup-$(Get-Date -Format yyyyMMdd-HHmmss)"
New-Item -ItemType Directory -Force $backup | Out-Null

function Install-File($src, $dst) {
  if (-not (Test-Path $src)) { Write-Warning "Não encontrei $src"; return }
  New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
  if (Test-Path $dst) { Copy-Item $dst (Join-Path $backup (Split-Path $dst -Leaf)) -Force }
  Copy-Item $src $dst -Force
  Write-Host "ok  $dst"
}

Install-File "$repo\wezterm\.wezterm.lua"            "$HOME\.wezterm.lua"
Install-File "$repo\fastfetch\config.jsonc"          "$HOME\.config\fastfetch\config.jsonc"
Install-File "$repo\fastfetch\status.ps1"            "$HOME\.config\fastfetch\status.ps1"
Install-File "$repo\starship\starship.toml"          "$HOME\.config\starship.toml"
Install-File "$repo\assets\image_neofetchlike.png"   "$HOME\Pictures\image_neofetchlike.png"
Install-File "$repo\powershell\profile.ps1"          $PROFILE

# Ajusta o nome de usuário nos caminhos do fastfetch
$cfg = "$HOME\.config\fastfetch\config.jsonc"
if (Test-Path $cfg) {
  $h = $HOME -replace '\\','/'
  (Get-Content $cfg -Raw) -replace 'C:/Users/[^/"]+', $h | Set-Content $cfg -Encoding UTF8
}

# Neovim (init.lua + pasta lua)
$nv = "$env:LOCALAPPDATA\nvim"
if (Test-Path "$repo\nvim") {
  if (Test-Path "$nv\lua") { Copy-Item "$nv\lua" "$backup\nvim-lua" -Recurse -Force }
  New-Item -ItemType Directory -Force $nv | Out-Null
  Copy-Item "$repo\nvim\*" $nv -Recurse -Force
  Write-Host "ok  $nv"
}

Write-Host "`nPronto. Backup das configs antigas em: $backup"
Write-Host "Feche e abra o WezTerm para ver o resultado."
