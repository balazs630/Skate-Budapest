*** Settings ***
Library           AppiumLibrary

Resource          ../configuration/appium.robot
Resource          ../util/variables.robot
Resource          ../util/keywords.robot

Suite Setup       Launch app

Documentation     Test main skatemap screen, list screen, detail screen and waypoint filtering related functionality.

*** Test Case ***
Skatemap screen
    Map screen elements are visible

Place details screen from map
    When Tap on map waypoint
        And Tap on map waypoint preview
    Then Place details screen elements are visible

    When Navigate back
    Then Map screen elements are visible

Place details screen from list
    When Switch to list view
    Then List screen elements are visible

    When Tap cell from list
    Then Place details screen elements are visible

    When Navigate back
    Then List screen elements are visible

    When Switch to map view
    Then Map screen elements are visible
