# Add or Remove Watchers

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-c4032f50-6f9a-422c-9823-80aa6eeec694-c71e92416d2652f0
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#add-or-remove-watchers--en

You can choose to add or remove watchers on spaces, blogs, or content selected by CQL using this built-in script.

Tip: You can select both users and groups. For more information on users and groups, visit the Atlassian documentation [Add users and set permissions](https://confluence.atlassian.com/conf59/add-users-and-set-permissions-792498553.html).

## Run this script

Follow these steps to run the built-in script.

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Add/Remove Watchers.
3.  For Select By, enter what type of watcher you want to work with.
    
    Your choices are:
    
    -   Space
        
        Choose if you want to work with watchers of a space. If you add users and/or groups, they are added as space watchers – not page watchers. If you select Space and remove users as watchers, they may still watch pages in the space.
        
        1.  Enter the space you want to work with for Target Space.
        2.  Enter the groups you want to work with for Apply to Groups.
        3.  Enter the users you want to work with for Apply to Users.
        4.  For Action, select Watch or Unwatch to add or remove users.
    -   Blog
        
        Choose if you want to work with watchers of a blog.
        
        1.  Enter the blog you want to work with for Target Space.
        2.  Enter the groups you want to work with for Apply to Groups.
        3.  Enter the users you want to work with for Apply to Users.
        4.  For Action, select Watch or Unwatch to add or remove users.
    -   CQL
        
        Choose if you want to work with watchers selected by CQL. When you select CQL, the user(s) and group(s) are added as page watchers.
        
        1.  In CQL Query, enter your CQL statement.
            
            Tip: CQL tips
            
            -   This field has CQL Autocomplete, so when you start typing, suggestions will appear.
            -   The indicator on the left-side of the field alerts you if CQL is correct or incorrect.
            -   For more information about using CQL, check out the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).
            
        2.  Enter the groups you want to work with for Apply to Groups.
        3.  Enter the users you want to work with for Apply to Users.
        4.  For Action, select Watch or Unwatch to add or remove users.
4.  Select Preview to view results, or select Run to apply the change.
    
    Note:
    
    -   Users are only listed in the results if they have permission to view the selected content.
    -   If you add a user who was already watching the content, they will not be listed in the results.
    -   If you try to remove a watcher that was not watching the content, they are not listed in the results.
    

## Example

### Add watchers for certain content

If you have a large Confluence instance with many different types of users, you may want to add watchers for certain content.

Say you have an instance where each developer has a blog to keep track of notes for their work. If a developer decides to leave the company, they might want to add watchers to their blog and other work so coworkers can find notes about unfinished work. In this case, Ayla Matic (username is amatic) will want to add Violet Burton (username is violetb) as a watcher to their blog, Ayla's Blog, and all pages created by them in the instance.

Follow these steps to add Violet as a watcher to Ayla's content.

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Add/Remove Watchers.
3.  Choose Blog for Select By.
4.  Enter Ayla's Blog for Target Space.
5.  Enter Violet Burton for Apply to Users.
6.  For Action, choose Watch.
7.  Select Run.
    
      
      
    
    The result message:
    
8.  Navigate back to the built-in scripts page.
9.  Select Add/Remove Watchers.
10.  Choose CQL for Select By.
11.  For CQL, enter creator = amatic.
12.  Enter Violet Burton for Apply to Users.
13.  For Action, choose Watch.
14.  Select Run
     

The result message:

Now that we have gone through adding Violet as a watcher to Ayla's blog and pages created by them, Violet is following all of Ayla's content to have access to their notes once they leave the company.
