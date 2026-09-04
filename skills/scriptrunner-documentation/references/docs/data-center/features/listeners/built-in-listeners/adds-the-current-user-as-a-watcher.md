# Adds the Current User as a Watcher

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442888798
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/adds-the-current-user-as-a-watcher

This listener adds the current user (the user performing the action) as a watcher on the issue. You may want to:

-   Add all users logging work in the issue as watchers.
    
-   Add the current user as a watcher if they edit the issue and set the priority to _Highest_. 

This listener is similar to using the _Participants_ field in the notification scheme, however, using a listener allows people to remove themselves as watchers if required.

1.  Select the **Adds the current user as a watcher** built-in listener.
2.  Enter a description of the listener in **Name**.
3.  Define which project(s) the listener should be **Applied to**.  
    You can either check _Global_ to apply the listener to all projects or check _Select projects(s)_ and define the projects you want to assign the listener to. 
4.  Select the **Events** on which the listener fires.   
    For example, to add any user who edits the issue as a watcher, choose the **Issue Updated** event.
5.  You can further refine this by entering a **C****ondition**, for instance, if you wanted to restrict this behaviour to just certain components or certain priorities of issue.
6.  Select **Add.**
