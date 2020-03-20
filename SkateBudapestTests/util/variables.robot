*** Variables ***
## Accessibility IDs:

# ******************************************************************************
# G E N E R A L
# ******************************************************************************
${MAIN_APPLICATION}                                         //XCUIElementTypeApplication
${KEYBOARD_DONE_BUTTON}                                     //XCUIElementTypeToolbar[@name="Toolbar"]//XCUIElementTypeButton[@name="Done"]

${ALERT_DIALOG}                                             //XCUIElementTypeAlert
${ALERT_DIALOG_ACCEPT_BUTTON}                               //XCUIElementTypeAlert//XCUIElementTypeButton[@name="OK"]
${ALERT_DIALOG_CANCEL_BUTTON}                               //XCUIElementTypeAlert//XCUIElementTypeButton[@name="Cancel"]

# ******************************************************************************
# S K A T E   M A P
# ******************************************************************************
${SKATEMAP_MAP_TAB_BAR}                                     skatemap.map.tab.bar
${SKATEMAP_SUBMIT_TAB_BAR}                                  skatemap.submit.tab.bar

${SKATEMAP_MAP_SEGMENT_CONTROL}                             skatemap.map.segment.control
${SKATEMAP_MAP_SEGMENT_VIEW}                                //XCUIElementTypeButton[@name="Map"]
${SKATEMAP_MAP_LAYER_BUTTON}                                skatemap.map.layer.button
${SKATEMAP_MAP_LOCATION_BUTTON}                             skatemap.map.location.button
${SKATEMAP_MAP_WAYPOINT_PIN}                                skatemap.map.waypoint.pin

# ******************************************************************************
# S K A T E   L I S T
# ******************************************************************************
${SKATEMAP_LIST_SEGMENT_VIEW}                               //XCUIElementTypeButton[@name="List"]
${SKATEMAP_LIST_TABLEVIEW}                                  skatemap.list.tableview
${SKATEMAP_LIST_CELL_CONTAINER_VIEW}                        skatemap.list.cell.container.view
${SKATEMAP_LIST_CELL_TITLE_LABEL}                           skatemap.list.cell.title.label
${SKATEMAP_LIST_CELL_DESCRIPTION_LABEL}                     skatemap.list.cell.description.label
${SKATEMAP_LIST_CELL_THUMBNAIL_IMAGE}                       skatemap.list.cell.thumbnail.image

# ******************************************************************************
# P L A C E   D E T A I L S
# ******************************************************************************
${SKATEMAP_DETAIL_TITLE_VIEW}                               skatemap.detail.title.view
${SKATEMAP_DETAIL_CATEGORY_VIEW}                            skatemap.detail.category.view
${SKATEMAP_DETAIL_CATEGORY_LABEL}                           skatemap.detail.category.label
${SKATEMAP_DETAIL_DESCRIPTION_LABEL}                        skatemap.detail.description.label
${SKATEMAP_DETAIL_ENABLE_LOCATION_LABEL}                    skatemap.detail.enable.location.label
${SKATEMAP_DETAIL_ENABLE_LOCATION_BUTTON}                   skatemap.detail.enable.location.button

# ******************************************************************************
# F I L T E R
# ******************************************************************************
${SKATEMAP_FILTER_NAV_BAR_BUTTON}                           skatemap.filter.nav.bar.button
