# Set Issue Security

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-e6e51469-69d2-4112-af78-dd40d4b2af90-c7b74cdb95337643
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#set-issue-security--en

Use this post function to set the [security level](https://confluence.atlassian.com/adminjiraserver/configuring-issue-level-security-938847117.html) of an issue based on a custom condition. This can help ensure that sensitive information is only visible to the appropriate users. For example, you can use this post function to make sure that issues created by those in the _business-users_ group are marked as _Private_. This is useful in situations where business-related issues contain sensitive information that should not be visible to all users.

## Security level schemes

Each project in Jira can be associated with a specific security level scheme, which contains one or more security levels. If you are applying this post function to multiple projects, ensure that all those projects use the same issue security level scheme. If the specified security level scheme or the security level itself does not exist in Jira, a message will be recorded in the application log file. Users performing the action that triggers the post function will not receive any direct alerts or notifications about the missing scheme or level.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this post function to.
3.  Select the transition you want to add this post function to.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Set issue security level depending on provided condition.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
    
    Tip: In the example pictured, we use this post function to make sure that issues created by those in the business-users group are marked as Private. We use the following condition: 
    
    ```
    import com.atlassian.jira.component.ComponentAccessor
    
    def groupManager = ComponentAccessor.getGroupManager()
    groupManager.isUserInGroup(issue.reporter, 'business-users')
    ```
    
10.  Choose the security level you want to set when the condition evaluates to `true`.
11.  Select Preview to see an overview of the change.
12.  Select Add.
     
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). If this post function is added to the Create Issue transition it should sit before the Creates the issue and Fires an Issue Created event post functions. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order--en) for more information.
14.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this post function works.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
