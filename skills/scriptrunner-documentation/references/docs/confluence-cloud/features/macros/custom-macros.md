# Custom Macros

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros
- Doc ID: doc-sr4cc-52a1feec-b5a2-441f-b492-9f01a9ef0bb6-e3498d94697c182a
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros

Use this feature to create your own macros.

To see examples of custom macros, check out these pages:

-   [Example: Return Page Information](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-page-information)
-   [Example: Return the Page ID](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-the-page-id)
-   [Example: Stock Exchange Price](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-stock-exchange-price)
-   [Example: Get Jira Issue Information on a Confluence Page](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-get-jira-issue-information-on-a-confluence-page)

## Choose a macro type

_Static Content_ macros render directly in the page and use the page's styling.

_Dynamic Content_ macros render in their own i-frame, separate from the page, and you can customize them with CSS and JavaScript.

Say you're building a Confluence page where people sign up for a company picnic.

-   To show a list of who's bringing which food, pulled from another Confluence page, use a Static Content macro.
    
-   To show the weather forecast from an external website, in a block element, use a Dynamic Content macro.
    
    -   You can use the CSS field to create custom styling, like displaying the temperature in an italic, blue font.
        
    -   You can use the JavaScript field to add custom behaviors to the macro, like a button that would toggle the temperature reading between Farenheit and Celcius when clicked.
        

### Comparison table

|  | Static Content Macro | Dynmaic Content Macro (default) |
| --- | --- | --- |
| Best for | Show Confluence content so it looks like part of the page | Show external content, or output that needs custom styling or behavior |
| Formatting | Inline | Block |
| Where it renders/where data is stored | Directly in the page | In its own i-frame, separate from the page |
| Styling | Uses the page's styling | Doesn't use the page styling. Custom CSS applies only inside the i-frame. |
| CSS and JavaScript | Not available | Optinal CSS and JavaScript fields appear when this type is selected |
| External URLs | [Do not render](https://community.developer.atlassian.com/t/staticview-macros-unusable-due-to-egress-decisions/103336.); display as plain text | Load after the page, so users may briefly see a loading state |
| Performance | \- | Each macro loads in its own i-frame; rendering multiple on a single page can cause performance issues. A page with 100 Dynamic macros loads 100 i-frames, which uses a lot of resources\* |

\* If a macro will appear many times on one page, such as a template or table row, use Static Content macros as much as possible.

Warning: You can change a macro's type after you create it, but features specific to the old type stop working. For example, if you change a macro from _Dynamic_ to _Static_, any previously created CSS and JavaScript no longer apply.

### Notes for all macro types

-   All URLs must match [Runtime egress permissions](https://developer.atlassian.com/platform/forge/runtime-egress-permissions/).
    
-   Updates to custom macros aren't always reflected immediately in the output.
    

## Create a custom macro

1.  Select Create Custom Macro.
2.  Fill out the fields that appear:
    
    1.  Macro Name: Enter a name to identify your macro for you and your users. This is the title that users will search for to find the macro in the Browse window.
    2.  Description: Explain what your macro accomplishes.
    3.  Enabled (radio button): Control whether your macro can be made available to your users.
    4.  Macro Type: Select _Static Content Macro_ or _Dynamic Content Macro_ (Default). See [Choose a macro type](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros#choose-macro-type--en) for more.
        
        1.  If _Dynamic Content Macro_ is selected, two additional optional fields appear:
            
            1.  The CSS field which allows custom styles to be applied to the macro output.
                
            2.  The JavaScript field where a script can be entered and executed when the macro output is rendered.
                
    5.  Body Type: Set the body type of the macro.
        
        -   _Rich Text_: The macro allows Rich Text content to be inserted and formatted.
        -   _Plain Text_: The macro allows Plain Text, which is unformatted, to be inserted.
        -   _None_: No body.
        -   Output Type: Choose how the macro appears on the screen.
            -   _Block_: The macro will be on its own line on the Confluence page.
            -   _Inline_: The macro will be inline with other content on the Confluence page.
        -   Script to Execute: Enter the script for the macro here.
        
        Note: Different macro editing experiences.
        
        The Body Type you select for your custom macro determines how a user can edit the macro when they apply it to a page.
        
        -   If you select Rich Text, your user can edit the body of the macro directly on the page.
        -   If you select Plain Text, your user is directed to macro editor to enter their body of the macro.
        -   If you select None, your user sees their macro without a body to edit.
        
    
3.  Add any parameters you need for the macro's functionality by clicking Add Parameter.
    
    Tip: Implicit parameters
    
    The parameters that are available for use that you don't have to add using this method are:
    
    -   `pageVersion`
        
    -   `macroId`
        
    -   `spaceKey`
        
    -   `pageId`
        
    
    Implicit parameters are stored in the same map array as [user-defined parameters](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/macro-parameters) and can be used in the same way. Avoid giving user-defined parameters the same name as these implicit parameters. You cannot have two items in a map array with the same name.
    
    For each parameter that you add, a modal appears where you fill out the Type, Name, Description, Required, and Hidden fields.
    
    Tip: More parameter information
    
    For more information on adding macro parameters, visit [Macro Parameters](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/macro-parameters).
    
4.  Select Save.
    
    The macro now appears on the main macro screen, where you can see macro information and enabled status.
