# Script Variables

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-baa5ee79-ffbf-4ad0-bf54-a159767b274d-538b14cacd50d4cd
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-variables

Script Variables allow you to specify variables that can be injected into your scripts.

Use Script Variables to create variables that can be inserted into your scripts. Script Variables are encrypted and stored in your Confluence Cloud instance. You can use them to share common variables between your scripts or to store sensitive data, like passwords, that require encryption rather than hardcoding them in scripts directly.

Note: Please remember that a variable has a String value type, even if the value is a number. It is also worth noting that Script Variables are static and can only be set on the Script Variables page, so you cannot dynamically set the values of these via a script.

## Naming convention

Variable names must follow these rules:

-   The name must start with a letter
-   Only capital letters are allowed
-   Only digits and the underscore character (\_) are allowed.

## Limitations

Length limits for variables include:

-   Name is 32 characters max
    
-   Value is 3000 characters max.
    

Note that clicking the show password icon for script variables containing 50 or more characters opens a pop-up window for easy viewing.

## Create Script Variables

Follow these steps to create a script variable:

1.  Navigate to ScriptRunner and select Script Variables.
    1.  If you've never created a Script Variable before, the bottom of the page will be titled Create Script Variable, and the fields to do so will be available.
    2.  If you've created Script Variables before, they'll be listed on the page. Click \+ Create Script Variable to make a new one.
2.  Enter a Script Variable name.
3.  Enter the Script Variable value.
4.  Select Save.

A confirmation message displays. The newly created variable appears in the list of Script Variables on the page.

## Edit or delete a Script Variable

How to edit or delete a Script Variable.

1.  Navigate to ScriptRunner > Script Variables.
2.  Find your desired Script Variable from the list on the page.
3.  Select the Actions button correlated to the desired variable.
4.  Select Edit or Delete.

Selecting Edit allows you to change the _Name_ or _Value_ of the Script Variable. Click Save to lock in your changes.

Selecting Delete brings up a confirmation window. Click OK to confirm.

## Examples

-   To define a script variable with the name `MY_FIRST_SHARED_VAR` with the value `testValue`, run the following code:
    
    ```
    logger.info("My variable has a value: "+ MY_FIRST_SHARED_VAR)
    ```
    
    You should see the log with the following content:
    
    ```
    INFO - My variable has a value: testValue
    ```
    
-   To define a variable with the name NO\_RETRIES with a value of '5', run the following code:
    
    ```
    NO_RETRIES + 10
    ```
    
    The result will be 510 (string concatenation), rather than 15.
