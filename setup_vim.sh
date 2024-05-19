curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if ! [ -x "$(command -v node)" ]; then
  curl -sL install-node.vercel.app/lts | bash
fi
python3 -m pip install flake8

cp vimrc ~/.vimrc

vim -c "PlugInstall | PlugUpdate | PlugUpgrade | qa"
vim -c "CocInstall coc-pyright | qa"
vim -c "CocInstall coc-json | qa"

echo "{
    \"pyright.inlayHints.functionReturnTypes\": false,
    \"pyright.inlayHints.variableTypes\": false,
    \"python.linting.enabled\": false
}" > ~/.vim/coc-settings.json
