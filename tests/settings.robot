*** Settings ***
Library    ../library/testlib.py
Library    SeleniumLibrary    run_on_failure=${SEL_RUN_ON_FAILURE}
Resource    variables.robot
Resource    steps.robot

*** Variables ***
${CON_TYPE}       subdomain
${BROWSER_SIZE}    ${BROWSER_SIZE_DESKTOP}
${FIXTURE_DEBUG}    ${False}
${DRIVER_TYPE}    chrome
${DEFAULT_BS_USER}    None
${DEFAULT_BS_KEY}    None
${HOST}           https://vsee.com/
${SEL_RUN_ON_FAILURE}    Capture Page Screenshot

*** Keywords ***
Create Driver
    Run Keyword If    '${DRIVER_TYPE}' == 'chrome_headless'    Create Chrome Headless
    Run Keyword If    '${DRIVER_TYPE}' == 'chrome'    Create Chrome
    Run Keyword If    '${DRIVER_TYPE}' == 'firefox_headless'    Create Firefox Headless
    Run Keyword If    '${DRIVER_TYPE}' == 'firefox'    Create Firefox
    Run Keyword If    '${DRIVER_TYPE}' == 'edge'    Create Edge
    Run Keyword If    '${DRIVER_TYPE}' == 'ie'    Create Internet Explorer
    Run Keyword If    '${DRIVER_TYPE}' == 'bs_edge'    Create BrowserStack Edge    resolution=${BS_RES_WIN_4}

Create Chrome Headless
    @{arguments}    Create List    ${DISABLE_GPU}    ${BROWSER_SIZE}    ${HEADLESS}
    ${Chrome Options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${Argument}    IN    @{arguments}
    \    Call Method    ${Chrome Options}    add_argument    ${Argument}
    Create Webdriver    Chrome    crm_alias    chrome_options=${Chrome Options}

Create Firefox Headless
    @{arguments}    Create List    -${HEADLESS}
    ${Firefox Options} =    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    : FOR    ${Argument}    IN    @{arguments}
    \    Call Method    ${Firefox Options}    add_argument    ${Argument}
    Create Webdriver    Firefox    ff    firefox_options=${Firefox Options}

Create Internet Explorer
    ${dc}    Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.INTERNETEXPLORER    sys, selenium.webdriver
    Set To Dictionary    ${dc}    ie.ensureCleanSession    ${True}
    Set To Dictionary    ${dc}    enableElementCacheCleanup    ${True}
    Set To Dictionary    ${dc}    ignoreProtectedModeSettings    ${True}
    Open Browser    ${HOST}    ie    desired_capabilities=${dc}

Create Chrome
    @{arguments}    Create List    ${DISABLE_GPU}    ${BROWSER_SIZE}
    ${Chrome Options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${Argument}    IN    @{arguments}
    \    Call Method    ${Chrome Options}    add_argument    ${Argument}
    Create Webdriver    Chrome    crm_alias    chrome_options=${Chrome Options}

Create Firefox
    Open Browser    ${HOST}    ff