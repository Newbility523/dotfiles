#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-}"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

usage() {
  cat <<EOF
Usage: ./install.sh <profile>

Profiles:
  mac
  linux
  wsl
EOF
}

if [[ -z "$PROFILE" ]]; then
  usage
  exit 1
fi

case "$PROFILE" in
  mac|linux|wsl) ;;
  *)
    echo "Unknown profile: $PROFILE" >&2
    usage
    exit 1
    ;;
esac

backup() {
  local target="$1"

  if [[ -e "$target" || -L "$target" ]]; then
    local backup_target="${target}.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup_target"
    echo "Backed up: $target -> $backup_target"
  fi
}

link_path() {
  local source="$1"
  local target="$2"

  if [[ ! -e "$source" ]]; then
    echo "Missing source: $source" >&2
    exit 1
  fi

  backup "$target"
  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
  echo "Linked: $target -> $source"
}

link_path "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link_path "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_path "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_path "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"

case "$PROFILE" in
  mac)
    echo "Applied mac profile."
    ;;
  linux)
    echo "Applied linux profile."
    ;;
  wsl)
    echo "Applied wsl profile."
    ;;
esac

echo "Dotfiles installed from $DOTFILES_DIR."

