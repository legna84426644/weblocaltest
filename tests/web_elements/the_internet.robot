*** Settings ***
Suite Setup    Create Driver
Suite Teardown    Close All Browsers
Test Setup    Switch Browser And Go To Example Site
Test Teardown    Restart Browser If Failed

Resource    ../settings.robot
Resource    ../steps.robot
Force Tags    webelements

*** Test Cases ***
A/B Testing


Basic Auth

Broken Images

Challenging DOM

Checkboxes
    [Documentation]    Check defaul checkbox. Set and unset all checkboxes and validate them after changing
    Click Element    xpath=//a[text()="Checkboxes"]
    Wait Until Element Contains    css=div.example h3    Checkboxes
    Checkbox Should Not Be Selected    css=form#checkboxes input:nth-of-type(1)
    Checkbox Should Be Selected    css=form#checkboxes input:nth-of-type(2)
    Select Checkbox    css=form#checkboxes input:nth-of-type(1)
    Select Checkbox    css=form#checkboxes input:nth-of-type(2)
    Checkbox Should Be Selected    css=form#checkboxes input:nth-of-type(1)
    Checkbox Should Be Selected    css=form#checkboxes input:nth-of-type(2)
    Unselect Checkbox    css=form#checkboxes input:nth-of-type(1)
    Unselect Checkbox    css=form#checkboxes input:nth-of-type(2)
    Checkbox Should Not Be Selected    css=form#checkboxes input:nth-of-type(1)
    Checkbox Should Not Be Selected    css=form#checkboxes input:nth-of-type(2)

Context Menu
    # work on ff only

Disappearing Elements
    [Documentation]    Look for the Gallery element. If not found, refresh the page
    ${retry_num}    Set Variable    5
    Click Element    xpath=//a[text()="Disappearing Elements"]
    Wait Until Element Contains    css=div.example h3    Disappearing Elements
    : FOR    ${index}    in    ${retry_num}
    \    ${is_visible}    Run Keyword And Return Status    Element Should Be Visible    //a[text()="Gallery"]
    \    Run Keyword If    not ${is_visible}    Reload Page

Drag and Drop
    [Documentation]    Drap and drop to swap A and B
    Click Element    xpath=//a[text()="Drag and Drop"]
    Wait Until Element Contains    css=div.example h3    Drag and Drop
    Element Should Contain    css=div#column-a header    A
    Element Should Contain    css=div#column-b header    B
    Drag And Drop    css=div#column-a    css=div#column-b
    Element Should Contain    css=div#column-a header    B
    Element Should Contain    css=div#column-b header    A

Dropdown
    [Documentation]    Select options in dropdown
    Click Element    xpath=//a[text()="Dropdown"]
    Wait Until Element Contains    css=div.example h3    Dropdown List
    Selected List Label Should Be    css=select#dropdown    Please select an option
    Select From List By Label    css=select#dropdown    Option 1
    Selected List Label Should Be    css=select#dropdown    Option 1
    Select From List By Label    css=select#dropdown    Option 2
    Selected List Label Should Be    css=select#dropdown    Option 2

Dynamic Content
    [Documentation]    Get text of each element when the text change each page refresh
    Click Element    xpath=//a[text()="Dynamic Content"]
    Wait Until Element Contains    css=div.example h3    Dynamic Content
    ${before_text_1}    Get Text    css=div#content > div.row:nth-of-type(1) > div.large-10
    ${before_text_2}    Get Text    css=div#content > div.row:nth-of-type(2) > div.large-10
    ${before_text_3}    Get Text    css=div#content > div.row:nth-of-type(3) > div.large-10
    Reload Page
    ${after_text_1}    Get Text    css=div#content > div.row:nth-of-type(1) > div.large-10
    ${after_text_2}    Get Text    css=div#content > div.row:nth-of-type(2) > div.large-10
    ${after_text_3}    Get Text    css=div#content > div.row:nth-of-type(3) > div.large-10
    Should Not Be Equal    ${before_text_1}    ${after_text_1}
    Should Not Be Equal    ${before_text_2}    ${after_text_2}
    Should Not Be Equal    ${before_text_3}    ${after_text_3}

Dynamic Controls
    [Tags]    zzz
    [Documentation]    Click Remove/Add button and check the checkbox is removed/added after that
    Click Element    xpath=//a[text()="Dynamic Controls"]
    Wait Until Element Contains    css=div.example h4    Dynamic Controls
    Element Should Be Visible    css=div#checkbox
    Click Element    css=button#btn
    Wait Until Element Is Not Visible    css=div#checkbox
    Element Should Contain    css=p#message    It's gone!
    Click Element    css=button#btn
    Wait Until Element Is Visible    css=div#checkbox
    Element Should Contain    css=p#message    It's back!

Dynamic Loading
#    [Documentation]
#    Click Element    xpath=//a[text()="Dynamic Loading"]
#    Wait Until Element Contains    css=div.example h3    Dynamically Loaded Page Elements
#    Click Link    Example 1: Element on page that is hidden
#

Exit Intent
    [Documentation]    Mouse out of the viewport pane and see a modal window appear

File Download
#    [Documentation]    Download a file and check the filed is downloaded
#    Click Element    xpath=//a[text()="File Download"]
#    Wait Until Element Contains    css=div.example h3    File Downloader
#

File Upload
    [Documentation]    Upload a file and check the filed is uploaded
    Click Element    xpath=//a[text()="File Upload"]
    Wait Until Element Contains    css=div.example h3    File Uploader
    Choose File    css=input#file-upload

Floating Menu
    [Documentation]    ???

Forgot Password
    [Documentation]    ???

Form Authentication
    [Documentation]    do a valid login and invalid login

Frames
    [Documentation]    Get text in nested frame and iframe

Geolocation
    [Documentation]    Get correct current location and handle the alert

Horizontal Slider
    [Documentation]    Set some value for the horizontal slider

Hovers
    [Documentation]    Hover to the images to get the text and click to the link

Infinite Scroll
    [Documentation]    Scorll down a few times and get the text

JQuery UI Menus
    [Documentation]    Select some items from the Jquery menu

JavaScript Alerts
    [Documentation]    Interact with JS alert: dismiss, accept/deny, input text

JavaScript onload event error
    [Documentation]    ???

Key Presses
    [Documentation]    Press a key and verify

Large & Deep DOM
    [Documentation]    Get text from a large and deep DOM

Multiple Windows
    [Documentation]    Open a new window, get a  text from the new one and switch back

Nested Frames
    [Documentation]    ???

Notification Messages
    [Documentation]    Get different notification message

Redirect Link
    [Documentation]    ???

Secure File Download
    [Documentation]    Download some files

Shifting Content
    [Documentation]    ???

Slow Resources

Sortable Data Tables

Status Codes

Typos

WYSIWYG Editor

*** Keywords ***
Selected List Label Should Be
    [Arguments]    ${element_locator}    ${expected_value}
    ${current_value}    Get Selected List Label    ${element_locator}
    Should Be Equal    ${current_value}    ${expected_value}
