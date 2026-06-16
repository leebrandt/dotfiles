#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
DRY_RUN=false

info()  { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
ok()    { printf "\033[1;32m ✓\033[0m %s\n" "$1"; }
warn()  { printf "\033[1;33m !\033[0m %s\n" "$1"; }

OS="$(uname -s)"

check_stow() {
  if ! command -v stow &>/dev/null; then
    if $DRY_RUN; then
      info "[dry-run] Would install GNU Stow"
    else
      info "Installing GNU Stow..."
      case "$OS" in
        Darwin) brew install stow ;;
        Linux)  sudo pacman -S --noconfirm stow ;;
      esac
      ok "Stow installed"
    fi
  else
    ok "Stow already installed"
  fi
}

install_packages() {
  if $DRY_RUN; then
    info "[dry-run] Would install packages (skipping)"
    return
  fi
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
    if $DRY_RUN; then
      info "[dry-run] Would install Oh My Zsh"
    else
      info "Installing Oh My Zsh..."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      ok "Oh My Zsh installed"
    fi
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
      if $DRY_RUN; then
        stow --no --verbose=2 --target="$HOME" "$pkg" 2>&1 | sed 's/^/   /'
        continue
      fi
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
    if $DRY_RUN; then
      info "[dry-run] Would create ~/.zshrc.local"
    else
      echo "# Machine-local zsh overrides" > "$HOME/.zshrc.local"
      ok "Created ~/.zshrc.local"
    fi
  fi
}

integrity_check() {
  if $DRY_RUN; then
    info "[dry-run] Skipping integrity check"
    return
  fi
  info "Running integrity check..."
  local failures=0
  local files=0
  cd "$DOTFILES_DIR"
  while IFS= read -r -d '' f; do
    rel="${f#./}"
    pkg="${rel%%/*}"
    target="${HOME}/${rel#*/}"
    if [ -L "$target" ]; then
      printf "  ✓  %s\n" "$rel"
    else
      printf "  ✗  %s — not a symlink\n" "$rel"
      failures=$((failures + 1))
    fi
    files=$((files + 1))
  done < <(find . -type f -path './*/*' \
    -not -path './.git/*' \
    -not -name '.gitkeep' \
    -not -name '*.png' \
    -not -name '*.jpg' \
    -not -name '*.jpeg' \
    -not -name '*.gif' \
    -not -name '*.ico' \
    -print0)
  if [ "$failures" -gt 0 ]; then
    warn "$failures / $files files are not symlinks"
    exit 1
  else
    ok "All $files files are properly symlinked"
  fi
}

main() {
  for arg in "$@"; do
    case "$arg" in
      -n|--dry-run) DRY_RUN=true ;;
    esac
  done

  echo ""
  info "Dotfiles bootstrap — $(uname -srm)${DRY_RUN:+ (dry-run)}"
  echo ""

  check_stow
  install_packages
  install_oh_my_zsh
  stow_packages
  setup_local_override
  integrity_check

  echo ""
  if $DRY_RUN; then
    warn "Dry-run complete — no changes made"
  else
    ok "Done! Restart your shell or run: exec zsh"
  fi
}

main "$@"
