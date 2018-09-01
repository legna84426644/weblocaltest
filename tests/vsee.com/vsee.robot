*** Settings ***
Suite Setup    My VSee Suite Setup
Suite Teardown    My VSee Suite Teardown
Test Setup    My VSee Test Setup
Test Teardown    My VSee Test Teardown

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
    Get Activation Url From Email And Complete Signup Form

Reset Password
    [Tags]    reset-pwd
    Reset Password For An Account
    Get Reset Password Url From Email And Complete Password Reset Form

*** Keywords ***
Sign Up For An Account
    ${SIGN_UP_EMAIL}    Random Psuedo Email Address    ${ORIGINAL_EMAIL}
    Set Suite Variable    ${SIGN_UP_EMAIL}
    Go To    ${HOST}
    Click Element    css=a.btn.btn-color
    Wait Until Element Is Visible    css=input[name=signup-email]
    Input Text    css=input[name=signup-email]    ${SIGN_UP_EMAIL}
    Click Element    css=button.btn.btn-color
    Wait Until Element Is Visible    css=p.signup-success strong
    Element Text Should Be	  css=p.signup-success strong    An activation email is on its way to your inbox

Get Activation Url From Email And Complete Signup Form
    ${activate_url}    Wait Until Keyword Succeeds    ${TIMEOUT_SECONDS}    10 sec    Get Signup Activation Url From Email    ${SIGN_UP_EMAIL}    ${PASSWORD}
    Go To    ${activate_url}
    Input Text    css=input#firstname    ${FIRST_NAME}
    Input Text    css=input#lastname    ${LAST_NAME}
    Input Text    css=input#password    ${PASSWORD}
    Input Text    css=input#password_confirmation    ${PASSWORD}
    Checkbox Should Be Selected    css=input[name="consenttocontact"]
    Click Element    css=input.btn
    Download Page Should Be Loaded

Download Page Should Be Loaded
    Wait Until Keyword Succeeds    ${TIMEOUT_SECONDS}    5 sec    Location Should Be    https://my.vsee.com/download?signupsuccess=1
    Wait Until Element Contains    css=div.alert-success    Welcome to VSee! You have signed up successfully, please download the VSee Messenger now.

Reset Password For An Account
    Go To    ${RESET_PWD_URL}
    Input Text    css=input#vsee_id    ${SIGN_UP_EMAIL}
    Click Element    css=[type="submit"]
    Wait Until Element Contains    css=div#passwordreset_success_container_message    Please check your email for the instructions to reset your password.
    ${resend_href}    Get Element Attribute    css=div#passwordreset_success_container_message a    href
    Should Be Equal    ${resend_href}    ${RESET_PWD_URL}

Get Reset Password Url From Email And Complete Password Reset Form
    ${reset_pwd_url}    Wait Until Keyword Succeeds    ${TIMEOUT_SECONDS}    10 sec    Get Reset Password Url From Email    ${SIGN_UP_EMAIL}    ${PASSWORD}
    Go To    ${reset_pwd_url}
    Wait Until Element Is Visible    css=form#passwordreset
    Element Should Contain    css=form#passwordreset h1    Password Reset
    Input Password    css=input#password    ${PASSWORD}
    Input Password    css=input#password_confirmation    ${PASSWORD}
    Click Element    css=[type="submit"]
    Wait Until Element Contains    css=div#passwordreset_success_container_message    Your password has been successfully updated.
