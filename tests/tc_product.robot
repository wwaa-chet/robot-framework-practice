*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/loginKeywords.resource
Resource    ../resources/productKeywords.resource
Resource    ../resources/commonKeywords.resource

Suite Setup    Run Keywords   Open Browser    ${None}    chrome
...            AND    commonKeywords.Go To Site    ${siteUrl}
...            AND    loginKeywords.Input Username    ${validUsername}
...            AND    loginKeywords.Input Password    ${validPassword}
...            AND    loginKeywords.Click Login Button
...            AND    loginKeywords.Verify Login Success
Suite Teardown    Close Browser

*** Variables ***
${siteUrl}    https://www.saucedemo.com
${validUsername}    standard_user
${validPassword}    secret_sauce


*** Test Cases ***
Test 
    productKeywords.Get Product List

Add Product To Cart
    ${productList}    productKeywords.Get Product List
    ${itemInCart}    Set Variable    0
    productKeywords.Verify No Item In Cart
    FOR    ${product}    IN    @{productList}
        ${itemInCart}    Evaluate    ${itemInCart} + 1
        productKeywords.Click Button Add To Cart    ${product.name}
        productKeywords.Verify No Of Item In Cart    ${itemInCart}
    END

Remove Product From Cart
    ${productList}    productKeywords.Get Product List
    ${itemInCart}    Set Variable    6
    FOR    ${product}    IN    @{productList}
        ${itemInCart}    Evaluate    ${itemInCart} - 1
        productKeywords.Click Button Remove   ${product.name}
        IF    ${itemInCart} > 0
            productKeywords.Verify No Of Item In Cart    ${itemInCart}
        ELSE
            productKeywords.Verify No Item In Cart
        END
    END

Sort By Product Name (A To Z)
    productKeywords.Select Sort By Name (A-Z)
    ${productList}    productKeywords.Get Product List
    ${isSorted}    Evaluate    sorted(${productList}, key=lambda x: x['name'])
    Should Be True    ${isSorted}

Sort By Product Name (Z To A)
    productKeywords.Select Sort By Name (Z-A)
    ${productList}    productKeywords.Get Product List
    ${isSorted}    Evaluate    sorted(${productList}, key=lambda x: x['name'], reverse = True)
    Should Be True    ${isSorted}

Sort By Price (Low To High)
    productKeywords.Select Sort By Price (Low-High)
    ${productList}    productKeywords.Get Product List
    ${isSorted}    Evaluate    sorted(${productList}, key=lambda x: x['price'])
    Should Be True    ${isSorted}
    
Sort By Price (High To Low)
    productKeywords.Select Sort By Price (High-Low)
    ${productList}    productKeywords.Get Product List
    ${isSorted}    Evaluate    sorted(${productList}, key=lambda x: x['price'], reverse=True)
    Should Be True    ${isSorted}
    
    




