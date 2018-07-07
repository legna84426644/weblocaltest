*** Settings ***
Resource          settings.robot
Resource          variables.robot

*** Keywords ***
My Suite Setup
    Create Driver
    # delete user

My Suite Teardown
    Run Keyword And Ignore Error    Delete All Cookies
    Close All Browsers

My Test Setup
    ${passed} =     Run Keyword And Return Status    Switch Browser    1
    Run Keyword If    not ${passed}    Restart Browser

My Test Teardown
    Run Keyword If Test Failed    Restart Browser

#Suite Pre Suite
#    Create Driver
#
#Test Pre Suite
#    Apply Fixture    ${SUITE SOURCE}
#
#Test Pre Test
#    ${passed} =     Run Keyword And Return Status    Switch Browser    1
#    Run Keyword If    not ${passed}    Restart Browser
#    Delete All Cookies
#    Go To    ${HOST}
#    Delete All Cookies
#
#Test Post Test
#    Run Keyword If Test Failed    Restart Browser
#
#Suite Post Suite
#    Run Keyword And Ignore Error    Delete All Cookies
#    Close All Browsers

Restart Browser
    [Documentation]    Close current browser and open new browser
    Run Keyword And Ignore Error    Delete All Cookies
    Close All Browsers
    Create Driver

Delete Cookies and Close Browser
    Delete All Cookies
    Close Browser
