# dotfiles

My configuration for neovim, vscode etc.

## VSCode

* <vscode_path> in **Windows**: ```C:\Users\<your_username>\AppData\Roaming\Code\User\```
* <vscode_path> in **Linux**: ```/home/<your_username>/.config/Code/User/```

1. Install VSCode
2. Clone this repo in your projects folder
3. Run ```ln -s /<your_projects_folder>/dotfiles/vscode/settings.json /<vscode_path>/settings.json```
4. Run ```ln -s /<your_projects_folder>/dotfiles/vscode/keybindings.json /<vscode_path>/keybindings.json```
5. Run ```ln -s /<your_projects_folder>/dotfiles/vscode/snippets /<vscode_path>/snippets```

## Neovim

Lua config for Neovim 0.12+, using lazy.nvim. Plugins are pinned in `nvim/lazy-lock.json`.

### Setup

1. Install Neovim 0.12 or newer, plus the tools it uses: `brew install neovim ripgrep fd tree-sitter-cli`
2. Clone this repo in your projects folder
3. Run ```ln -s /<your_projects_folder>/dotfiles/nvim ~/.config/nvim```
4. Open Neovim. lazy.nvim installs the plugins, and Mason installs the language servers (vtsls, eslint, jdtls, lua_ls) on the first file you open.
5. Java: jdtls runs on Homebrew's `openjdk`. Project JDKs are read from `~/.asdf/installs/java` (see `nvim/lua/plugins/lsp.lua`).
