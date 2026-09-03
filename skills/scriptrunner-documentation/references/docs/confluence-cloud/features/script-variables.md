# Script Variables

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-112151564
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-variables

Using script variables, you can specify variables that can be injected into your scripts. Those variables are encrypted and stored in your Confluence Cloud instance. You can use them to share common variables between your scripts or to store sensitive data like passwords that require encryption rather than hardcoding them in scripts directly.

Remember that variable value has a type `String`, even if the value is a number.

Variable names must follow these rules:

-   Start with a letter
    
-   Only capital letters are allowed
    
-   Only letters, digits, and the underscore character (\_) are allowed
    

Length limit for variable:

-   Name is 32 characters
    
-   Value is 128 characters
    

## Examples

-   To define a script variable with the name `MY_FIRST_SHARED_VAR` with the value `'testValue'`, run the following code: 
    
    ```
logger.info("My variable has a value: " + MY_FIRST_SHARED_VAR)
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
    

## Use script variables

Follow these steps to create a script variable: 

1.  Navigate to _ScriptRunner_ and select **Script Variables**.   
    ![](/sr4cc/files/latest/112151564/588874133/1/1769188099000/script-variables.png)
2.  Enter a **Script Variable name**. 
3.  Enter the **Script Variable value**. 
4.  Select **Save**.
