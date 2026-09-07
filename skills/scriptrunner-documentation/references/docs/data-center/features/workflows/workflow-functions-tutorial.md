# Workflow Functions Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows
- Doc ID: doc-sr4js-442886199
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial

For a visual demonstration of workflow functions, see our [Workflow Functions training video](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-5-video-workflow-functions-in-scriptrunner-for-jira-data-center-server). 

ScriptRunner for Jira Server provides built-in and custom workflow functions. These workflow functions include built-in and custom validators, conditions, and post functions. ScriptRunner workflow functions allow you to do a lot more with your Jira workflows and further enhance your automation.

Explore the following sections within this page to learn more:

-   [Jira workflow functions](#id-.WorkflowFunctionsTutorialv9.x-jira-functions)
-   [ScriptRunner workflow functions](#id-.WorkflowFunctionsTutorialv9.x-sr-functions)
    -   [Available ScriptRunner conditions](#id-.WorkflowFunctionsTutorialv9.x-conditions)
    -   [Available ScriptRunner validators](#id-.WorkflowFunctionsTutorialv9.x-validators)
    -   [Available ScriptRunner post functions](#id-.WorkflowFunctionsTutorialv9.x-post-functions)
    -   [Access ScriptRunner workflow functions](#id-.WorkflowFunctionsTutorialv9.x-access-sr)
-   [Walkthrough examples of ScriptRunner workflow functions](#id-.WorkflowFunctionsTutorialv9.x-walkthrough)

### Jira workflow functions

As a reminder, a workflow is the series of steps through which a piece of work passes from conception to completion. In Jira, workflows are made up of two main parts; **statuses** and **transitions**. Statuses indicate that someone is working (or not working) on the issue, while transitions link statuses together. You can control several aspects of a transition's behavior in Jira. For instance, you can have:

-   **Conditions** that check to make sure the user should be able to perform a transition.
    
-   **Validators** which ensure that all needed changes have been made or that the changes that were made were valid.
    
-   **Post Functions** that program automated actions after the transition is performed.
    

These workflow functions enable a level of automation in your projects. This automation keeps your teams focused on their work, while Jira takes care of the repetitive tasks your team doesn’t need to focus on. However, you may find that Jira’s basic workflow functions don’t always do as much as you would like them to do—and that's where ScriptRunner workflow functions come in!

Jira Workflows

For more information on Jira Workflows, we recommend you familiarise yourself with the [Atlassian documentation on workflows](https://confluence.atlassian.com/adminjiraserver/working-with-workflows-938847362.html). 

### ScriptRunner workflow functions

For each of the Jira workflow functions, ScriptRunner for Jira provides built-in and custom workflow functions so that you have workflows that suit your exact needs. There are three main types of ScriptRunner workflow functions:

-   [ScriptRunner conditions](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions)
-   [ScriptRunner validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
-   [ScriptRunner post functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)

For example, you can use the [_All sub-tasks must be resolved_](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/all-sub-tasks-resolved-condition) built-in script condition to ensure that all sub-tasks have been resolved before the transition is allowed. See below for a full list of ScriptRunner workflow functions.

### Available ScriptRunner workflow conditions

The following ScriptRunner conditions are available when you add a condition to a workflow transition:

ScriptRunner conditions

Description

[Simple scripted condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)

Runs a simple embedded script to find out whether to show the action or not.

[Custom script condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/custom-script-condition)

Run your own Groovy script from a file or enter it into Jira.

[All sub-tasks must be resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/all-sub-tasks-resolved-condition)

Do not allow the action unless all sub-tasks have a resolution set. You can choose any resolution: a named one or the same as the parent task.

[Field(s) required condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/field-s-required-condition)

Allow the transition if required fields are completed.

[Group(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/group-s-condition)

Allow the transition if the current user is, or is not, a member of the specified group(s).

[JQL query matches condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/jql-query-matches-condition)

Allow the transition if the current issue matches the provided JQL query.

[Linked issues condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/linked-issues-condition)

Control the transition based on the status or resolution of linked issues or sub-tasks.

[Checks the issue has been in a status previously](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/checks-if-this-issue-has-been-in-a-status-previously-condition)

Require that this issue has been in the specified status either previously, or immediately prior.

[Project role(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-role-s-condition)

Allow the transition if the current user is, or is not, a member of the specified project role(s).

[Regular expression condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/regular-expression-condition)

Check a system or custom field value that matches a regular expression.

[User(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-s-condition)

Allow the transition if the current user is, or is not, included in the list of users.

[User in field(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-in-field-s-condition)

Allow the transition if the current user is in the _User_ or _Group_ field.

### Available ScriptRunner workflow validators

The following ScriptRunner validators are available when you add a validator to a workflow transition:

ScriptRunner validators

Description

[Custom script validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/custom-validators)

Run your own Groovy script from a file or enter it into Jira.

[Simple scripted validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators)

Run a simple embedded script to find out whether to allow the transition or not.

[Field(s) changed validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-changed-validator)

Enforce that one or more fields are changed as part of the transition.

[Require a comment on transition](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/require-a-comment-on-transition)

Enforce that a comment is provided on transition.

[Field(s) required validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-required-validator)

Allow the transition if _Required_ fields are completed.

[Regular expression validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/regular-expression-validator)

Make sure a system or custom field value matches a regular expression.

[User in field(s) validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/user-in-field-s-validator)

Allow the transition if the current user is in the _User_ or _Group_ field.

### Available ScriptRunner workflow post functions

The following ScriptRunner post functions are available when you add a post function to a workflow transition:

ScriptRunner post functions

Description

[Custom script post-function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions)

Run your own Groovy script from a file or entered into Jira.

[Add/remove from sprint](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-remove-from-to-active-sprint)

Add/remove the issue to/from a sprint on transition.

[Adds the current user as a watcher](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/adds-the-current-user-as-a-watcher)

Adds the user performing the action as a watcher, if condition applies.

[Archive this issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/archive-this-issue)

Archive the current issue, which can help improve performance.

[Assign to last role member](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-last-role-member)

Assign this issue to the last user from the specified role who this issue was assigned to previously.

[Assign to first member of role](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-first-member-of-role)

Assign to the first member of the specified role.

[Clear field(s)](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clear-field-s)

Clear selected fields.

[Clones an issue, and links](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clones-an-issue-and-links)

Clones this issue to another issue, optionally another project and issue type, and creates a link.

[Add a comment to this issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-a-comment-to-this-issue)

Adds a templated comment to the current issue, as the user making the transition.

[Copy field values](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/copy-field-values)

Copy field values from one field to another.

[Create a sub-task](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/create-a-sub-task)

Create a sub-task. Will optionally reopen a matching sub-task.

[Fast-track transition an issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fast-track-transition-an-issue)

If the condition is met, automatically transition this issue to another status.

[Fires an event when condition is true](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fires-an-event-when-condition-is-true)

Fires an event that can be picked up by a notification scheme, in order to send mail only under certain conditions, for example, _Priority_ is _Blocker_.

[Post a message to Slack](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/post-a-message-to-slack)

Allows you to define a customizable message to send to a Slack channel.

[Transition parent when all sub-tasks are resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/transition-parent-when-all-sub-tasks-are-resolved)

Transition the parent issue through the provided action when all sub-tasks are resolved.

[Send a custom email](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email)

Send an email based on the provided template if conditions are met.

[Set issue security level depending on provided condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/set-issue-security)

Sets the security level for an issue if the provided condition evaluates to `true`.

[Adds a comment to linked issues when this issue is transitioned](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/adds-a-comment-to-linked-issues-when-this-issue-is-transitioned)

Useful for alerting participants of other issues that a blocker is resolved, etc. This function should be put on the Resolve transition (or similar).

### Access ScriptRunner workflow functions

You can access ScriptRunner workflow functions as follows:

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition you wish to add a the workflow function to.
4.  Under **Options**, select then workflow function or your choice**.**

For detailed instructions on how to navigate to ScriptRunner workflow functions, see our [documentation](https://docs.adaptavist.com/sr4js/latest/features/workflows).

![](/sr4js/files/latest/442886199/442886226/1/1758746595000/Workflow_function_gif.gif)

Your next steps depend on if you edit a workflow condition, validator, or post function. We have provided you with examples for each in the section below.

Remember to publish!

Remember when editing a workflow, changes result in a draft that you must publish before you see them take effect in your workflow. Since you can use both built-in workflow functions and scripted workflow functions that you customize, there is a lot of flexibility to what you can do with ScriptRunner.

### Walkthrough examples of ScriptRunner workflow functions

The following pages include simple examples for you to follow so you can better understand how ScriptRunner workflow functions work:

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
