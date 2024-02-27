*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Input Username
...    [Arguments]    ${username}
    Input Text    id:user-name    ${username}

Input Password
...    [Arguments]    ${password}
    Input Text    id:password    ${password}

Click Login Button
    Click Button    id:login-button

Verify Login Success 
    Element Text Should Be    //span[@class="title"]    Products

Verify Login Failed 
...    [Arguments]    ${errorMessage}
    Element Text Should Be    xpath://div[contains(@class, 'error-message-container')]/h3    ${errorMessage}




    
