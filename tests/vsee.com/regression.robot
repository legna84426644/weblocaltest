*** Settings ***
Suite Setup    My Suite Setup
Suite Teardown    My Suite Teardown
Test Setup    My Test Setup
Test Teardown    My Test Teardown

Resource    ../settings.robot
Resource    ../steps.robot
Force Tags    vsee.com

*** Variables ***

*** Test Cases ***
Create Account
    [Tags]    sign-up
    ${email_1}    Set Variable    robin+test200@vsee.com
    ${password_1}    Set Variable    test1234
    Sign Up For An Account    ${email_1}    ${password_1}

*** Keywords ***
Sign Up For An Account
    [Arguments]    ${email}    ${password}
    Go To    ${HOST}
    Click Element    css=a.btn.btn-color
    Wait Until Element Is Visible    css=input[name=signup-email]
    Input Text    css=input[name=signup-email]    ${email}
    Click Element    css=button.btn.btn-color
    Wait Until Element Is Visible    css=p.signup-success strong
    Element Text Should Be	  css=p.signup-success strong    An activation email is on its way to your inbox