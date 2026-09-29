#!/usr/bin/env bash
# Optimize portfolio photos for The Light Pantry (static Netlify site).
#
# Drop a high-quality JPEG into images/inbox/ (or pass paths as args), then run:
#   ./scripts/optimize-images.sh
#   ./scripts/optimize-images.sh images/inbox/people-21.jpg
#
# Writes:
#   images/<name>.jpg          â long edge â¤1600 (lightbox / JPEG fallback)
#   images/full/<name>.webp    â same dimensions, modern format for lightbox
#   images/thumbs/<name>.jpg   â long edge â¤640 for gallery grid / cards
#   images/thumbs/<name>.webp
#
# Then add "images/<name>.jpg" to GALLERIES in index.html.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IMG="$ROOT/images"
INBOX="$IMG/inbox"
THUMBS="$IMG/thumbs"
FULL="$IMG/full"
mkdir -p "$THUMBS" "$FULL" "$INBOX"

FULL_EDGE=1600
THUMB_EDGE=640
FULL_JPEG_Q=85
THUMB_JPEG_Q=72
FULL_WEBP_Q=82
THUMB_WEBP_Q=70

optimize_one() {
  local src="$1"
  local base
  base="$(basename "$src")"
  base="${base%.*}"
  local work="$IMG/.work-$base.jpg"

  convert "$src" -auto-orient -strip -resize "${FULL_EDGE}x${FULL_EDGE}>" -quality "$FULL_JPEG_Q" "$work"
  cp "$work" "$IMG/${base}.jpg"
  cwebp -quiet -q "$FULL_WEBP_Q" "$work" -o "$FULL/${base}.webp"
  convert "$work" -resize "${THUMB_EDGE}x${THUMB_EDGE}>" -quality "$THUMB_JPEG_Q" "$THUMBS/${base}.jpg"
  cwebp -quiet -q "$THUMB_WEBP_Q" "$THUMBS/${base}.jpg" -o "$THUMBS/${base}.webp"
  rm -f "$work"
  echo "ok $base â images/${base}.jpg (+ full webp, thumbs)"
}

if [[ $# -gt 0 ]]; then
  for src in "$@"; do optimize_one "$src"; done
else
  shopt -s nullglob
  files=("$INBOX"/*.{jpg,JPG,jpeg,JPEG,png,PNG})
  if [[ ${#files[@]} -eq 0 ]]; then
    echo "No files in images/inbox/. Pass paths as args, or drop JPEGs into images/inbox/."
    exit 0
  fi
  for src in "${files[@]}"; do
    optimize_one "$src"
  done
fi
