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

    When Open place image
    Then Image viewer is visible

    When Navigate back
    Then Place details screen elements are visible

    When Navigate back
    Then Map screen elements are visible

Place details screen from list
    When Switch to list view
    Then List screen elements are visible

    When Open waypoint from list
    Then Place details screen elements are visible

    When Navigate back
    Then List screen elements are visible

    When Switch to map view
    Then Map screen elements are visible

Waypoint filter open/close
    When Tap on filter button
    Then Filter elements are visible

    When Close filter
    Then Filter elements are not visible

    When Tap on filter button
        And Filter turn off all options
        And Close filter
        And Tap on filter button
    Then Filter options are turned on

Waypoint map filtering
    When Tap on filter button
        And Filter turn off all options
        And Filter save
    Then Filter elements are not visible
        And Map waypoints are not visible

    When Tap on filter button
        And Filter options are turned off
        And Close filter
        And Switch to list view
    Then List waypoints are not visible

Waypoint list filtering
    Given Launch app

    When Switch to list view
        And Tap on filter button
        And Filter turn off all options
        And Filter save
    Then List waypoints are not visible

    When Switch to map view
    Then Map waypoints are not visible

    When Switch to list view
    Then List waypoints are not visible

    When Tap on filter button
        And Filter turn on all options
        And Filter save
    Then List waypoints are visible

    When Switch to map view
    Then Map waypoints are visible