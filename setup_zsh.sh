sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp alanpeabody.zsh-theme ~/.oh-my-zsh/themes/
cp zshrc ~/.zshrc
chsh -s $(which zsh)
./pyenv_config.sh
