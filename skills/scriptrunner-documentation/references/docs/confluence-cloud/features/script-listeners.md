# Script Listeners

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-107988516
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-listeners

A listener is an automated procedure or function in ScriptRunner that waits (or listens) for a specific event (or web hook) to occur in Confluence Cloud. Events are fired after an action takes place, for example, when a blog is created or a space is removed. Just after the event occurs, the listener takes action based on your requirements. 

For a listener to work, two things have to be defined:

-   The event (webhook) the listener waits for
    
    Examples of events are when a page is created, a comment is added, or a new user is created.
    
-   The action the listener takes
    

Additionally, you can choose which user the listener run as. You can also specify which space(s) the listener applies to. By default, listeners run for all spaces.

## Use cases

Listeners are very flexible. In a standard work environment, there are plenty of times when a routine task needs to be accomplished but is time-consuming do manually. Listeners ensure that you can implement your business’s processes concisely. 

Example listeners include:

-   Create a Jira ticket when a page is created in a certain space for work tracking purposes
    
-   Set a watcher for new blog posts
    
-   Watch for frequently made mistakes and automatically flags them with an inline comment (helpful for a content editor)
-   Create a Jira project whenever a Confluence space is created
    
-   Watch a specific user's content in a space
    
-   Create a templated 'about user' page when a new user is created
    
-   Automatically add a label to a new page to notify users that it requires review.
    

## Use Listeners

ScriptRunner for Confluence enables you to write your own listeners in a script editor box using the script file and/or events you want. Additionally, below the editor box, several different examples of things you might want to do are provided (and automatically fill in the script when clicked.)

1.  From the main Confluence left side menu, select **Settings.  
    **
    
2.  Select **Script Listeners**, under _ScriptRunner_.  
    
3.  Select **Create Script Listener**.
    
4.  In **Script Listener Name**, enter a name for your listener.
    
5.  Choose if you want it **Enabled** (or turned on).
    
6.  Choose at least one event for **On These Events**.  
    Remember, this is the event(s) that causes your listener to run. These are the available events:
    
    Type
    
    Action
    
    Attachment
    
    Created, Removed, Restored, Trashed, Updated, Viewed
    
    Blog
    
    Created, Removed, Restored, Trashed, Updated, Viewed
    
    Blueprint Page
    
    Created
    
    Comment
    
    Created, Removed, Updated
    
    Connect Addon
    
    Enabled, Disabled
    
    Label
    
    Added, Created, Deleted, Removed
    
    Login
    
    Login Event, Login Failed
    
    Logout
    
    Logout Event
    
    Page
    
    Children Reordered, Created, Moved, Removed, Restored,Trashed, Updated, Viewed
    
    Relation
    
    Created, Deleted
    
    Space
    
    Created, Logo Updated, Permissions Updated, Removed, Updated
    
    User
    
    Created, Deactivated, Followed, Reactivated, Removed
    
7.  For **As This User**, select if you want the listener run as the _Current User_ or the _ScriptRunner Add-On User_.
    
8.  And finally, write or select the code you wish to run in **Code to Run**.
    
    Script contexts
    
    The Script Context is a set of parameters/code variables that are automatically injected into your script to provide contextual data for the Script Listeners. They are displayed immediately above the code editor. The parameters in the Script Context are different for each Event.
    
    Common parameters in the Script Context for all the events are:
    
    -   `baseUrl` - Base url to make API requests against. This is the URL used for relative request paths e.g. if you make a request to `/rest/api/2/issue` we use the baseUrl to create a full request path.
        
    -   `logger` - Logger to use for debugging purposes. Check the methods available: [org.slf4j.Logger](https://www.slf4j.org/apidocs/org/slf4j/Logger.html).
        
    -   `timestamp` - The timestamp of the event in milliseconds, e.g. 1491562297883.
        
    -   `webhookEvent` - The webhook event type. Check out [Atlassian Connect Webhook Documentation](https://developer.atlassian.com/cloud/Confluence/platform/webhooks/) for more information.
        
    
9.  Select **Save**. 

## Script examples

ScriptRunner has a number of [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) for you to use. To access them, select this button in the **Script** field: 

![](/sr4cc/files/latest/107988516/288523539/1/1726000431000/click-example-scripts.png)

### **Preview of included Script Listener examples:**

-   Create a page hierarchy with templates
    -   Create a page hierarchy with templates can be used to create a similar page setup multiple times with a template. It is useful because it saves you time when setting up new Confluence Cloud pages.
-   Create Jira Tickets When a Page Is Created in Confluence
    -   _Create Jira Tickets When a Page is Created in Confluence_ can be used to onboard someone, like a to-do list or to automatically track work in Jira. It's useful because it reduces time spent on creating the Jira tickets, and it establishes and enforces business processes.
-   Set a Watcher For New Blog Posts
    -   _Set a Watcher For New Blog Posts_ automatically sets a watcher for new blog posts. It is useful because it allows a user to be always following new blog posts from a certain user.
-   Company Language Checker
    -   _Company Language Checker_ checks if a forbidden/incorrect word is used in a page and adds a comment if it is. For example, it could catch JIRA because it should be Jira. It is useful because instead of checking manually for words, a user can automate this and ensure that mistakes aren’t made.
        
        Once you have filled in the example code, you may have to do some editing to make the code work as you want it to. For example, you have to add the terminology that is a problem in your instance.
