source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

eval "$(mise activate zsh)"
eval $(thefuck --alias)
eval "$(zoxide init zsh)"

export GROFF_NO_SGR=1

export PATH="$(npm bin -g):$PATH"

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/catppuccin-mocha.omp.json)"
