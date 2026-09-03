#!/usr/bin/env bash
#
# Rebuild the docs/ website from the game source and publish it to GitHub Pages.
#
#   ./tools/site.sh              build, commit and push
#   ./tools/site.sh --build      build only, don't touch git
#   ./tools/site.sh -m "msg"     build, commit with your own message, push
#
set -euo pipefail

cd "$(dirname "$0")/.."

MSG="Update site"
PUSH=1

while [ $# -gt 0 ]; do
  case "$1" in
    --build|-b) PUSH=0; shift ;;
    -m|--message) MSG="$2"; shift 2 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 1 ;;
  esac
done

PY="${PYTHON:-python3}"
if ! command -v "$PY" >/dev/null 2>&1; then
  echo "python3 not found. In WSL: sudo apt install python3 python3-pip" >&2
  exit 1
fi
if ! "$PY" -c "import PIL" >/dev/null 2>&1; then
  echo "Pillow not found - sprites need it. Installing..." >&2
  "$PY" -m pip install --quiet Pillow || {
    echo "Install it manually: sudo apt install python3-pil" >&2; exit 1; }
fi

echo "==> Building docs/"
"$PY" tools/site/build_site.py

if [ "$PUSH" -eq 0 ]; then
  echo "==> Built. Open docs/index.html in a browser to preview."
  exit 0
fi

if [ -z "$(git status --porcelain docs)" ]; then
  echo "==> No site changes to publish."
  exit 0
fi

echo "==> Publishing"
git add docs
git commit -m "$MSG"
git push

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "==> Pushed to $BRANCH."
echo "    https://lukedaysgrace-dot.github.io/Pokemon-Rage-Blue/"
