#!/usr/bin/env bash
#
# nvim-config installer
# ---------------------
# Deploys this LazyVim configuration into ~/.config/nvim, backing up any
# existing config, then syncs plugins headlessly.
#
# Usage:
#   ./install.sh            # back up existing config, deploy, sync plugins
#   ./install.sh --symlink  # symlink files instead of copying
#   ./install.sh --no-sync  # deploy only, skip headless plugin sync
#   ./install.sh --dry-run  # print actions, change nothing
#
# Safe to re-run: an existing ~/.config/nvim is backed up first.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
REPO_DIR="$SCRIPT_DIR"
DEST="${NVIM_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/nvim}"

DRY_RUN=0; SYMLINK=0; SYNC=1
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --symlink) SYMLINK=1 ;;
    --no-sync) SYNC=0 ;;
    -h|--help) sed -n '2,18p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

if [ -t 1 ]; then
  B=$'\033[1;34m'; Y=$'\033[1;33m'; R=$'\033[1;31m'; G=$'\033[1;32m'; Z=$'\033[0m'
else B=""; Y=""; R=""; G=""; Z=""; fi
log()  { printf '%s==>%s %s\n'  "$B" "$Z" "$*"; }
ok()   { printf '%s ok %s %s\n' "$G" "$Z" "$*"; }
warn() { printf '%sWARN%s %s\n' "$Y" "$Z" "$*" >&2; }
die()  { printf '%sERR %s %s\n' "$R" "$Z" "$*" >&2; exit 1; }
run()  { if [ "$DRY_RUN" = 1 ]; then printf '  [dry-run] %s\n' "$*"; else eval "$@"; fi; }

# Top-level entries to deploy (everything tracked except repo meta / this script)
EXCLUDE=(".git" ".gitignore" "install.sh" "README.md" "LICENSE")

# --- prerequisites --------------------------------------------------------
log "Checking prerequisites"
command -v git  >/dev/null 2>&1 || die "git not found — install git first."
command -v nvim >/dev/null 2>&1 || warn "nvim not found — install Neovim (>=0.9) to use this config."
[ -f "$REPO_DIR/init.lua" ] || die "init.lua not found next to installer: $REPO_DIR"
ok "found LazyVim config source"

# --- back up existing config ----------------------------------------------
if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  BACKUP="$DEST.bak-$(date +%Y%m%d-%H%M%S)"
  log "Backing up existing $DEST -> $BACKUP"
  run "mv '$DEST' '$BACKUP'"
  ok "backup created"
fi
run "mkdir -p '$DEST'"

# --- deploy ---------------------------------------------------------------
log "Deploying config -> $DEST"
shopt -s dotglob nullglob
for src in "$REPO_DIR"/*; do
  name="$(basename "$src")"
  skip=0; for e in "${EXCLUDE[@]}"; do [ "$name" = "$e" ] && skip=1; done
  [ "$skip" = 1 ] && continue
  if [ "$SYMLINK" = 1 ]; then
    run "ln -sfn '$src' '$DEST/$name'"
  else
    run "cp -a '$src' '$DEST/$name'"
  fi
  printf '  + %s\n' "$name"
done
shopt -u dotglob nullglob
ok "config deployed"

# --- headless plugin sync -------------------------------------------------
if [ "$SYNC" = 1 ] && [ "$DRY_RUN" = 0 ] && command -v nvim >/dev/null 2>&1; then
  log "Syncing plugins (headless Lazy sync — first run may take a minute)"
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "headless sync returned non-zero (open nvim; Lazy will finish on start)"
  ok "plugins synced"
else
  [ "$SYNC" = 0 ] && warn "skipping plugin sync (--no-sync)"
fi

echo
ok "nvim-config installed."
cat <<EOF

Next steps:
  - Launch: nvim   (LazyVim installs any remaining plugins + Mason tools on first start)
  - A Nerd Font is recommended for icons.
Config lives at: $DEST
EOF
