# Add or Remove Watchers Listener

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners > Built-In Listeners
- Doc ID: doc-sr4c-75cbbac5-dfb5-48d6-bfac-195d2c3ced12-76b5942d60be747d
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#built-in-listeners--en#add-or-remove-watchers-listener--en

You can use the _Add/Remove Watchers_ built-in listener to choose to add or remove watchers on spaces, blogs, or content selected by the CQL when prompted by a Confluence event.

To use the Add/Remove Watchers listener:

1.  Enter a Name for your listener.
    
    This name shows up on the main _Listeners_ screen.
    
2.  Select some Event(s) that you'd like to listen for.
    
    The Event(s) you select triggers the change to watchers.
    
    After you select some Event(s), the Select By field appears.
    
    Note: Crowd events are supported.
    
3.  For Condition, enter code in the _Script_ tab or upload code in the _File_ tab.
    
    This code evaluates after one of your selected events is fired, and is used to determine whether or not the listener should execute.
    
    Note: If left blank, the condition automatically evaluates to "true."
    
    Select Show Examples to see provided conditions. Once you select one, you can paste it in the field.
    
4.  For Select By, select the type of content that you'd like to work with.
    
    Your choices are:
    
    -   Space
        
        CAUTION: When you select _Space_, the user(s) and/or group(s) are added as space watchers not page watchers.
        
        Additionally, if you select _Space_ and remove user(s) as watchers, they may still watch the pages in the space.
        
    -   Blog
        
    -   CQL
        
        CAUTION:
        
        When you select _CQL_, the user(s) and group(s) are added as page watchers.
        
        Additionally, if you select _CQL_ and add user(s) as watchers to a space, they may still be space watchers.
        
    
5.  Based on what you select in the previous step, you see one of the following:
    
    -   Target Space - Enter the space you want to work with if you picked _Space_ or _Blog_.
        
    -   CQL Query - Enter the query you want to work with if you picked _CQL_.
        
        Tip: CQL tips
        
        -   This field has CQL Autocomplete, so when you start typing, suggestions will appear.
        -   The indicator on the left-side of the field alerts you if CQL is correct or incorrect.
        -   For more information about using CQL, check out the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).
        
    
6.  For Apply to Groups, select which group(s) you want to work with.
7.  For Apply to Users, select which user(s) you want to work with.
    
    Tip: You can select both users and groups for each set of watchers you are working with.
    
8.  For Action, select if you want the group(s) and/or user(s) to Watch or Unwatch.
9.  Select Preview to view results, or select Run to apply the change.
    
    Note: Users are only listed in the results if they have permission to view the selected content.
    
    If you add a user who was already watching the content, they are not listed in the results.
    
    If you try to remove a watcher that was not watching the content, they are not listed in the results.
    

## Example: Add New Marketing Users as Watchers for Marketing Space

In your Confluence instance, you may have groups for different departments in your organization. You may have a space for each department in your organization as well. When a new user joins the team, you may want to have them watch their department's space so they're notified of information that relates to them. Using the _Add/Remove Watchers_ listener, you can automate this. In this example, we will set up a listener that will add any new users added to the Marketing group as watchers of the Marketing space.

CAUTION: Only new users added to the group then become watchers. The groups won't necessarily stay in sync.

1.  Enter a Name like Add Marketing Watchers.
2.  For Event, select GroupMembershipsCreatedEvent.
3.  For Condition, enter the following code:
    
    ```
    event.groupName == "marketing-users"
    ```
    
4.  For Select By, choose _Space_.
5.  For Target Space, select your marketing space.
    
    For example, Marketing.
    
6.  For Apply to Groups, select your marketing group.
    
    For example, marketing-users.
    
7.  Leave Apply to Users blank.
8.  Select Watch for the Action.
9.  Select Add.
