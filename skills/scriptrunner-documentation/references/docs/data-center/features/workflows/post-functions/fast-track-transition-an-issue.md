# Fast-track Transition an Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885192
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fast-track-transition-an-issue

The _Fast-track transition an issue_ post-function transitions an issue to a chosen status if the provided condition holds true. For example, we can use this post function to make sure any issues created with the priority status of _Highest_ are immediately escalated. 

This post function can be applied multiple times within a single transition, such as the _Create Issue_ transition. By doing so, you can dynamically set different default start statuses for an issue based on specific conditions you define.

## Post function actions and options

You can specify additional actions and options to optimize this post function—we provide information on these below. 

### Additional issue actions

When fast-track transitioning an issue you may want to perform additional actions, such as adding a comment to the issue, assigning a person, updating fields, or adding a resolution. This is all done through _Additional issue actions_ code editor. For example, if you use this post function to resolve an issue you can use the following code to set the resolution and assign the issue to a user:

```
import com.atlassian.jira.component.ComponentAccessor

def constantsManager = ComponentAccessor.getConstantsManager()
def resolution = constantsManager.resolutions.findByName("Done")
issueInputParameters.setResolutionId(resolution.id)

issueInputParameters.setAssigneeId("admin")
```

If you want to add a comment to the issue you can use the following:

```
issueInputParameters.setComment('your comment')
```

#### Update fields

We use [`IssueService`](https://docs.atlassian.com/jira/latest/com/atlassian/jira/bc/issue/IssueService.html) to execute the fast-track transitions, which aims to mimic the behavior of the user interface. By default, you can only update fields that appear on the transition screen. If you need to update a field that isn't on the screen, or if there's no screen associated with the transition, you can use the following code:

```
issueInputParameters.skipScreenCheck()
```

This allows you to update the issue even without a screen present.

### Transition options

We provide advanced transition options that allow you to selectively bypass permissions, validators, and conditions during a transition. These features provide greater flexibility in workflow management:

-   **Skip Permissions**: Force transitions to occur even when the user lacks the typically required permissions.
-   **Skip Validators**: Proceed with transitions even when standard validation rules aren't met.
-   **Skip Conditions**: Execute transitions regardless of predefined conditional checks. This function does not apply to the condition on the _Fast-track transition an issue_ page. This function only applies to other conditions that are associated with the transition you select from the **Action** drop-down.

These options are particularly useful for automating processes that need to operate outside standard user permissions.

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885192/442885201/2/1758746465000/Fast-track-1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Fast-track transition an issue**.  
    ![](/sr4js/files/latest/442885192/442885200/1/1758746464000/Fast-track-2.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Enter a condition. This post function will fast-track transition an issue whenever this condition evaluates to `true`. 
    
    Select **Examples scripts** for help building your condition. 
    
10.  Enter an action. This is the transition that will be applied to an issue when the above condition evaluates to `true`. 
     
     The transition must be valid for the current status, otherwise the issue will not be transitioned. For example, if we put this post-function on the _Create Issue_ transition which leads to the _Open_ status (as shown in the image above), valid transitions are those that lead from the _Open_ status to another status. 
     
     When selecting an action, you might encounter multiple actions/transitions with identical names but different IDs. View a workflow in _Text_ mode to identify the specific ID for each transition.
     
11.  Optional: Enter any additional actions you want to occur.
     
     For example, if we want to add a comment to issues we have fast-tracked using this post function we would use `issueInputParameters.setComment('This issue has been escalated')`.
     
12.  Choose if you want to skip any transition checks—**Skip Permissions**, **Skip Validators**, and **Skip Conditions**. 
13.  Select **Preview** to see an overview of the change.
14.  Select **Add**.  
     ![](/sr4js/files/latest/442885192/442885199/1/1758746464000/Fast-track-3.png)  
     
15.  Reorder your new post function using the arrow icons on the right of the function (they can only move one line at a time).  
     
     Place this as the **last** post-function or at least after the _Fire Event_ function. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
     
16.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885192/442885203/2/1758746465000/Fast-track-4.png)  
     
     Test your post function
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
