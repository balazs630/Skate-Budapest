*** Keywords ***
Launch app
    Open Application  ${APPIUM_SERVER}  platformName=${PLATFORM_NAME}  platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}  app=${APP}  automationName=appium  appPackage=${APP_PACKAGE} autoAcceptAlerts=true

Tap on
    [Arguments]  ${element}
    Click element  ${element}

Tap a point
    [Arguments]  ${x}  ${y}
    Click a point  ${x}  ${y}

Navigate back
    Tap a point  40  30

Allow permission
    Tap on  nsp=name=="Allow"

Don't allow permission
    Tap on  nsp=name=="Don’t Allow"