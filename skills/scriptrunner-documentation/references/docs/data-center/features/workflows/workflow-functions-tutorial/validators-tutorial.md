# Validators Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > workflow-functions-tutorial
- Doc ID: doc-sr4js-442886228
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial

Before you start this tutorial, make sure you've read the [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial) page to understand what workflow functions are, for an overview of ScriptRunner workflow functions, and for details on how to access workflow functions.

For this tutorial, we assume you already have basic knowledge of how Jira workflow functions work. 

**What** **is Great Adventure?**

Great Adventure is the fictitious company we use to help provide use cases and examples of concepts covered. Great Adventure has the same problems and issues faced by most companies and needs to automate more of their processes using ScriptRunner.

## Overview of ScriptRunner workflow validators

A validator checks to see if the user can transition an issue. Validators do not prevent the next transition button from appearing (that would be a [condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)). For example, you could add a ScriptRunner validator that ensures a user adds a comment when transitioning an issue to _Done_, or equivalent. Depending on what your organization requires, you may want to use workflow validators provided by ScriptRunner. These validators allow you to do more in your workflow, providing extra control or information. ScriptRunner includes built-in validators that you can use right away, but you can also create your own [Simple scripted validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators). For a full list of our validators, check out the [available ScriptRunner workflow validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial#validators). 

## Navigate to ScriptRunner workflow validators

All of the ScriptRunner workflow functions are found alongside Jira workflow functions. 

You can add a ScriptRunner validator to a workflow transition as follows:

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a validator to. 
3.  Select the transition to which you wish to add a validator.
4.  Under **Options**, select **Validators.  
    **
5.  Select **Add validator**.  
    All available ScriptRunner validators display along with all other available validators.

## Examples of ScriptRunner workflow validators

Below are some easy-to-follow examples that will help you understand how ScriptRunner workflow validators work.

We recommend that you do any script testing in a test instance and not your production instance.

We recommend you set up and use a sample project for the following examples. See the [Tutorials](https://docs.adaptavist.com/sr4js/8.22.0/training/tutorials#before-you-start) page for more information on creating a sample project. 

### Built-in ScriptRunner workflow validator examples

#### Field(s) required validator

Great Adventure needs every onboarding issue to show which department a new team member belongs to, and have created the Department custom field. Unfortunately, many users are transitioning the onboarding issues without updating the **Department** field first. To help with this situation, Great Adventure plans to use the _Field(s) required validator_ to make sure users complete the **Department** field before they can transition it to _In Progress_.

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a validator to. 
3.  Select the transition to which you wish to add a validator. In this example, we select the transition that leads to _In Progress_.
4.  Under **Options**, select **Validators.  
    ![Image showing Validators option highlighted](/sr4js/files/latest/442886228/442886246/1/1758746633000/Select_validators.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Field(s) required validator \[ScriptRunner\]**.  
    ![Image showing the fields required validator selected](/sr4js/files/latest/442886228/442886242/1/1758746633000/Field_required_selected.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators). In this example we enter `Department field is required`.
9.  Optional: Enter a condition for this function to fire on. An empty condition evaluates the function to `true`.  
10.  Select the required field(s). In this example we select `Department`.
11.  Select **Preview** to see an overview of the change. 
12.  Select **Update**.  
     ![Image showing the completed validator](/sr4js/files/latest/442886228/442886239/1/1758746632000/Field_required_filled_in.png)  
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image showing publish selected](/sr4js/files/latest/442886228/442886232/1/1758746632000/Field_required_publish.png)
     
     You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue to In progress without the _Department_ field completed.   
     ![Image showing the error message](/sr4js/files/latest/442886228/442886234/1/1758746632000/Field_required_error.png)
     

#### User in field validator

Before you start this example, make sure you have a suitable workflow that includes a transition from _In Progress_ to _Awaiting Approval_ to _Approved_.

Great Adventure wants to improve their approval process and make sure only those assigned as _Approvers_ can approve an issue. To do this, Great Adventure plans to use the _User in field(s) validator_ to make sure only users within the _Approvers_ custom field can transition the issue to _Approved_.

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a validator to. 
3.  Select the transition to which you wish to add a validator. In this example, we select the transition that leads from _Awaiting Approval_ to _Approved_.
4.  Under **Options**, select **Validators.  
    ![Image showing validator selected in the workflow screen](/sr4js/files/latest/442886228/442886231/1/1758746631000/Approval_validator_1.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **User in field(s) validator \[ScriptRunner\]**.  
    ![Image showing the user in field validator selected](/sr4js/files/latest/442886228/442886244/1/1758746633000/User_in_field_screen.png)  
    
7.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators). In this example we enter `User must be an Approver`.
8.  Enter an error message that displays if the logged-in user is not in the selected field. In this example we enter `Only the Approver can move this issue to Approved`. 
9.  Select **Preview** to see an overview of the change. 
10.  Select **Update**.  
     ![Image showing the completed validator](/sr4js/files/latest/442886228/442886229/1/1758746631000/Approval_validator_2.png)  
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image showing the publish option](/sr4js/files/latest/442886228/442886241/1/1758746633000/Approval_validator_3.png)  
     
     You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue to _Approved_ and you're not the _Approver_.   
     ![Image showing the error message](/sr4js/files/latest/442886228/442886245/1/1758746633000/Approval_validator_4.png)
     

### Scripted ScriptRunner workflow validator example

#### Require Fix Version - Simple scripted validator

Before you start this example, make sure you have a suitable workflow that includes a transition from _Awaiting Release_ to _Fixed_.

In addition, make sure the _Fixed_ transition (from _Awaiting Release_ to _Fixed_) includes a _Resolve Issue_ screen that includes both the _Resolution_ and _Fix version_. 

![Image showing the transition screen](/sr4js/files/latest/442886228/442886243/1/1758746633000/Fix_version_2.png)

In Great Adventure’s Software Development team, they use **Fix Versions** to track when the team resolves bugs in the products. Similar to the **Component** issue, many users forget to add the **Fix Version** when completing the issue. Great Adventure has decided to use a script validator in their Software Development project, so when a user sets the resolution to _Fixed_, they also have to add the correct **Fix Version**.

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a validator to. 
3.  Select the transition to which you wish to add a validator. In this example, we select the transition that leads from _Awaiting Release_ to _Fixed_.
4.  Under **Options**, select **Validators.  
    ![Image showing the validator option selected from the workflow screen](/sr4js/files/latest/442886228/442886247/1/1758746633000/Fix_version_1.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Simple scripted validator \[ScriptRunner\]**.  
    ![Image showing the validator selected](/sr4js/files/latest/442886228/442886235/1/1758746632000/Fix_version_3.png)  
    
7.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators). In this example we enter `Require fix version`.
8.  Enter the following condition:  
    
    ```
issue.resolution.name != "Fixed" || issue.fixVersions
```
    
    If `Fixed` isn't an available resolution on your instance, you can replace the `Fixed` resolution with a resolution of your choice. 
    
9.  Enter an error message that displays if the _Fix Version_ field is empty. In this example we enter `You must provide a fix version for this issue`. 
10.  Select the _Fix Version/s_ field. 
11.  Select **Preview** to see an overview of the change. 
12.  Select **Update**.  
     ![Image showing the completed validator](/sr4js/files/latest/442886228/442886249/1/1758746634000/Fix_version_4.png)  
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image showing the Publish button highlighted](/sr4js/files/latest/442886228/442886248/1/1758746634000/Fix_version_5.png)
     

  

You can now test to see if this workflow validator works.

1.  Transition an issue in your chosen project to _Fixed_.
2.  When the **Resolve Issue** screen pops up, enter the resolution of _Fixed_ (or chosen equivalent).
3.  Leave the **Fix version** blank.
4.  Select the **Fixed** button (or chosen equivalent).  
    You will get an error that stops you from transitioning unless the Fix version is provided.  
    ![Image showing the error message displaying](/sr4js/files/latest/442886228/442886250/1/1758746634000/Fix_version_6.png)

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
