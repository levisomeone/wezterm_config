# Meu terminal no Windows

Configuração do meu ambiente de programação em **C** e **Python** no Windows: terminal com estética de Linux (Tokyo Night), painéis divididos, tela de boas-vindas estilo neofetch e Neovim configurado para trabalhar direto do terminal.

![preview](assets/preview.png)

## O que tem aqui

| Pasta | Conteúdo |
|---|---|
| `wezterm/` | Configuração do WezTerm: tema Tokyo Night, barra de abas estilo powerline, painéis e atalhos |
| `powershell/` | Perfil do PowerShell: prompt, ícones, sugestões, aliases e o comando `ff` |
| `starship/` | Prompt em duas linhas com `λ`, git e versão da linguagem |
| `fastfetch/` | Tela de informações do sistema ao lado de uma imagem, com status do WampServer e do meu site |
| `nvim/` | Neovim (LazyVim): LSP para C e Python, formatação ao salvar, tela inicial própria e o comando `:Novo` |
| `assets/` | Imagem usada no fastfetch e prints |

## Recursos

- **WezTerm** com Tokyo Night, fonte JetBrains Mono, abas no topo com relógio e bateria, e painéis divididos
- **Neofetch próprio**: informações agrupadas por cor, imagem ao lado e indicadores `●` verde/branco para o WampServer e para o site na Vercel
- **Neovim para C e Python**: autocomplete, erros em tempo real, formatação automática (`clang-format` e `ruff`), árvore de arquivos e depurador
- **Criação rápida de projetos** dentro do nvim com `:Novo pasta arquivo`, que cria a pasta, abre o arquivo e já coloca um modelo básico
- **`F5`** compila e roda o arquivo atual em um painel embaixo (C com `gcc`, Python com `python`)

## Requisitos

```powershell
winget install wez.wezterm Microsoft.PowerShell Neovim.Neovim Git.Git Starship.Starship Fastfetch-cli.Fastfetch BurntSushi.ripgrep.MSVC Python.Python.3.12 OpenJS.NodeJS.LTS MSYS2.MSYS2
```

O compilador `gcc` vem do MSYS2 (toolchain `mingw-w64-x86_64-toolchain`) e precisa estar no `PATH`. O Node.js é usado pelo Mason para instalar alguns servidores de linguagem.

## Instalação

```powershell
# 1. Base do Neovim (LazyVim), só se ainda não tiver
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

# 2. Este repositório
git clone https://github.com/SEU_USUARIO/NOME_DO_REPO.git
cd NOME_DO_REPO
.\install.ps1

# 3. Módulos do PowerShell
Install-Module Terminal-Icons -Scope CurrentUser -Force
```

O script copia cada arquivo para o lugar certo e guarda uma cópia das configurações antigas em `~\.config-backup-<data>`. Se o PowerShell bloquear a execução, rode antes:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Depois feche e abra o WezTerm. Na primeira abertura do `nvim`, os plugins são baixados sozinhos. Espere terminar, feche e abra de novo.

## Atalhos do WezTerm

| Atalho | Ação |
|---|---|
| `Alt+d` / `Alt+s` | Dividir ao lado / embaixo |
| `Alt+setas` | Mudar de painel |
| `Alt+r` + setas | Redimensionar painel (`Esc` sai) |
| `Alt+z` | Zoom no painel |
| `Alt+w` | Fechar painel |
| `Alt+t` | Nova aba |
| `Alt+n` / `Alt+p` | Próxima / anterior aba |
| `Alt+1` a `Alt+9` | Ir direto para a aba |
| `Alt+e` | Layout de programação com o nvim aberto |

## Neovim

| Atalho / comando | Ação |
|---|---|
| `:Novo c/ola main.c` | Cria `~\projetos\c\ola\main.c` com modelo e abre |
| `Espaço n n` | O mesmo, perguntando a pasta e o arquivo |
| `Espaço e` | Árvore de arquivos |
| `Espaço Espaço` | Buscar arquivo |
| `Espaço /` | Buscar texto no projeto |
| `Espaço c f` | Formatar (também formata ao salvar) |
| `gd` / `K` | Ir à definição / ver documentação |
| `F5` | Compilar e rodar |

## Personalização

- **Cores:** a paleta fica no começo do `wezterm/.wezterm.lua` (tabela `c`) e no `starship/starship.toml`
- **Informações do neofetch:** edite `fastfetch/config.jsonc`; cada módulo é uma linha
- **Status de serviços:** o `fastfetch/status.ps1` checa uma porta local ou uma URL. Troque a porta do WampServer e o endereço do site no `config.jsonc`
- **Imagem:** substitua `assets/image_neofetchlike.png` mantendo o nome, ou ajuste `--width` e `--height` em `ffimg` no perfil do PowerShell

## Problemas conhecidos

- A imagem do `ff` é desenhada pelo `wezterm imgcat` e some quando a janela é redimensionada ou depois de sair do nvim (limitação do ConPTY do Windows). O perfil recoloca a imagem sozinho ao fechar o nvim, e o comando `ff` redesenha tudo.
- O `F5` para C usa `gcc`. Sem ele, cai para `clang`, que no Windows precisa das bibliotecas do MSYS2 para achar o `stdio.h`.

## Créditos

- Ilustração do fastfetch: *(coloque aqui o crédito do artista e o link da fonte)*
- [WezTerm](https://wezterm.org), [Neovim](https://neovim.io), [LazyVim](https://www.lazyvim.org), [Starship](https://starship.rs), [fastfetch](https://github.com/fastfetch-cli/fastfetch) e a paleta [Tokyo Night](https://github.com/folke/tokyonight.nvim)
