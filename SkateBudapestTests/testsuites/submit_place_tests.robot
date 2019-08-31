*** Settings ***
Library           AppiumLibrary

Resource          ../configuration/appium.robot
Resource          ../util/variables.robot
Resource          ../util/keywords.robot

Suite Setup       Launch App
Documentation     Test submit place screens, including textfield and image inputs and navigating between steps.

*** Test Case ***
Test Description Screen Step
    Sleep  1s