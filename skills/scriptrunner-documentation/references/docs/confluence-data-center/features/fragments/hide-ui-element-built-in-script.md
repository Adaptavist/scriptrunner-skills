# Hide UI Element Built-In Script

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-da957a1d-9d1a-478f-b682-b26c353567e8-30aa327cfc435bdc
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#hide-ui-element-built-in-script--en

This built-in script allows you to hide any system web item or panel, or those that are provided by plugins.

The Atlassian applications are supremely flexible, but this comes at the cost of some complexity.

This built-in script will only hide the web item; if your users can determine the invoked URL, they can still do the action. This is to reduce clutter and allow users to focus on the most important elements in the user interface.

To be more specific, it allows you to add _additional_ conditions to these UI elements, so you can control more precisely when they are displayed.

Warning: This script can be confusing in use.

-   Don't confuse your users. If you remove a menu item, make sure you document it and explain to your users why it's not available.
-   Don't confuse Atlassian Support. Don't forget you have done this and raise a support request with Atlassian. You can see all the hidden items at Admin > Script Fragments. Alternatively, disabling ScriptRunner will restore anything that it is hiding. Before raising a ticket about a missing item, please check the hidden items to ensure this script is not the reason.

## Examples

### Hide Export to PDF Item

You can disable the Export to PDF and Export to Word options for pages in one project.

1.  Go to Admin > Fragments.
2.  Select Hide System or Plugin UI Element.
3.  Fill out the form:
    
    Tip: You will not always know the key of the item you wish to ask. Start typing some characters in the name, and use trial and error.
    
    These operations are only be visible in the two spaces listed because of the conditions used. If you want to hide it in just one or two spaces, remove the condition. In the following code example, the condition means the option is visible in all spaces except `SPD`:
    
    ```
    ! (context.space?.key in ["SPD"])
    ```
    
    For more information, the section on [conditions](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) on the Web Items page is relevant here.
    
    This image shows the page before and after using the _Hide UI Element_.
    
    Note: You can only further restrict the provided conditions. For example, the _Export_ operation requires that the current user has _View page_ permissions in the current space. If the user does not have those permissions, it won't be displayed regardless of any condition you configure.
    

### Hide Social Features

Similar to the previous example, you can disable the social features for pages in one project.

1.  Go to Admin > Fragments.
2.  Select Hide System or Plugin UI Element.
3.  Fill out the form:
    

Tip: The Like/Dislike buttons are not web items, but you can prevent Confluence from loading the relevant JavaScript by running the following script in the Script Console:

```
import com.atlassian.plugin.PluginController
import com.atlassian.sal.api.component.ComponentLocator
 
def pluginController = ComponentLocator.getComponent(PluginController)
pluginController.disablePluginModule("com.atlassian.confluence.plugins.confluence-like:content-like-resources")
pluginController.disablePluginModule("com.atlassian.confluence.plugins.confluence-like:mobile-content-like-resource")
```

Note: The Follow link remains in the user-hover inline dialog. The only way to remove it is by editing `./confluence/users/userpopup.vm`.
