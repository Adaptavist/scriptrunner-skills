# Update Page Restrictions Listener

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners > Built-In Listeners
- Doc ID: doc-sr4c-9e632d10-dd84-4940-b70b-7cdf836f99a4-be830e93d20da75a
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#built-in-listeners--en#update-page-restrictions-listener--en

Use the _Update Page Restrictions_ built-in listener to add and remove restrictions to parent and child pages.

You can automatically add or remove restrictions to blogs or pages by selecting an event as a trigger. Examples are available at the bottom of the page.

Follow these steps to create an _Update Page Restrictions_ listener:

1.  Navigate to General Configuration > ScriptRunner > Listeners.
2.  Select Create Listener.
3.  Select Update Page Restrictions Listener.
4.  Enter a description or name to help you identify this listener for the Name field.
5.  Choose the Event(s) that triggers this listener.
6.  Enter a Condition.
    
    Select Example Scripts to use provided code.
    
    Tip: If you enter nothing, the listener is always triggered when the chosen event happens.
    
7.  Choose the Restriction Level.
    
    Your choices are:
    
    -   Anyone can view and edit
    -   Anyone can view, only users and groups chosen in this script can edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can edit.
        
    -   Only users and groups chosen in this script can view and edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can view and edit.
        
    
8.  Select Add.
    
    You could also select Run Now to run the listener without adding it. When the listener is finished, you see a message explaining what the listener did.
    

## Examples

You can configure a listener to run on certain events to ensure any parent and/or child page restrictions are in place and left there.

### Restrict a new page to certain groups

When a page is created, you can ensure that the new page is restricted to a certain group.

To create the listener, follow these steps:

1.  Set the Name to When a page is created in the Security space, ensure it is restricted.
2.  Set the Event(s) to PageCreateEvent.
3.  Set the Condition to the following code:
    
    ```
    if (event.page.space.name == 'Security') {
     return true
    }
    false
    ```
    
4.  Select Only users and groups chosen in this script can view and edit for Restriction Level.
5.  Select confluence-administrators for Groups.
6.  Select Add.
    

The group _confluence-administration_ is now the only group who can see newly created pages in the _Security_ space.
