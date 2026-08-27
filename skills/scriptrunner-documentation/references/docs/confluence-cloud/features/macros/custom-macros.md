# Custom Macros

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros
- Doc ID: doc-sr4cc-125502789
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros

You can use this feature to create your own macros. To see examples of custom macros, check out these pages:

-   [Example: Return Page Information](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-page-information)
-   [Example: Return the Page ID](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-the-page-id)
-   [Example: Stock Exchange Price](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-stock-exchange-price)
-   [Example: Get Jira Issue Information on a Confluence Page](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-get-jira-issue-information-on-a-confluence-page)

## Create a custom macro 

1.  Select **Create Custom Macro_._**
2.  Fill out the fields that appear:   
    1.  **Macro Name**: Enter a name to identify your macro for you and your users. 
    2.  **Description**: Explain what your macro accomplishes.
    3.  **Enabled** (radio button): Control if your macro can be made available to your users. 
    4.  **Body Type**: Set the body type of the macro. 
        -   _Rich Text_: The macro allows Rich Text content, which can be formatted, to be inserted.
        -   _Plain Text_: The macro allows Plain Text, which is unformatted, to be inserted. 
        -   _None_: No body. 
            
            Different Macro Editing Experiences
            
            The **Body Type** you select for your custom macro determines how a user can edit the macro when they apply it to a page.
            
            -   If you select _Rich Text_, your user can edit the body of the macro directly on the page.   
                ![](/sr4cc/files/latest/125502789/246187329/1/1711560922000/macro-rich-text-body-2.png)
            -   If you select _Plain Text_, your user is directed to a macro editor to enter their body of the macro.  
                ![](/sr4cc/files/latest/125502789/125502791/1/1636118485000/macros-plain-text.png)
            -   If you select _None_, your user sees their macro without a body to edit.   
                ![](/sr4cc/files/latest/125502789/246187330/1/1711560907000/macro-no-body-2.png) 
                
                This above image also shows how a macro set up with required parameters is displayed before parameter values are provided.
                
            
    5.  **Output Type**: Choose how the macro appears on the screen.
        -   _Block_: The macro will be on its own line on the Confluence page.
        -   _Inline_: The macro will be inline with other content on the Confluence page. 
    6.  **Script to Execute**: Enter the script for the macro here.
3.  Add any parameters you need for the macro's functionality by clicking **Add Parameter**.
    
    Implicit parameters
    
    The parameters that are available for use that you don't have to add using this method are: 
    
    -   `pageVersion`
        
    -   `macroId`
        
    -   `spaceKey`
        
    -   `pageId`
        
    
    Implicit parameters are stored in the same map array as [user-defined parameters](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/macro-parameters) and can be used in the same way. Avoid giving user-defined parameters the same name as these implicit parameters. You cannot have two items in a map array with the same name.
    
      
    For each parameter that you add, a modal appears where you fill out the **Type**, **Name**, **Description**, **Required**, and **Hidden** fields.
    
    More parameter information
    
    For more information on adding macro parameters, visit [Macro Parameters](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/macro-parameters). 
    
4.  Select **Save**. 

The macro now shows up on the main macro screen, where you can see macro information and whether it is enabled.

![](/sr4cc/files/latest/125502789/246187331/1/1711560799000/custom-macro-5-2.png)
