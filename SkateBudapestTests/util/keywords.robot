*** Keywords ***
# ******************************************************************************
# G E N E R A L
# ******************************************************************************
Launch app
    Open application    ${APPIUM_SERVER}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    app=${APP}    automationName=${AUTOMATION_NAME}
    Allow permission

Tap on
    [Arguments]    ${element}
    Click element    ${element}

Tap a point
    [Arguments]    ${x}    ${y}
    Click a point    ${x}    ${y}

Navigate back
    Tap a point    40    30

Allow permission
    Tap on    nsp=name=="Allow"

Allow permission once
    Tap on    nsp=name=="Allow Once"

Don't allow permission
    Tap on    nsp=name=="Don’t Allow"

Accept alert
    Tap on    ${ALERT_DIALOG_ACCEPT_BUTTON}

Dismiss alert
    Tap on    ${ALERT_DIALOG_CANCEL_BUTTON}

Input text and close keyboard
    [Arguments]    ${element}    ${text}
    Clear Text    ${element}
    Input text    ${element}    ${text}
    Dismiss keyboard

Dismiss keyboard
    Tap on    ${KEYBOARD_DONE_BUTTON}

Scroll down to the bottom of the screen
    Scroll Down    ${MAIN_APPLICATION}

${element} is selected
    Wait until element is visible    ${element}
    Element attribute should match    ${element}    selected    true

# ******************************************************************************
# S K A T E   M A P
# ******************************************************************************
Switch to map view
    Tap on    ${SKATEMAP_MAP_SEGMENT_VIEW}

Map screen elements are visible
    Wait until element is visible    ${SKATEMAP_MAP_LAYER_BUTTON}
    Element should be visible    ${SKATEMAP_MAP_LOCATION_BUTTON}
    Element should be visible    ${SKATEMAP_FILTER_NAV_BAR_BUTTON}
    Element should be visible    ${SKATEMAP_MAP_SEGMENT_CONTROL}

Map waypoints are visible
    Wait until element is visible    ${SKATEMAP_MAP_WAYPOINT_PIN}

Map waypoints are not visible
    Page should not contain element    ${SKATEMAP_MAP_WAYPOINT_PIN}

Tap on map waypoint
    Tap on    ${SKATEMAP_MAP_WAYPOINT_PIN}

Tap on map waypoint preview
    Sleep     1s    # Wait for animation
    ${pin_location}=    Get element location    ${SKATEMAP_MAP_WAYPOINT_PIN}
    ${pin_preview_location_x}=  Set variable    ${pin_location['x'] + 30}
    ${pin_preview_location_y}=  Set variable    ${pin_location['y'] - 30}

    Tap a point    ${pin_preview_location_x}    ${pin_preview_location_y}

# ******************************************************************************
# S K A T E   L I S T
# ******************************************************************************
Switch to list view
    Tap on    ${SKATEMAP_LIST_SEGMENT_VIEW}

List screen elements are visible
    Wait until page contains element    ${SKATEMAP_LIST_TABLEVIEW}
    Element should be visible    ${SKATEMAP_FILTER_NAV_BAR_BUTTON}
    Element should be visible    ${SKATEMAP_MAP_SEGMENT_CONTROL}

List cells are visible
    Wait until element is visible    ${SKATEMAP_LIST_CELL_CONTAINER_VIEW}
    Element should be visible    ${SKATEMAP_LIST_CELL_TITLE_LABEL}
    Element should be visible    ${SKATEMAP_LIST_CELL_DESCRIPTION_LABEL}
    Page should contain element    ${SKATEMAP_LIST_CELL_THUMBNAIL_IMAGE}

List cells are not visible
    Page should not contain element    ${SKATEMAP_LIST_CELL_CONTAINER_VIEW}
    Page should not contain element    ${SKATEMAP_LIST_CELL_TITLE_LABEL}
    Page should not contain element    ${SKATEMAP_LIST_CELL_DESCRIPTION_LABEL}
    Page should not contain element    ${SKATEMAP_LIST_CELL_THUMBNAIL_IMAGE}

Tap cell from list
    Tap on    ${SKATEMAP_LIST_CELL_CONTAINER_VIEW}

# ******************************************************************************
# P L A C E   D E T A I L S
# ******************************************************************************
Place details screen elements are visible
    Wait until element is visible    ${SKATEMAP_DETAIL_CATEGORY_VIEW}
    Element should be visible    ${SKATEMAP_DETAIL_CATEGORY_LABEL}
    Element should be visible    ${SKATEMAP_DETAIL_DESCRIPTION_LABEL}
    Wait until element is visible    ${SKATEMAP_DETAIL_ENABLE_LOCATION_LABEL}
    Wait until element is visible    ${SKATEMAP_DETAIL_ENABLE_LOCATION_BUTTON}
