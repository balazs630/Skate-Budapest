*** Keywords ***
Launch App
    Open Application  ${APPIUM_SERVER}  platformName=${PLATFORM_NAME}  platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}  app=${APP}  automationName=appium  appPackage=${APP_PACKAGE}

Allow Location Permission
    Click Element  nsp=name=="Allow"

Don't Allow Location Permission
    Click Element  nsp=name=="Don’t Allow"