#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m ✓\033[0m %s\n" "$1"; }
warn()  { printf "\033[1;33m !\033[0m %s\n" "$1"; }

OS="$(uname -s)"

check_stow() {
  if ! command -v stow &>/dev/null; then
    info "Installing GNU Stow..."
    case "$OS" in
      Darwin) brew install stow ;;
      Linux)  sudo pacman -S --noconfirm stow ;;
    esac
    ok "Stow installed"
  else
    ok "Stow already installed"
  fi
}

install_packages() {
  case "$OS" in
    Darwin)
      info "Installing Homebrew packages..."
      if ! command -v brew &>/dev/null; then
        warn "Homebrew not found — install it first: https://brew.sh"
        return
      fi
      brew install --quiet stow tmux neovim lazygit lazydocker mise \
        htop btop gh eza zoxide thefuck fzf ripgrep fd oh-my-posh \
        zsh-syntax-highlighting task 2>/dev/null || true
      brew install --cask ghostty 2>/dev/null || true
      ok "Packages installed"
      ;;
    Linux)
      info "Installing packages..."
      local pkgs=(
        stow tmux neovim lazygit lazydocker htop btop github-cli
        eza zoxide thefuck fzf ripgrep fd oh-my-posh
        zsh-syntax-highlighting task ghostty mise
      )
      for pkg in "${pkgs[@]}"; do
        if ! pacman -Qi "$pkg" &>/dev/null; then
          sudo pacman -S --noconfirm "$pkg" 2>/dev/null || warn "Could not install $pkg (may be in AUR)"
        fi
      done
      if ! command -v mise &>/dev/null; then
        warn "mise not found — install manually: https://mise.jdx.dev"
      fi
      ok "Packages installed"
      ;;
  esac
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    ok "Oh My Zsh installed"
  else
    ok "Oh My Zsh already installed"
  fi
}

stow_packages() {
  local packages=(
    zsh tmux ghostty nvim git oh-my-posh mise lazygit lazydocker
    htop btop gh Code markdownlint task
  )

  if [ "$OS" = "Linux" ]; then
    packages+=(hypr waybar mako swayosd walker omarchy autostart)
  fi

  cd "$DOTFILES_DIR"
  for pkg in "${packages[@]}"; do
    if [ -d "$pkg" ]; then
      info "Stowing $pkg..."
      stow --restow --target="$HOME" "$pkg" 2>/dev/null || {
        warn "Conflict while stowing $pkg — backing up conflicting files"
        stow --adopt --target="$HOME" "$pkg" 2>/dev/null
        git checkout -- "$pkg" 2>/dev/null || true
      }
      ok "$pkg stowed"
    fi
  done
}

setup_local_override() {
  if [ ! -f "$HOME/.zshrc.local" ]; then
    echo "# Machine-local zsh overrides" > "$HOME/.zshrc.local"
    ok "Created ~/.zshrc.local"
  fi
}

main() {
  echo ""
  info "Dotfiles bootstrap — $(uname -srm)"
  echo ""

  check_stow
  install_packages
  install_oh_my_zsh
  stow_packages
  setup_local_override

  echo ""
  ok "Done! Restart your shell or run: exec zsh"
}

main "$@"
