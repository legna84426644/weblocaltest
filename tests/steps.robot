*** Settings ***
Resource          settings.robot
Resource          variables.robot

*** Keywords ***
My VSee Suite Setup
    Create Driver
    Delete All Email    ${ORIGINAL_EMAIL}    ${PASSWORD}

My VSee Suite Teardown
    Run Keyword And Ignore Error    Delete All Cookies
    Close All Browsers

My VSee Test Setup
    ${passed} =     Run Keyword And Return Status    Switch Browser    1
    Run Keyword If    not ${passed}    Restart Browser

My VSee Test Teardown
    Run Keyword If Test Failed    Restart Browser

Restart Browser
    [Documentation]    Close current browser and open new browser
    Run Keyword And Ignore Error    Delete All Cookies
    Close All Browsers
    Create Driver

Delete Cookies and Close Browser
    Delete All Cookies
    Close Browser
