# Post Functions Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > workflow-functions-tutorial
- Doc ID: doc-sr4js-442886149
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial

Before you start this tutorial, make sure you've read the [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial) page to understand what workflow functions are, for an overview of ScriptRunner workflow functions, and for details on how to access workflow functions.

For this tutorial, we assume you already have basic knowledge of how Jira workflow functions work. 

**What** **is Great Adventure?**

Great Adventure is the fictitious company we use to help provide use cases and examples of concepts covered. Great Adventure has the same problems and issues faced by most companies and needs to automate more of their processes using ScriptRunner.

## Overview of ScriptRunner workflow post functions

A post function is a workflow function that performs automated actions **after** an issue transitions to a new status. For example, you can add a ScriptRunner post function to an issue that adds a comment to specific linked issues when an issue is transitioned. Every Jira issue has some essential post functions that you can neither remove nor edit, but you can add additional post functions to your workflows. Depending on what your organization requires, you may want to use ScriptRunner post functions. ScriptRunner post functions allow you to do more in your workflow, providing extra control or information. ScriptRunner includes built-in post functions that you can use right away, but you can also create your own [Custom script post-function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions). For a full list of our post functions, check out the [available ScriptRunner workflow post functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial#post-functions). 

### Custom script post function

A ScriptRunner _Custom script post-function_ requires some Groovy scripting but allows you to tailor your post function to your needs using inline scripts. You can add the code inline or upload a script file. If you are comfortable working in Groovy, you may want to use this custom option for your scripted post functions in Jira. If you aren't entirely comfortable, you can still use one of our [post function example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=post-functions&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter).

## Navigate to ScriptRunner workflow post functions

All of the ScriptRunner workflow functions are found alongside Jira workflow functions. 

You can add a ScriptRunner post function to a workflow transition as follows:

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function.
4.  Under **Options**, select **Post Functions.  
    **
5.  Select **Add post function**.  
    All available ScriptRunner post functions display along with all other available post functions. ScriptRunner post functions have a suffix of **\[ScriptRunner\]**.

## Examples of ScriptRunner workflow post functions

Below are some easy-to-follow examples that will help you understand how ScriptRunner workflow post functions work.

We recommend that you do any script testing in a test instance and not your production instance.

We recommend you set up and use a sample project for the following examples. See the [Tutorials](https://docs.adaptavist.com/sr4js/8.22.0/training/tutorials#before-you-start) page for more information on creating a sample project. 

### Built-in ScriptRunner workflow post functions

#### Adds a comment to linked issues when this issue is transitioned

Before you start this example, make sure you have a suitable workflow that includes a transition to _Done_ (or equivalent).

Great Adventure needs to add comments on blocked issues when the parent blocker issue has been resolved. This comment should indicate that the main issue was fixed and the blocked issue may be closed now. To help with this situation, Great adventure plans to use the _Adds a comment to linked issues when this issue is transitioned_ post function. 

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function. In this example, we select the transition that leads to _Done_.
4.  Under **Options**, select **Post Functions.  
    ![Image showing post function option highlighted](/sr4js/files/latest/442886149/442886179/1/1758746552000/Adds_comments_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Adds a comment to linked issues when this issue is transitioned \[ScriptRunner\]**.  
    ![Image showing chosen post function selected](/sr4js/files/latest/442886149/442886167/1/1758746551000/Adds_comment_2.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions). In this example we enter `Comments on parent issue when blockers are resolved`.
9.  Optional: Enter a condition. An empty condition evaluates the function to `true`. In this example, we leave the condition blank. 
10.  Select the link type. In this example we select `blocks`.
11.  Add the following comment:  
     
     ```
Blocking issue $issue resolved with resolution <% out << issue.resolution?.name %>.
```
     
12.  Select **Preview** to see an overview of the change. 
13.  Select **Update**.  
     ![Image of completed post function](/sr4js/files/latest/442886149/442886180/1/1758746552000/Adds_comments_3.png)  
     
14.  Reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Make sure this post function occurs after the pre-generated post functions.
     
     ![Image of post function position](/sr4js/files/latest/442886149/442886172/1/1758746551000/Adds_comments_4.png)
     
15.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image of publish button highlighted](/sr4js/files/latest/442886149/442886153/1/1758746550000/Adds_comments_5.png)
     

You can now test to see if this post function works.

1.  Create an issue and a blocked issue that uses the workflow you edited.
    
2.  Transition the blocker issue to _Done_ (or equivalent)_._
    
3.  Go to the blocked issue.
    
4.  Under **Activity**, you should see the comment added automatically. If you see the comment added, you are good to go with this script post function.  
    ![Image of final result](/sr4js/files/latest/442886149/442886162/1/1758746551000/Adds_comments_6.png)
    

#### Assign to first member of role when an issue is high priority

Great Adventure is having problems with high priority bugs being missed by the development team. To resolve this Great Adventure wants to make sure all High and Highest priority issues are automatically assigned to a developer using the _Assign to first member of role_ post function. 

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function. In this example, we select the _Create_ transition.
4.  Under **Options**, select **Post Functions.  
    ![Image showing post function option highlighted](/sr4js/files/latest/442886149/442886174/1/1758746551000/Assign_to_member_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Assign to first member of role \[ScriptRunner\]**.  
    
    ![Image showing chosen post function selected](/sr4js/files/latest/442886149/442886181/1/1758746552000/Assign_to_member_2.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions). In this example we enter `Automatically assign High and Highest priority issues to a developer`.
9.  Enter the following condition:  
    
    ```
issue.priority.name in ["High", "Highest"]
```
    
10.  For **Role**, select _Developers_.
11.  Select **Preview** to see an overview of the change. 
12.  Select **Update**.  
     ![ Image of completed post function](/sr4js/files/latest/442886149/442886173/1/1758746551000/Assign_to_member_3.png)  
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image of publish button highlighted](/sr4js/files/latest/442886149/442886177/1/1758746552000/Assign_to_member_4.png)

You can now test to see if this post function works:

1.  Create a _High_ or _Highest_ priority issue in your chosen project.
2.  Check if the new issue is automatically assigned to a developer.

### Scripted ScriptRunner workflow post function example

#### Close all sub-tasks when the parent issue resolution is done

Before you start this example, make sure you have a suitable workflow that includes a transition to _Done_ (or equivalent).

Great Adventure want to close sub-tasks automatically when a parent task is marked as _Done_. To resolve this Great Adventure can use a _Custom script post-function_. 

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function. In this example, we select the _Done_ transition.
4.  Under **Options**, select **Post Functions.  
    ![Image showing post function option highlighted](/sr4js/files/latest/442886149/442886168/1/1758746551000/Close_subtasks_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Custom script post-function \[ScriptRunner\]**.  
    
    ![Image showing chosen post function selected](/sr4js/files/latest/442886149/442886175/1/1758746551000/Close_subtasks_2.1.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions). In this example we enter `Close all sub-tasks when the parent issue resolution is done`.  
    
    Make sure you update the resolution, statuses, and transitions to appropriately match your workflow and instance. 
    
    ```
// Get all sub-tasks of the current issue
def subTasks = issue.getSubTaskObjects()

subTasks.each { subTask ->
    if (subTask.status.name in ["To Do", "In Progress"]) {
        // Transition the sub-task to a resolved state with a comment
        subTask.transition('Done') { // Use the name of the transition you want to perform
            setResolution('Done') // Use the name of the resolution you want to set
            setComment("*Resolving* as a result of the *Resolve* action being applied to the parent.")
        }
    }
}
```
    
9.  Select **Update**.  
    ![ Image of completed post function](/sr4js/files/latest/442886149/442886156/1/1758746550000/Close_subtasks_2.png)  
    
10.  Reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Make sure this post function occurs after the pre-generated post functions.  
     ![Image of post function position](/sr4js/files/latest/442886149/442886152/1/1758746550000/Close_sibtasks_3.png)
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image of publish button highlighted](/sr4js/files/latest/442886149/442886151/1/1758746550000/Close_subtasks_4.png)

This post function is successful if, when the primary task is marked as **Done** with a **Resolution** of _Done_, all associated sub-tasks are also closed.  
![GIF of final result](/sr4js/files/latest/442886149/442886150/1/1758746549000/Close_subtasks_5.gif)

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
