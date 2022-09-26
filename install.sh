echo "Creating soft links for top-level dotfiles..."
ln -s ./.gitconfig ~/.gitconfig
ln -s ./.pam_environment ~/.pam_environment
ln -s ./.zplugrc ~/.zplugrc
ln -s ./.zshrc ~/.zshrc
ln -s ./.p10k.zsh ~/.p10k.zsh
ln -s ./.default-packages ~/.nvm/default-packages
nl -s ./.gitignore_global ~/.gitignore_global
echo
echo "Soft links created."
echo
ls ~/ -lah | grep '\s\.'