# Example: Return the Page ID

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > custom-macros
- Doc ID: doc-sr4cc-182723115
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-the-page-id

You can create a macro to pull the Page ID of Confluence content onto a Confluence page.

This is a simple example of the way a custom macro can return page information. This example can be customized for different results.

## Create the macro

1.  Select **Create Custom Macro**. 
2.  Enter a **Name** to identify the Macro, like _Page ID_. 
3.  Enter an optional **Description**, like _Gets the page ID_. 
4.  Select **Enabled** to allow the macro to be added to pages. 
5.  Select _None_ for **Body Type.** 
6.  Pick _Block_ for **Output Type**.   
    ![](/sr4cc/files/latest/182723115/182723117/1/1691435269000/page_ID_fields.png)
7.  Enter the following script into the **Script to Execute** field: 
    
    ```
return parameters.get("pageId")
```
    
8.  Select **Save**.

The macro appears on the main _Macros_ page.

![](/sr4cc/files/latest/182723115/182723121/1/1691090695000/macros_results.png)

Additionally, users in your instance can add it to Confluence pages. When it's added and the page is published, it appears like this:

![](/sr4cc/files/latest/182723115/182723118/1/1691092436000/confluence_page.png)
