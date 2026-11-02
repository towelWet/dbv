#!/bin/zsh
# Build DBV and install to /Applications/DBV.app.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$ROOT/dbv-swift-env.sh"
BUILD="$SWIFT_BUILD_DIR/arm64-apple-macosx/release"
APP="/Applications/DBV.app"

echo "== generate format registry =="
cd "$ROOT"
python3 "$ROOT/Tools/generate-format-registry.py"

echo "== swift build (release, arm64) TMPDIR=$TMPDIR =="
swift build -c release --arch arm64 --build-path "$SWIFT_BUILD_DIR"

echo "== assemble app bundle =="
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp "$BUILD/DBV" "$APP/Contents/MacOS/"
cp "$ROOT/Tools/Info.plist" "$APP/Contents/Info.plist"
cp "$ROOT/Tools/AppIcon.icns" "$APP/Contents/Resources/AppIcon.icns"
printf 'APPL????' > "$APP/Contents/PkgInfo"
find "$APP" -name '._*' -delete 2>/dev/null || true
/usr/bin/xattr -cr "$APP" 2>/dev/null || true
/usr/bin/codesign --force --sign - --entitlements "$ROOT/Tools/DBV.entitlements" "$APP"

/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$APP"
duti -s com.TowelWare.DBV .jsonl all 2>/dev/null || true

echo "== verify =="
codesign -vv "$APP"
file "$APP/Contents/MacOS/DBV"
stat -f "%Sm %z bytes" "$APP/Contents/MacOS/DBV"
echo "Installed: $APP"
