# Conditions Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Workflow Functions Tutorial
- Doc ID: doc-sr4js-27fc0025-b9e8-4996-9978-c55d7a7be941-52de04201746cb5b
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#workflow-functions-tutorial--en#conditions-tutorial--en

Before you start this tutorial, make sure you've read the [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial) page to understand what workflow functions are, for an overview of ScriptRunner workflow functions, and for details on how to access workflow functions.

For this tutorial, we assume you already have basic knowledge of how Jira workflow functions work.

## What is Great Adventure?

Great Adventure is the fictitious company we use to help provide use cases and examples of concepts covered. Great Adventure has the same problems and issues faced by most companies and needs to automate more of their processes using ScriptRunner.

## Overview of ScriptRunner workflow conditions

A condition checks to make sure that a requirement has been met before you can see the next workflow transition. For example, you can add a ScriptRunner workflow condition that checks all subtasks have a set resolution before the parent task can be transitioned. Depending on what your organization requires, you may want to use workflow conditions provided by ScriptRunner. These conditions allow you to do more in your workflow, providing extra control or information. ScriptRunner includes built-in conditions that you can use right away, but you can also create your own [Simple scripted condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition). For a full list of our conditions, check out the [available ScriptRunner workflow conditions](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial#available-scriptrunner-workflow-conditions--en).

## Navigate to ScriptRunner workflow conditions

Note: All of the ScriptRunner workflow functions are found alongside Jira workflow functions.

You can add a ScriptRunner condition to a workflow transition as follows:

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition.
4.  Under Options, select Conditions.
5.  Select Add condition.
    
    All available ScriptRunner conditions display along with all other available conditions. ScriptRunner post functions have a suffix of \[ScriptRunner\].
    

## Examples of ScriptRunner workflow conditions

Below are some easy-to-follow examples that will help you understand how ScriptRunner workflow conditions work.

Warning: We recommend that you do any script testing in a test instance and not your production instance.

Note: We recommend you set up and use a sample project for the following examples. See the [Tutorials](../../../training/tutorials.md) page for more information on creating a sample project.

### Built-in ScriptRunner workflow condition examples

#### All sub-tasks must be resolved condition

Note: Before you start this example, make sure you have a suitable workflow that includes a transition to a _Done_ or similar completed status.

In addition, when issues in this project are transitioned to _Done_, make sure the _Resolution_ automatically sets to the required state (in this case Done) using a post-function. This post-function is normally already set in most sample project workflows; see the [Jira Knowledge Base article on Resolutions](https://confluence.atlassian.com/jirakb/jira-issues-need-a-resolution-826873869.html) for more information.

Great Adventure has an onboarding process that requires several steps for a new team member's first day. Those steps are all represented as sub-tasks for the onboarding issue and include: meeting with the manager, attending company orientation, setting up their workstation, and updating their calendar. Great Adventure want to make sure all onboarding sub-tasks have a _Resolution_ of _Done_ before a new team member can mark their onboarding as complete. They can accomplish this by adding the _All sub-tasks must be resolved_ condition to the transition.

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition. In this example, we select the transition that leads to _Done_.
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select All sub-tasks must be resolved \[ScriptRunner\].
    
7.  Select Add.
8.  Optional: Enter a note that describes the condition. In this example we enter `All sub-tasks must be resolved`.
9.  Select a resolution. In this example we select `Done`.
10.  Select Preview to see an overview of the change.
11.  Select Update.
     
12.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow condition works.

[Media](https://docs.adaptavist.com/sr4js/latest/features#workflows--en#workflow-functions-tutorial--en#conditions-tutorial--en)

#### User in field(s) condition

Note: Before you start this example, make sure you have a suitable workflow that includes a transition from _To Do_ to the _In Progress_ status.

Great Adventure has been having issues with some team members who have started working on issues that are not assigned to them. Great Adventure want to make sure only the team member assigned to an issue can move it from _To Do_ to _In Progress_. They can accomplish this by adding the _User in field(s) condition_ to the transition that leads from _To Do_ to the _In Progress_ status.

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition. In this example, we select the transition that leads to _In Progress_.
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select User in field(s) condition \[ScriptRunner\].
7.  Select Add.
8.  Optional: Enter a note that describes the condition. In this example we enter `Only the assignee can move the issue to In Progress`.
9.  For the user field, select Assignee.
    
    Note: If you select multiple fields, the user only has to appear in one of those fields, not all of them.
    
10.  Select Preview to see an overview of the change.
11.  Select Update.
     
12.  Select Publish and choose if you want to save a backup copy of the workflow.

You can now test to see if this workflow condition works.

[Media](https://docs.adaptavist.com/sr4js/latest/features#workflows--en#workflow-functions-tutorial--en#conditions-tutorial--en)

You could expand on this example and make sure a user can't move the issue directly to _Done_ by adding the _[Checks if this issue has been in a status previously](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/checks-if-this-issue-has-been-in-a-status-previously-condition)_ condition.

### Scripted ScriptRunner workflow condition examples

#### All QA sub-tasks must be resolved - Simple scripted condition

Before you start this example, make sure you have a suitable workflow that includes a transition from _To Do_ to _In Progress_ or similar.

In addition, when issues in this project are transitioned to _Done_, make sure the _Resolution_ automatically sets to the required state (in this case Done) using a post-function. This post-function is normally already set in most sample project workflows; see the [Jira Knowledge Base article on Resolutions](https://confluence.atlassian.com/jirakb/jira-issues-need-a-resolution-826873869.html) for more information.

Great Adventure want to make sure all QA tasks, for validating an issue, have been resolved before the issue can be moved to _In Progress_. As this is a more specific requirement Great Adventure need to use a _Simple scripted condition_ instead of the _All sub-tasks must be resolved_ condition.

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition. In this example, we select the transition that leads to _In Progress_.
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select Simple scripted condition \[ScriptRunner\].
    
7.  Select Add.
8.  Optional: Enter a note that describes the condition. In this example we enter `QA must validate before transition to In Progress`.
9.  Enter the following condition:
    
    ```
    def subTasks = issue.getSubTaskObjects()
     
    return !subTasks.any {
        it.issueType.name == "QA" && !it.resolution
    }
    ```
    
10.  Optional: Enter an issue key to preview if the result evaluates `true` or `false`.
11.  Select Update.
     
12.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow condition works.

[Media](https://docs.adaptavist.com/sr4js/latest/features#workflows--en#workflow-functions-tutorial--en#conditions-tutorial--en)

You could expand on this example and make sure a user can't move the issue directly to _Done_ by adding the _[Checks if this issue has been in a status previously](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/checks-if-this-issue-has-been-in-a-status-previously-condition)_ condition.

#### All linked issues must be resolved - Simple scripted condition

Note: Before you start this example, make sure you have a suitable workflow that includes a transition from _In Progress_ to _Done_ or similar.

In addition, when issues in this project are transitioned to _Done_, make sure the _Resolution_ automatically sets to the required state (in this case Done) using a post-function. This post-function is normally already set in most sample project workflows; see the [Jira Knowledge Base article on Resolutions](https://confluence.atlassian.com/jirakb/jira-issues-need-a-resolution-826873869.html) for more information.

Great Adventure is having problems with issues being marked as _Done_ when they still have other issues, linked as blockers, that are still _In Progress_. If an issue is blocked by any other issue, Great Adventure want to make sure that the issue with blockers cannot be transitioned to _Done_ until all blockers are resolved. As this is a more specific requirement Great Adventure need to use a Simple scripted _condition_ instead of the _All sub-tasks must be resolved_ condition.

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition.
    
    In this example, we select the transition that leads to _Done_.
    
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select Simple scripted condition \[ScriptRunner\].
    
7.  Select Add.
8.  Optional: Enter a note that describes the condition.
    
    In this example we enter `All blockers must be complete before transition`.
    
9.  Enter the following condition:
    
    ```
    def passesCondition = true
     
    // Get all inward links of the issue
    def inwardLinks = issue.getInwardLinks()
     
    // Check each inward link for the specified link type and resolution status
    inwardLinks.each { link ->
     if (link.issueLinkType.name == "Blocks" && !link.sourceObject.resolution) {
            passesCondition = false
        }
    }
     
    // The variable passesCondition will be false if there's at least one inward link of type "Blocks" with an unresolved source issue
    return passesCondition
    ```
    
    Because this is a custom script, you can change items. For example, you could change the linkType to `Duplicates` or `Causes` to define a different relationship.
    
10.  Optional: Enter an issue key to preview if the result evaluates `true` or `false`.
11.  Select Update.
     
12.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow condition works.

[Media](https://docs.adaptavist.com/sr4js/latest/features#workflows--en#workflow-functions-tutorial--en#conditions-tutorial--en)

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
