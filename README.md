# dotfiles

My configuration for neovim, vscode etc.

## VSCode

* <vscode_path> in **Windows**: ```C:\Users\<your_username>\AppData\Roaming\Code\User\```
* <vscode_path> in **Linux**: ```/home/<your_username>/.config/Code/User/```

1. Install VSCode
2. Clone this repo in your projects folder
3. ln -s /<your_projects_folder>/dotfiles/vscode/settings.json /<vscode_path>/settings.json
4. ln -s /<your_projects_folder>/dotfiles/vscode/keybindings.json /<vscode_path>/keybindings.json
5. ln -s /<your_projects_folder>/dotfiles/vscode/snippets /<vscode_path>/snippets

## Neovim

### Setup

1. Install neovim
2. Clone this repo in your projects folder
3. ln -s /<your_projects_folder>/dotfiles/init.vim /home/<your_username>/.config/nvim/init.vim
4. Install https://github.com/BurntSushi/ripgrep
5. Open neovim and run :PlugInstall to install plugins

### Installing on your RedHat VDI
#### Neovim
This setup has been tested with [Neovim](https://github.com/neovim/neovim) version 0.7.2 so it is recommended to use that if you want it to work.
You can find the specific version here:
https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz

#### Steps to install Neovim
1. Run ```curl -fsSL https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz -o neovim```
2. Untar the file by running: ```tar xzvf nvim-linux64.tar.gz```
3. Run ./nvim-linux64/bin/nvim
4. Move it to .local: ```mv nvim-linux64 ~/.local/nvim```
5. Add ```<your_home>/.local/nvim/bin``` to your Path

#### Ripgrep
[Ripgrep](https://github.com/BurntSushi/ripgrep) is a nice plugin that allows you to search recursively through your files in the neovim interface.
The following version has been tested for this setup:
https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz

#### Steps to install Ripgrep
1. Run ```curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz -o ripgrep```
2. Untar the file by running: ```tar xzvf ripgrep```
3. Move to .local/bin by running: ```mv rg ~/.local/bin```
