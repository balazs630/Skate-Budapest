*** Settings ***
Library           AppiumLibrary

Resource          ../configuration/appium.robot
Resource          ../util/variables.robot
Resource          ../util/keywords.robot

Suite Setup       Launch App
Documentation     Test main skatemap screen, list screen, detail screen and waypoint filtering related functionality.

*** Test Case ***
Test SkateMap Screen
    Map Screen Elements Are Visible

    Tap Toggle Map Layer
    Tap Toggle Map Layer

Test SkateMap Waypoint Selection
    Tap On Map Waypoint
    Waypoint Preview Is Visible
    Deselect Map Waypoint
    Waypoint Preview Is Not Visible
    Tap On Map Waypoint
    Waypoint Preview Is Visible

Test Place Details Screen From Map
    Tap On Map Waypoint
    Tap On Map Waypoint Preview

    Place Details Screen Elements Are Visible
    Open Place Image
    Place Image Is Visible
    Navigate Back
    Place Details Screen Elements Are Visible
    Navigate Back
    Map Screen Elements Are Visible

Test Place Details Screen From List
    Switch To List View

    List Screen Elements Are Visible
    Open Waypoint From List
    Place Details Screen Elements Are Visible
    Navigate Back
    List Screen Elements Are Visible

    Switch To Map View

    Map Screen Elements Are Visible

Test Waypoint Filter Open/Close
    Tap On Filter Button
    Filter Elements Are Visible
    Filter Options Are Turned On
    Close Filter
    Filter Elements Are Not Visible

    Tap On Filter Button
    Filter Turn Off All Options
    Close Filter
    Tap On Filter Button
    Filter Options Are Turned On

Test Waypoint Map Filtering
    Tap On Filter Button
    Filter Turn Off All Options
    Filter Save
    Filter Elements Are Not Visible
    Map Waypoints Are Not Visible

    Tap On Filter Button
    Filter Options Are Turned Off
    Close Filter

    Switch To List View
    List Waypoints Are Not Visible

Test Waypoint List Filtering
    Switch To List View

    Tap On Filter Button
    Filter Turn Off All Options
    Filter Save
    List Waypoints Are Not Visible

    Switch To Map View
    Map Waypoints Are Not Visible

    Switch To List View
    List Waypoints Are Not Visible

    Tap On Filter Button
    Filter Turn On All Options
    Filter Save
    List Waypoints Are Visible

    Switch To Map View
    Map Waypoints Are Visible