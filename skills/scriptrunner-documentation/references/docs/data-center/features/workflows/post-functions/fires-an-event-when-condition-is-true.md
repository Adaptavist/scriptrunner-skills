# Fires an Event when Condition is True

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885208
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fires-an-event-when-condition-is-true

The _Fires an event when condition is true_ post function enables you to trigger a specific [Jira event](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) based on a custom condition. Once fired, the event can be picked up by a [notification scheme](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html), determining who gets alerted.  

Jira events, such as the Issue created or Issue updated event, are predefined occurrences in an issue's lifecycle. This post function allows you to fire these events even if that event wouldn't normally be triggered at that point in the workflow. This post function only fires the event when your specified condition is met, providing precise control over when notifications are sent.

By combining custom conditions with Jira's existing event types and notification infrastructure, you can create highly targeted alerts. This post function bridges the gap between Jira's standard event system and your workflow's unique requirements, allowing for more flexible and responsive issue management and communication.

To make the most of this post function we recommend you familiarise yourself with [Jira events](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) and [notification schemes](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html). 

## Example

As an example, we have a software development project in Jira, and we want to automatically notify the QA team when a high-priority bug is resolved. We would do the following:

1.  Create a custom event in Jira called _High Priority Bug Resolved_.
2.  Create a notification scheme in Jira that listens for this custom event and sends an email to the QA team.
3.  Locate the transition where we want to add this post function (for example from _In Progress_ to _Resolved_).
4.  Add this post function to the chosen transition.
5.  Use the following condition in the post function:
    
    ```
issue.priority.name == "High" && issue.issueType.name == "Bug"
```
    
6.  Specify the event to be fired when the condition is true. In this case, we would use the custom event _High Priority Bug Resolved_.
    

The above is a summary of the steps you would take to create a Jira event, a notification scheme, and this post function. See below for more detailed steps on how to set up this post function. 

Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885208/442885209/1/1758746467000/Subtasks_1.png)  
    **
    
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Fires an event when condition is true**.  
    ![](/sr4js/files/latest/442885208/442885213/1/1758746467000/Fire+event.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Enter a condition. If no condition is specified, then this post function will always run.
10.  Choose the event you want to fire when the condition is `true`. 
11.  Select **Preview** to see an overview of the change. 
12.  Select **Add**.  
     ![](/sr4js/files/latest/442885208/442885214/1/1758746467000/Fire_event_2.png)
     
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
     
14.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![](/sr4js/files/latest/442885208/442885212/1/1758746467000/Subtasks_4.png)
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
