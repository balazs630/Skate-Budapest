*** Keywords ***
# ******************************************************************************
# G E N E R A L
# ******************************************************************************
Launch app
    Open application    ${APPIUM_SERVER}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    app=${APP}    automationName=appium    appPackage=${APP_PACKAGE}
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

Don't allow permission
    Tap on    nsp=name=="Don’t Allow"

Swipe up
    Swipe by percent    50    90    50    10

Swipe right
    Swipe by percent    90    50    10    50

Swipe down
    Swipe by percent    50    10    50    90

Swipe left
    Swipe by percent    10    50    90    50

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
    Wait until element is visible    ${SKATEMAP_LIST_TABLEVIEW}
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
    Wait until element is visible    ${SKATEMAP_DETAIL_TITLE_LABEL}
    Element should be visible    ${SKATEMAP_DETAIL_CATEGORY_VIEW}
    Element should be visible    ${SKATEMAP_DETAIL_CATEGORY_LABEL}
    Element should be visible    ${SKATEMAP_DETAIL_DESCRIPTION_LABEL}
    Wait until element is visible    ${SKATEMAP_DETAIL_ENABLE_LOCATION_LABEL}
    Wait until element is visible    ${SKATEMAP_DETAIL_ENABLE_LOCATION_BUTTON}

# ******************************************************************************
# F I L T E R
# ******************************************************************************

Filter elements are visible
    Wait until element is visible    ${SKATEMAP_FILTER_TITLE_LABEL}
    Element should be visible    ${SKATEMAP_FILTER_SKATESHOP_LABEL}
    Element should be visible    ${SKATEMAP_FILTER_STREETSPOT_LABEL}
    Element should be visible    ${SKATEMAP_FILTER_STREETSPOT_LABEL}
    Element should be visible    ${SKATEMAP_FILTER_SKATEPARK_LABEL}

Filter elements are not visible
    Page should not contain element    ${SKATEMAP_FILTER_TITLE_LABEL}
    Page should not contain element    ${SKATEMAP_FILTER_SKATESHOP_LABEL}
    Page should not contain element    ${SKATEMAP_FILTER_STREETSPOT_LABEL}
    Page should not contain element    ${SKATEMAP_FILTER_SKATEPARK_LABEL}

Tap on filter button
    Tap on    ${SKATEMAP_FILTER_NAV_BAR_BUTTON}

Close filter
    ${screen_vertical_center}=    Get window width
    Tap a point    200    200

Close filter by swipe
    Log    Needs implementation...

Filter turn on all options
    Tap on    ${SKATEMAP_FILTER_SKATESHOP_SWITCH}
    Tap on    ${SKATEMAP_FILTER_STREETSPOT_SWITCH}
    Tap on    ${SKATEMAP_FILTER_SKATEPARK_SWITCH}

Filter turn off all options
    Tap on    ${SKATEMAP_FILTER_SKATESHOP_SWITCH}
    Tap on    ${SKATEMAP_FILTER_STREETSPOT_SWITCH}
    Tap on    ${SKATEMAP_FILTER_SKATEPARK_SWITCH}

Filter options are turned on
    Element attribute should match    ${SKATEMAP_FILTER_SKATESHOP_SWITCH}    selected    true
    Element attribute should match    ${SKATEMAP_FILTER_STREETSPOT_SWITCH}    selected    true
    Element attribute should match    ${SKATEMAP_FILTER_SKATEPARK_SWITCH}    selected    true

Filter options are turned off
    Element attribute should match    ${SKATEMAP_FILTER_SKATESHOP_SWITCH}    selected    false
    Element attribute should match    ${SKATEMAP_FILTER_STREETSPOT_SWITCH}    selected    false
    Element attribute should match    ${SKATEMAP_FILTER_SKATEPARK_SWITCH}    selected    false

Filter save
    Tap on    ${SKATEMAP_FILTER_ACTION_BUTTON}
