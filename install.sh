echo "Creating soft links for top-level dotfiles..."
echo "Current directory: $(pwd)"
set -x
ln -s ${PWD}/.gitconfig         ${HOME}/.gitconfig
ln -s ${PWD}/.pam_environment   ${HOME}/.pam_environment
ln -s ${PWD}/.zplugrc           ${HOME}/.zplugrc
ln -s ${PWD}/.zshrc             ${HOME}/.zshrc
ln -s ${PWD}/.p10k.zsh          ${HOME}/.p10k.zsh
ln -s ${PWD}/.default-packages  ${HOME}/.nvm/default-packages
ln -s ${PWD}/.gitignore_global  ${HOME}/.gitignore_global
echo
echo "Soft links created."
echo
ls ${HOME} -lah | grep '\s\.'