*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Go To Site    
...    [Arguments]    ${siteUrl}
    Go To    ${siteUrl}    
    Maximize Browser Window

Go To Cart page
    Click Element    //a[@class="shopping_cart_link"]
    Element Text Should Be    //span[@class="title"]    Your Cart



