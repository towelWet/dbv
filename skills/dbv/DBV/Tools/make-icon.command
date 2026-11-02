#!/bin/zsh
# make-icon.command — rasterize AppIcon-src.svg into AppIcon.icns via the standard
# macOS iconset pipeline (rsvg-convert per size, then iconutil packs the .icns).
# Run this whenever AppIcon-src.svg changes; build.command just copies the .icns.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SVG="$ROOT/AppIcon-src.svg"
ICONSET="$ROOT/AppIcon.iconset"

rm_target() { [ -e "$1" ] && mv "$1" "$HOME/.Trash/$(basename "$1")-$(date +%s)" || true; }
rm_target "$ICONSET"
rm_target "$ROOT/AppIcon.icns"
mkdir -p "$ICONSET"

# Required iconset members: 10 sizes, standard + @2x naming.
for spec in "16:icon_16x16" "32:icon_16x16@2x" "32:icon_32x32" "64:icon_32x32@2x" \
            "128:icon_128x128" "256:icon_128x128@2x" "256:icon_256x256" \
            "512:icon_256x256@2x" "512:icon_512x512" "1024:icon_512x512@2x"; do
  size="${spec%%:*}"
  name="${spec##*:}"
  rsvg-convert -w "$size" -h "$size" "$SVG" -o "$ICONSET/$name.png"
done

iconutil -c icns "$ICONSET" -o "$ROOT/AppIcon.icns"
echo "Built: $ROOT/AppIcon.icns"
