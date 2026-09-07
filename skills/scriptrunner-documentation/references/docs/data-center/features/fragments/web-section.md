# Web Section

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-442886396
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section

Web sections can be used to add new locations, or sections, to add web-items (links, buttons etc).

1.  From ScriptRunner, select **UI Fragments > Create Fragment > Create a custom web section**.
2.  Fill the form out as follows:  
    ![](/sr4js/files/latest/442886396/442886397/1/1758746692000/Web_section_example_1.png)
    
3.  This creates a new web section in the **More Actions** menu on the _View Issue_ page.
    
    The web-section will be not visible unless any there are any web-items in it.
    
4.  Modify the [Web Items simple link example](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) to change the _section_ to the one created above. The section name should just be the key of the web section we created, so in this case it should be `tools-menu-additional`.  
    In the following screenshot we created a similar one that searches for the current page title or issue summary with Bing rather than Google. It should then look like the picture below. As you can see, both items are grouped into their own session.  
    ![](/sr4js/files/latest/442886396/442886402/1/1758746692000/web-section-with-items+%282%29.png)

Play around with the web section **weight** to move the section up or down in the menu.

As with web items, you can define a condition that will determine whether the entire section will be visible or not.
