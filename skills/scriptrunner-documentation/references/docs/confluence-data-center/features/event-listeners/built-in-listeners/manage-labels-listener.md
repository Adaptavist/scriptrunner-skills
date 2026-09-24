# Manage Labels Listener

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners > Built-In Listeners
- Doc ID: doc-sr4c-aa8295f0-2011-44fd-8f07-3bcfc5c017f0-ba6613a6893bdc26
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#built-in-listeners--en#manage-labels-listener--en

Use the _Manage Labels_ listener to automate label management.

You can manage labels on new pages and spaces, as well as update labels on existing pages and spaces.

## Set up

Follow these steps to set up a Manage Labels listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners .
2.  Select Create Listener.
3.  Select Manage Labels Listener.
4.  Enter a Name for your reference.
    
    You could add a description of the listener to easily identify it later.
    
5.  Select Event(s) that trigger the start of this listener.
6.  Enter a Groovy code snippet for Condition that determines whether or not the listener should execute.
    
    You can select Example Scripts to use provided code.
    
    Tip: You can leave this field blank, and then the listener is always triggered when the chosen event happens.
    
7.  Choose a Label Action:
    
    -   Add Label(s)
        1.  Label(s) appears, where you can enter the labels that you want added to the page.
    -   Remove Label(s)
        1.  Label(s) appears, where you can enter the labels that you want removed from the page.
    -   Rename Labels
        1.  Original Name appears, where you enter the old label name that you want to change.
        2.  New Name appears, where you enter the new label name.
    
8.  For Target Content, add a Groovy code snippet to return content from the event.
    
    You can select Example Scripts to use provided code.
    
    Note: This field is required, but you can use the provided code list for basic configurations. If you want a more advanced configuration, use this field to return a list of content where you want to apply the label action (add, remove, or rename). A few examples of events and code snippets follow:
    
    | Event | Target Content Code | Result |
    | --- | --- | --- |
    | PageCreateEvent | \[event.page\] | The label action is applied to the page when it is created. |
    | AttachmentCreateEvent | \[event.attachedTo\] | The label action is applied to a page if an attachment was added to it. |
    | BlogPostUpdateEvent | \[event.blogpost\] | The label action to the updated blog page. |
    
    This is also where you determine a space and/or page tree where the label action occurs.
    
9.  Select Add.
    

## Examples

Using this listener, you can:

-   Add labels based on a parent page
    -   Add a `benefits` label to all pages created or updated under the main _Benefits_ page in an HR space
-   Add labels based on user permissions
    -   Add the `contractor_access` label to all pages created or updated that are viewable by users in the _Contractors/Vendors_ user group
-   Add labels based on group membership
    -   Add a `client_beta` label to all pages that are created by users in the Client Beta Access user group
-   Apply labels based on multiple criteria:
    -   Add the `audit_review` label to all pages in a _Security_ space created by users in the _Contractors/Venders_ group before six months ago
    -   Add the `inactive_content_review` label to pages in the spaces that have a _KnowledgeBase_ category and have been viewed but not updated in more than eight months
    -   Remove any labels in the HR space on pages created by users that are not in the _Approved HR Content Reviewers_ user group
-   Rename labels based on user-defined substitutions
    -   Rename labels to a preferred spelling when words can be spelled multiple ways in global organizations (for example, " `programme` " and " `program` " or " `canceled` " and " `cancelled` ")
    -   Rename labels based on common misspellings (for example, " `prodcut` " to " `product` ")

### Rename label to avoid common misspellings

This example shows you how to rename a label, using the common misspelling of "prodcut" for "product."

1.  Enter the Name Rename labels with the misspelling prodcut to identify the listener.
2.  Add the Event(s) of LabelAddEvent.
3.  Leave the Condition field blank because you want these events to always trigger the listener.
4.  For the Label Action, choose Rename Label(s).
5.  Enter prodcut in the Original Label Name(s).
6.  Enter product in the New Label Name(s).
7.  For Target Content, enter `[event.getLabelled()]` to return label events.
8.  Select Add.
    

Now, all of your misspelled labels with `prodcut` are updated to `product` when _LabelAddEvent_ fires.

### Add label after a page is moved to a different space

To add a label when a page moves spaces, follow these steps:

1.  Enter the Name Add a label after a page is moved to a different space to describe the listener.
2.  Add the Event(s) of PageMoveEvent.
3.  Enter `event.isMovedSpace()` for Condition.
4.  For Label Action, select Add Label(s).
5.  Enter moved-page for Label Name(s).
6.  Enter `[event.gePage()]` for Target Content.
7.  Select Add.
    

Now, when a page is moved from one space to any other space, it will have the `moved-page` label.

### Remove label from new or updated pages

To set up a listener to remove a label from new or updated pages not in a specific space (the _HR_ space in this example), follow these steps:

1.  Add the Name Remove confidential label from new or updated pages not in the HR space to describe the listener.
2.  Add the Event(s) of PageCreateEvent and PageUpdateEvent.
3.  For Condition, enter `event.page.spaceKey != 'HR'`.
4.  Pick Remove Label(s) for Label Action.
5.  Enter confidential for Label Name(s).
6.  Enter `[event.page]` for Target Content.
7.  Select Add.
    

Now, when a page is updated or created in the _HR_ space, the `confidential` label will be added.

### Remove labels if the user is not an admin

If a user who is not an administrator adds labels to pages, you can remove those labels by following these steps:

1.  Add the Name Remove specific labels if user is not an admin to describe the listener.
2.  Add the Event(s) of LabelAddEvent.
3.  Enter the following code for Condition:
    
    ```
    import com.atlassian.confluence.security.PermissionManager
    import com.atlassian.confluence.user.AuthenticatedUserThreadLocal
    import com.atlassian.sal.api.component.ComponentLocator
     
    def permissionManager = ComponentLocator.getComponent(PermissionManager)
    def currentUser = AuthenticatedUserThreadLocal.get()
     
    !(permissionManager.isConfluenceAdministrator(currentUser))
    ```
    
4.  Select Remove Label(s) for Label Action.
5.  For Label Name(s), enter confidential, hr, and top-secret.
6.  Select Add.
    

Now, if the labels _confidential_, _hr_, and _top-secret_ are added by a user who is not the administrator, the labels will be removed.

## Related content

-   [Manage Labels Confluence Administration](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels)
-   [Manage Labels Space Administration](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels)
-   [Manage Labels Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/manage-labels-job)
