# Hide UI Element Built-In Script

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-442886437
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/hide-ui-element-built-in-script

The Atlassian applications are supremely flexible, but this comes at the cost of some complexity.

This built-in script allows you to hide any system web item or panel, or those that are provided by plugins. This built-in script will only hide the web item - if your users can work out the URL that is invoked, they will be able to do the action. This is more for the purpose of reducing clutter, to allow users to focus on the most important elements in the user interface.

To be more specific, it allows you to add _additional_ conditions to these UI elements, so you can control more precisely when they are displayed.

This script can be confusing in use.

-   Don’t confuse your users. If you remove a menu item, make sure you document it and explain to your users why it’s not available.
-   Don’t confuse Atlassian Support. Don’t forget you have done this and raise a support request with Atlassian. You can see all the hidden items at Admin > Script Fragments. Alternatively, disabling ScriptRunner will restore anything that it is hiding. Before raising a ticket about a missing item, please check the hidden items to ensure this script is not the reason.

A few examples of how you might want to use this script:

-   You can hide the **Move** or **Clone** issue operations for particular projects, or at certain stages of the workflow, or allow only for some users
    
-   In projects that don’t require source control, you could remove the Development panel.
    

## Examples

### Hide Clone and Move issue

Let’s say you wish to disable the _Clone_ functionality for one project. Perhaps you want to replace _Clone_ with a [constrained create issue](https://docs.adaptavist.com/sr4js/latest/features/fragments/create-constrained-issue) link with the same name.

1.  From ScriptRunner go to **UI Fragments > Create Fragment > Hide system of plugin UI element**.
2.  Enter the following form details:  
    ![](/sr4js/files/latest/442886437/442886438/1/1758746696000/Hide_UI_example.png)
    
    You will not always know the key of the item you wish to ask. Start typing some characters in the name, and use trial and error.
    
    The item will be displayed if the condition code returns a truth object, which says the item will be hidden only if the condition code returns false. 
    
    The condition we have used means that these operations will only be visible in the two projects mentioned. If you want to hide it in just one or two projects, then **negate the condition**. For example, this condition will mean the option is visible in all projects except `SPD`:
    
    ```
! (jiraHelper.project?.key in ["SPD"])
```
    
    The section on [conditions](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item#conditions) on the Web Items page is relevant here too.
    
3.  The following shows the menu "before and after" you save the "hide items" built-in script:  
    ![](/sr4js/files/latest/442886437/442886441/1/1758746696000/hidden-menu-items+%281%29.png)
    

You can only further restrict the provided conditions. For example, the _Clone_ issue link requires that the current user has _Create Issue_ permissions in the current project. If the user does not have those permissions, it won’t be displayed regardless of any condition you configure.

### Other items

If you want to hide something else and you don’t know what, here are a few useful ones:

-   [Create Linked Issue](https://confluence.atlassian.com/servicedeskserver031/linking-issues-802165194.html#Linkingissues-Createanewlinkedissuefromanexistingissueinaservicedeskorbusinessproject) from Service Desk
    
    ```
com.atlassian.jira.jira-quick-edit-plugin:create-linked-issue-item
```
    
-   Branch panel provided by Jira Software
    
    ```
com.pyxis.greenhopper.jira:greenhopper-agile-issue-web-panel
```
