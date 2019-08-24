*** Settings ***
Library           AppiumLibrary
Resource          util/variables.robot
Resource          util/keywords.robot

*** Test Case ***
Launch application
    Launch App
    Allow Location Permission