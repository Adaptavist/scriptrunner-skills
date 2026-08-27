# Features

- Platform: cloud
- Space: SR4JC
- Hierarchy: n/a
- Doc ID: doc-sr4jc-101629085
- Source: https://docs.adaptavist.com/sr4jc/latest/features

![](/sr4jc/files/latest/101629085/403866161/1/1752050614000/sr-migrate+%281%29.png)

Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud) section.

This page summarises ScriptRunner for Jira Cloud's features, and describes additional functionality we have developed to optimize your scripting experience.

You can find all of the following features within the ScriptRunner menu. Check out our [Navigation](https://docs.adaptavist.com/sr4jc/latest/get-started/navigation) page for more information on how to navigate ScriptRunner. 

### [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search)

The ScriptRunner Enhanced Search feature provides advanced [JQL function](https://docs.adaptavist.com/sr4jc/current/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) search capabilities, or _queries_, in Jira Cloud, which you can modify or extend. You can use ScriptRunner JQL functions anywhere you are able to use Jira JQL functions.

### [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console)

Use the Script Console to experiment and run scripts on the script editor. You can enter your own scripts, or use one of the many example scripts provided. The Script Console is useful for testing scripts or performing operations that you only want to do once.

### [Built-In Scripts](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts)

Use Built-In Scripts to automate manual, complex, and time-consuming tasks. Built-in scripts have been created for some of the most commonly run tasks in ScriptRunner for Jira Cloud. For example, you can use the [Bulk Clone Work Items](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-clone-work-items) to select Jira work items to clone and move to another space as a set of work items in bulk.

### [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs)

Use Jobs to automate the running of scripts at regular intervals—saving your administrators time, and reducing the risk of human error.

### [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)

Use Script Listeners to create automated procedures in ScriptRunner that listen for a specific event to occur in Jira and then carry out an action when it does. Script Listeners sit on your instance and wait for a [webhook event](https://developer.atlassian.com/cloud/jira/platform/webhooks/) to happen before executing the listener script. Webhooks are fired after an action has taken place in Jira, such as when a space is created or if a work item is updated.

### [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules)

Use Workflows to enhance and automate your workflows beyond Jira's native possibilities. ScriptRunner for Jira Cloud extensions to Atlassian's workflows enable you to set up rules relating to the transition of a work item's status within Jira Cloud, giving you increased control over how and when a work item transitions. You can also set up post-transition rules.

### [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours)

Use Behaviours to define how fields behave for work items in a given space or work item context. For example, you may want to create a behaviour that hides a field for a specific user group until it's relevant for them to interact with that particular field. 

### [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service)

The _Escalation Service_ allows you to define a process for modifying work items after a certain amount of time has elapsed. This is useful for business procedures that require tasks to be completed within a certain time-frame (service level agreement). Escalation Services can be used if, for example, a task has been opened but not assigned for 7 days. You could automatically move it to a "Prioritize" status, or add a comment, which will cause an email to be sent.

### [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables)

You can use _Script Variables_ to specify variables that can be inserted into your scripts ([Script Console](https://docs.adaptavist.com/sr4jc/current/features/script-console), [Script Listeners](https://docs.adaptavist.com/sr4jc/current/2021-03-09_10-28-39_-script-listeners-vdraft), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/current/features/workflow-extensions/post-functions), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/current/features/scheduled-jobs), [Escalation Service](https://docs.adaptavist.com/sr4jc/current/features/escalation-service)). The variables are encrypted and stored within your ScriptRunner for Jira Cloud instance. You can use them to share common variables between your scripts, or to store sensitive data such as passwords that require encryption rather than hard-coding them directly in scripts.

### [Script Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments)

Use UI Fragments to customize the UI of your Jira instance. For example, you can use this feature to [create a custom link or button](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) or [show a custom banner](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) on your JIra instance. 

### [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)

Use Scripted Fields to display information that would otherwise be unavailable for a work item by calculating or combining data from one or more existing fields and displaying the result in as a custom field. The results are updated when viewing a work item and when a work item containing a Scripted Field is updated. You can enter your own script into the script editor, or use one of the many example scripts provided.

## Useful features to improve your scripting experience

### [HAPI](https://docs.adaptavist.com/sr4jc/latest/hapi)

HAPI is an API developed to carry out common tasks in Jira, including managing work items, searching for work items, updating fields and much more! HAPI is a simple alternative to Jira's regular API and can be used in your Groovy scripts. See the [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi) page for more details on this feature and to find examples of how to use HAPI. 

Not confident with scripting?

Many ScriptRunner features include built-in scripts that require minimal scripting experience. Our documentation offers practical examples, and you can use example scripts in the code editors of several features or explore more on our [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira). Check out our [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) overview too!
