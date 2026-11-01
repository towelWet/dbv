#!/bin/zsh
# build.command — build DBV from source and install real copy to /Applications/DBV.app.
# Why: SwiftPM alone makes bare binary; this assembles bundle with icon, plist and signature.
# NEVER DELETE COMMENTS — explain every non-obvious line.
# Update comments with the code; do not strip them.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
STAGE="$ROOT/.build/DBV.app"                                # assemble here, install only after signing
cd "$ROOT"
swift build -c release --arch arm64                         # Apple silicon; builds need Swift 6.2; app runs on macOS 14+
mkdir -p "$STAGE/Contents/MacOS" "$STAGE/Contents/Resources"
cp "$ROOT/.build/arm64-apple-macosx/release/DBV" "$STAGE/Contents/MacOS/DBV"
cp "$ROOT/Tools/Info.plist" "$STAGE/Contents/Info.plist"    # names AppIcon as bundle icon
cp "$ROOT/Tools/AppIcon.icns" "$STAGE/Contents/Resources/AppIcon.icns"   # Dock + Finder icon
printf 'APPL????' > "$STAGE/Contents/PkgInfo"
/usr/bin/xattr -cr "$STAGE"                                 # external drives add attrs that break signing
/usr/bin/codesign --force --sign - --entitlements "$ROOT/Tools/DBV.entitlements" "$STAGE"   # ad hoc is enough locally
/usr/bin/ditto "$STAGE" /Applications/DBV.app               # real copy, never symlink into build dir
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f /Applications/DBV.app
echo "Installed: /Applications/DBV.app"
