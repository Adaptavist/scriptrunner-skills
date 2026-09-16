# Web Section

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4js-7d55c62f-95d4-41a5-9ad2-085efa98726b-30d61d8cc4926b50
- Source: https://docs.adaptavist.com/sr4js/latest/features#fragments--en#web-section--en

Web sections can be used to add new locations, or sections, to add web-items (links, buttons etc).

1.  From ScriptRunner, select UI Fragments > Create Fragment > Create a custom web section.
2.  Fill the form out as follows:
    
    This creates a new web section in the More Actions menu on the View Issue page.
    
    Note: The web-section will be not visible unless any there are any web-items in it.
    
3.  Modify the [Web Items simple link example](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) to change the section to the one created above.
    
    The section name should just be the key of the web section we created, so in this case it should be tools-menu-additional.
    
    In the following screenshot we created a similar one that searches for the current page title or issue summary with Bing rather than Google. It should then look like the image below. As you can see, both items are grouped into their own session.
    

Tip: Play around with the web section weight to move the section up or down in the menu.

As with web items, you can define a condition that will determine whether the entire section will be visible or not.
