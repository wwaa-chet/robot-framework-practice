*** Settings ***
Resource  ../resources/loginKeywords.resource
Resource  ../resources/commonKeywords.resource

Suite Setup    Open Browser    ${None}    chrome
Test Setup    commonKeywords.Go To Site    ${siteUrl}
Suite Teardown    Close Browser

*** Variables ***
${siteUrl}    https://www.saucedemo.com
${validUsername}    standard_user
${validPassword}    secret_sauce
${lockedOutUsername}    locked_out_user
${invalidUsername}    invalid
${invalidPassword}    secret_sauce
${USERNAME_IS_REQUIRED}    Epic sadface: Username is required
${INVALID_USER}    Epic sadface: Username and password do not match any user in this service
${LOCKED_OUT_USER}    Epic sadface: Sorry, this user has been locked out.


*** Test Cases ***
Login Success
    loginKeywords.Input Username    ${validUsername}
    loginKeywords.Input Password    ${validPassword}
    loginKeywords.Click Login Button
    loginKeywords.Verify Login Success

Login Failed With Empty Username and Pasword
    loginKeywords.Input Username    ${EMPTY}
    loginKeywords.Input Password    ${EMPTY}
    loginKeywords.Click Login Button
    loginKeywords.Verify Login Failed   ${USERNAME_IS_REQUIRED}

Login Failed With Invalid User
    loginKeywords.Input Username    ${invalidUsername}
    loginKeywords.Input Password    ${invalidPassword}
    loginKeywords.Click Login Button
    loginKeywords.Verify Login Failed    ${INVALID_USER}

Login Failed With Locked Out User
    loginKeywords.Input Username    ${lockedOutUsername}
    loginKeywords.Input Password    ${validPassword}
    loginKeywords.Click Login Button
    loginKeywords.Verify Login Failed    ${LOCKED_OUT_USER}

