*** Settings ***
Library  SeleniumLibrary
Library    Collections
Library    String

*** Keywords ***
Get Item In Cart   
    ${noOfList}    Get Element Count    //div[@class="inventory_item_name "]
    ${itemList}    Create List
    FOR    ${i}    IN RANGE    1    ${noOfList}+1 
        ${name}    Get Text    //div[@class="inventory_item"][${i}]//div[@class="inventory_item_name "]
        ${price}   Get Text    //div[@class="inventory_item"][${i}]//div[@class="inventory_item_price"]   
        ${price}    Get Substring    ${price}    1
        ${dictionary}    Create Dictionary    name=${name}    price=${price}
        Append To List    ${itemList}    ${dictionary}
    END
    RETURN    ${itemList}


Click Checkout Button    
    Click Button    id:checkout

Verify Item In Cart 
...    [Arguments]    ${expectedList}
    ${noOfItem}    Get Length    ${expectedList}
    FOR    ${i}    IN RANGE    1    ${noOfItem}+1
        Element Text Should Be    //div[@class="cart_item"][${i}]//div[@class="inventory_item_name"]    ${expectedList}[${i-1}][name] 
    END