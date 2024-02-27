*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library    String

*** Keywords ***
Click Button Add To Cart 
...    [Arguments]    ${productName}
    ${button}    Set Variable  //div[div/a/div[normalize-space()="${productName}"]]//button
    Element Text Should Be    ${button}    Add to cart
    Click Button    ${button}
    Element Text Should Be    ${button}    Remove

Click Button Remove
...    [Arguments]    ${productName}
    ${button}    Set Variable  //div[div/a/div[normalize-space()="${productName}"]]//button
    Element Text Should Be    ${button}    Remove
    Click Button    ${button}
    Element Text Should Be    ${button}    Add to cart


Get Product List
    ${noOfList}    Get Element Count    //div[@class="inventory_item_name "]
    ${productList}    Create List
    FOR    ${i}    IN RANGE    1    ${noOfList}+1 
        ${name}    Get Text    //div[@class="inventory_item"][${i}]//div[@class="inventory_item_name "]
        ${price}   Get Text    //div[@class="inventory_item"][${i}]//div[@class="inventory_item_price"]   
        ${price}    Get Substring    ${price}    1
        ${dictionary}    Create Dictionary    name=${name}    price=${price}
        Append To List    ${productList}    ${dictionary}
    END
    RETURN    ${productList}

Verify No Of Item In Cart
...    [Arguments]    ${number}
    Element Text Should Be    //span[@class="shopping_cart_badge"]    ${number}

Verify No Item In Cart  
    Element Should Not Be Visible    //span[@class="shopping_cart_badge"] 


Select Sort By Name (A-Z)
    Click Element    //select[@class="product_sort_container"]/option[normalize-space()="Name (A to Z)"]

Select Sort By Name (Z-A)
    Click Element    //select[@class="product_sort_container"]/option[normalize-space()="Name (Z to A)"]

Select Sort By Price (Low-High)
    Click Element    //select[@class="product_sort_container"]/option[normalize-space()="Price (low to high)"]

Select Sort By Price (High-Low)
    Click Element    //select[@class="product_sort_container"]/option[normalize-space()="Price (high to low)"]

    