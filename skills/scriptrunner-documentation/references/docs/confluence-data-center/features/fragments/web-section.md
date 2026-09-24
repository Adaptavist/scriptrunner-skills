# Web Section

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-0f95c797-05ac-4a59-84c3-e06f01c14ee9-50acb66eca700b47
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#web-section--en

Web sections can be used to add new locations or sections or to add web-items (links, buttons etc).

Tip: Workaround available

If the following example does not work in your instance, try the workaround outlined in [Create a Confluence Toolbar Dropdown Option](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-section/create-a-confluence-toolbar-dropdown-option).

## Examples

Create a basic web section example:

1.  1.  Click Create a Custom Web Section.
        
    2.  Fill out the form:
        
        This creates a new web section in the ellipsis dropdown menu of wiki pages.
        
        The web section is not visible unless any there are any web-items in it.
        
    3.  Modify the [web item example](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) to change the section to the one created above.
        
        The full name is the location with `/` and the key. In this case, it is `system.content.action/tools-menu-additional`.
        
    
    The following screenshot shows a similar web item that searches for the current page title or issue summary with Bing rather than Google. Both items are grouped into their own session.
    
    Tip: You can use the Weight to move the section up or down in the menu.
    

## Conditions

Similar to web items, you can define a condition that will determine whether the entire section will be visible or not.
