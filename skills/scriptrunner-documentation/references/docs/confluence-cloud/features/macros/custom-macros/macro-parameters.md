# Macro Parameters

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > custom-macros
- Doc ID: doc-sr4cc-246187302
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/macro-parameters

While creating a custom macro, you can set up a parameter for the user to enter information that the script uses to return information to the page where the macro is used.

Implicit parameters

The parameters that are available for use that you don't have to add using this method are: 

-   `pageVersion`
    
-   `macroId`
    
-   `spaceKey`
    
-   `pageId`
    

Implicit parameters are stored in the same map array as user-defined parameters outlined on this page and can be used in the same way. Avoid giving user-defined parameters the same name as these implicit parameters. You cannot have two items in a map array with the same name.

## Set up the macro parameter

When you [create a custom macro](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros), you can add a field that requests the user to input information when the macro is used on a Confluence page. To set up a new parameter, follow these steps:

1.  Navigate to **General Configuration** > _ScriptRunner_ > **Macros** > **Create Custom Macros**.
2.  Fill out the fields on the screen, including **Macro Name**, **Description**, **Enabled**, **Body Type**, **Output Type**, and **Script to Execute**.
3.  Select **Add Parameter** to add a field that requests the user to input information.  
    ![](/sr4cc/files/latest/246187302/246187307/1/1709599997000/add-parameterbutton.png)  
    Once you select **Add Parameter**, the _Add Macro Parameter_ dialog box appears.  
    ![Add Macro Parameter form](/sr4cc/files/latest/246187302/246187308/1/1709599844000/add-macro-parameter.png)  
    Fill out the fields: 
    1.  **Type**: Select the type of field you want to create. 
        -   _Attachment_: Allows users to select an attachment from the page when editing the macro on the page. The filename of the attachment is passed to the macro.
        -   _Boolean_: Allows users to add a checkbox field to the macro.
        -   _Confluence Content_: Allows users to select a Confluence page or blog post when editing the macro on a page. The page name is passed to the macro.
        -   _Int_: Allows users to pass a number to the macro when editing the macro on the page.
        -   _Label_: Allows users to choose a label(s) when editing it on a page and have the selected label(s) passed to the macro.
        -   _Spacekey_: Allows users to select one or more Confluence spaces when editing the macro on a page. The space key is passed to the macro.
        -   _String_: Allows users to add a text input field to the macro. 
        -   _URL_: Allows users to enter a URL when editing the macro on a page.
        -   _Username_: Allows users to select user(s) when editing the macro on a page. A list of accountId(s) is passed to the macro.
    2.  **Name**: The name of the macro parameter. This appears to you and the user.
    3.  **Description**: The description of the macro parameters. This appears to you and the user.
    4.  **Required**: If the parameter is required, tick the box. 
    5.  **Hidden**: If you'd like the parameter to be hidden, tick the box.
    6.  **Multiple**: You can add multiple values for certain parameter types.
        
4.  Select **Add**. 
    
    Script Context
    
    The parameter now appears in the _Script Context_ above the **Scripts to Execute** field.
    
    ![](/sr4cc/files/latest/246187302/272762684/1/1722280444000/script_context-2.png)
    

The parameter you added appears in a table on the [Custom Macros](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros) field:   
![](/sr4cc/files/latest/246187302/246187304/1/1709757098000/custom-macro-4.png)

You can select **Actions** and then **Remove the Parameter** (![](/sr4cc/files/latest/246187302/246187305/1/1709757098000/trashcan.png)) if it's no longer needed.

### Result

Now, when a user adds your custom macro to a page, they are asked to add input to the parameters. Then, the script that the custom macro uses can use that parameter to return information on the page where the macro is used.

How to use the parameters you add

The parameters that you define are stored in an array called _parameters_ and can be accessed using the parameter **n**ame as follows: 

-   If you have not used spaces in the **Name**: `parameters.parameterName`
-   If you have used spaces in the **Name**: `parameters.'Parameter Name'`

## Example

Visit [Example: Get Jira Issue Information on a Confluence Page](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-get-jira-issue-information-on-a-confluence-page) to see how to add custom macro parameters.
