# 1. Copy last modified version of `SkateBudapest.app` from `DerivedData` to the `app folder`
# 2. Execute Robot tests on Siumulator

APP_SOURCE_FILE=$(find ~/Library/Developer/Xcode/DerivedData/ -name "SkateBudapest.app" -exec ls -dt {} + | head -n 1)
APP_DEST_DIR=app
OUTPUT_DIR=report

cd "$(dirname "$0")"
cp -fR $APP_SOURCE_FILE $APP_DEST_DIR

robot --outputdir $OUTPUT_DIR testcases.robot