# Example: Return the Page ID

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Custom Macros
- Doc ID: doc-sr4cc-54b3c79a-9b97-4979-a7ab-1dbe966d0ac6-00a0d52679f6c14b
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros#example-return-the-page-id--en

Instructions on creating a macro that will pull a specified Page ID onto a desired Confluence page.

You can create a macro to pull the Page ID of Confluence content onto a Confluence page.

Tip: This is a simple example of the way a custom macro can return page information. This example can be customized for different results.

## Create the macro

1.  Select Create Custom Macro.
2.  Enter a Name to identify the Macro, like _Page ID_.
3.  Enter an optional Description, like _Gets the page ID_.
4.  Select Enabled to allow the macro to be added to pages.
5.  Select _None_ for Body Type.
6.  Pick _Block_ for Output Type.
    
7.  Enter the following script into the Script to Execute field:
    
    ```
    return parameters.get("pageId")
    ```
    
8.  Select Save.

The macro appears on the main _Macros_ page.

Additionally, users in your instance can add it to Confluence pages. When it's added and the page is published, it appears like this:
