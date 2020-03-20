### 1. Build the application for the right Simulator device, specified in `configuration/appium.robot`
cd "$(dirname "$0")"
cd ..

xcrun xcodebuild \
  -workspace 'SkateBudapest.xcworkspace' \
  -scheme 'SkateBudapest Development' \
  -configuration 'Debug' \
  -destination 'platform=iOS Simulator,name=iPhone 6s,OS=12.4' \

### 2. Copy last modified version of `SkateBudapest.app` from `DerivedData` to the `app` folder
APP_SOURCE_FILE=$(find ~/Library/Developer/Xcode/DerivedData/ -name "SkateBudapest.app" -exec ls -dt {} + | head -n 1)
APP_DEST_DIR=app
OUTPUT_DIR=report

cd SkateBudapestTests/
cp -fR $APP_SOURCE_FILE $APP_DEST_DIR

### 3. Execute Robot tests on Simulator
robot --outputdir $OUTPUT_DIR testsuites