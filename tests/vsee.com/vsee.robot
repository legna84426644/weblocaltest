*** Settings ***
Suite Setup    My Suite Setup
Suite Teardown    My Suite Teardown
Test Setup    My Test Setup
Test Teardown    My Test Teardown

Resource    ../settings.robot
Resource    ../steps.robot
Force Tags    vsee.com

*** Variables ***
${FIRST_NAME}    thanh
${LAST_NAME}    le
${PASSWORD}    Test1234@

*** Test Cases ***
Create Account
    [Tags]    sign-up
    Sign Up For An Account

*** Keywords ***
Sign Up For An Account
    ${sign_up_email}    Random Psuedo Email Address    ${ORIGINAL_EMAIL}
    Go To    ${HOST}
    Click Element    css=a.btn.btn-color
    Wait Until Element Is Visible    css=input[name=signup-email]
    Input Text    css=input[name=signup-email]    ${sign_up_email}
    Click Element    css=button.btn.btn-color
    Wait Until Element Is Visible    css=p.signup-success strong
    Element Text Should Be	  css=p.signup-success strong    An activation email is on its way to your inbox
    ${activate_url}    Wait Until Keyword Succeeds    ${TIMEOUT_SECONDS}    10 sec    Get Signup Activation Url From Email    ${sign_up_email}    ${password}
    Go To    ${activate_url}
    Complete Signup Form
    Download Page Should Be Loaded


Complete Signup Form
    Input Text    css=input#firstname    ${FIRST_NAME}
    Input Text    css=input#lastname    ${LAST_NAME}
    Input Text    css=input#password    ${PASSWORD}
    Input Text    css=input#password_confirmation    ${PASSWORD}
    Checkbox Should Be Selected    css=input[name="consenttocontact"]
    Click Element    css=input.btn

Download Page Should Be Loaded
    Wait Until Keyword Succeeds    ${TIMEOUT_SECONDS}    5 sec    Location Should Be    https://my.vsee.com/download?signupsuccess=1
    Wait Until Element Contains    css=div.alert-success    Welcome to VSee! You have signed up successfully, please download the VSee Messenger now.