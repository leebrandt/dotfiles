export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f ~/.zshrc.mac ] && source ~/.zshrc.mac
else
  [ -f ~/.zshrc.nix ] && source ~/.zshrc.nix
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

unalias gl 2>/dev/null

alias ohmyzsh="nvim ~/.oh-my-zsh"
alias edit="nvim"
alias l="eza -lah"
alias ll="eza -lh"
alias pip="pip3"
alias python="python3"
alias lad="lazydocker"
alias lag="lazygit"
alias dpok="docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -v k8s"
alias sh='print -z $(history | fzf | sed "s/^ *[0-9]* *//")'
alias -- -='cd -'

alias t="tmux"
alias tls="tmux list-sessions"
alias ta="tmux attach"

alias gpod="git push origin develop"
alias gpom="git push origin main"
alias gs="git switch"

alias cd="z"

export EDITOR=nvim
export VISUAL=nvim

cpr() {
  source="$1"
  dest="$2"
  mkdir -p "${dest%/*}"
  cp "$source" "$dest"
}
