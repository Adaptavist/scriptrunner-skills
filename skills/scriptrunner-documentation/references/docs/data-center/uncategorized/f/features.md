# Features

- Platform: data-center
- Space: SR4JS
- Hierarchy: n/a
- Doc ID: doc-sr4js-9ccd8795-aec9-43fe-aa5d-02cd1abef5b8-cb0ae44c5664cb3f
- Source: https://docs.adaptavist.com/sr4js/latest/features

This page summarises the main features of ScriptRunner for Jira Data Center and describes additional features we have developed to optimize your scripting experience. See _[Navigation](../../get-started/navigation.md)_ for more information on how to access ScriptRunner features.

|  |  |
| --- | --- |
|  | Take our _ScriptRunner Tour_ to help you get started and gain access to helpful videos and demos.<br>[ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/data-center/get-started) |

Note: ScriptRunner Migration

If you are migrating from ScriptRunner for Jira Data Center to Cloud, everything you need to know about how features will work is detailed in [ScriptRunner Migration](../../script-runner-migration/script-runner-migration-to-cloud.md).

## Main ScriptRunner features

You can find all of the following features within the ScriptRunner menu. Check out our [Navigation](../../get-started/navigation.md) page for more information on how to navigate ScriptRunner.

Tip: Not confident with scripting?

Many features in ScriptRunner come with built-in scripts that require minimal to no scripting experience. Our documentation also provides practical examples for using these features, making it possible to use ScriptRunner effectively without extensive scripting knowledge.

### Script Console

Use the Script Console to run one-off ad hoc scripts and to experiment with the [Jira REST API](https://docs.atlassian.com/software/jira/docs/api/REST/latest/) and [HAPI](../h/hapi.md). The [Script Console](https://docs.adaptavist.com/sr4js/latest/features/script-console) page includes a script editor box to copy/paste or write your script.

Note: Static type checking

The Script Console, and anywhere you use a custom script, benefits from [static type checking](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/static-type-checking) which provides information on whether your script is correctly written.

### Built-In Scripts

Use Built-In Scripts to automate manual, complex, and time-consuming tasks. For example, you can use this feature to [modify field resolutions in bulk](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-fix-resolutions) or [view a list of all scheduled jobs](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/list-scheduled-jobs) set to run in your Jira instance. See the [Built-In Scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts) page for more details on this feature and to find all of the Built-in Scripts available to you.

### Listeners

Use Listeners to create automated procedures in ScriptRunner that listen for a specific event to occur in Jira, and then carry out an action when it does occur. For example, you can use this feature to [create a sub-task](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/create-a-sub-task) or [send a custom email](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email) when a certain event occurs. See the [Listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners) page for more details on this feature and to find all of the Listeners available to you.

### Behaviours

Use Behaviours to define how fields behave for issues in a given project or issue context. For example, you can use this feature to [set field defaults](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/setting-field-defaults) or [set fields as required](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/field-required) under specific conditions. See the [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours) page for more details on this feature and to find multiple examples of how you can use it.

### Script Fields

Use Script Fields to display information that would otherwise be unavailable for an issue by calculating or combining data from one or more existing fields and displaying the result as a custom field. For example, you can use this feature to [calculate a number based on other fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples#calculate-a-number-based-on-other-fields--en) or [show the total time an issue has been in progress](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples#show-the-total-time-this-issue-has-been-in-progress--en) by creating a [custom script field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field). See the [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields) page for more details on this feature and to find all of the Script Fields available to you.

### Workflows

Use Workflows to enhance and automate your workflows beyond Jira's native possibilities. For example, you can use this feature to create a condition that [resolves the parent task when all sub-tasks are resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/all-sub-tasks-resolved-condition), or create a validator that [requires a comment for an issue to be moved to a chosen transition](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/require-a-comment-on-transition). See the [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows) page for more details on this feature and to find all of the conditions, validators and post functions available to you.

### REST Endpoints

Use REST Endpoints to create Groovy scripts that define REST endpoints that allow you to integrate with external systems and exchange data. For example, you can define REST endpoints in ScriptRunner to:

-   Use in dashboard gadgets.
-   Receive information from external systems.
-   Plug gaps in the official REST API.
-   Allow all your XHRs to proxy through to other systems.

See the [REST Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) page for more details on this feature.

### UI Fragments

Use UI Fragments to customize the UI of your Jira instance. For example, you can use this feature to [create a custom link or button](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) or [show a custom banner](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) on your JIra instance. See the [Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments) page for more details on this feature and to find all of the UI Fragments available to you.

### Jobs

Use Jobs to automate the running of scripts at regular intervals—saving your administrators time, and reducing the risk of human error. For example, you can use this feature to [automate issue escalation](https://docs.adaptavist.com/sr4js/latest/features/jobs/built-in-jobs/escalation-services) or [create an issue once a month](https://docs.adaptavist.com/sr4js/latest/features/jobs/custom-jobs#create-an-issue-once-a-month--en). See the [Jobs](https://docs.adaptavist.com/sr4js/latest/features/jobs) page for more details on this feature and to find all of the Jobs available to you.

### JQL Functions

You can use ScriptRunner JQL functions to extend Jira's built-in capabilities, allowing you to conduct more granular searches, and obtain more detailed information about what is happening in your instance and projects. You can use ScriptRunner JQL functions anywhere you are able to use Jira JQL functions. These include:

-   As part of a JQL search in the Jira Issue Navigator (_Advanced_ and _Basic_ view)
-   In gadgets.
-   Within your own custom scripts.

Tip: ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#scriptrunner-jql-ai--en).

Note: If you uninstall ScriptRunner, any searches or filters using these ScriptRunner JQL functions will no longer work.

See the [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions) page for more details on this feature and to find all of the ScriptRunner JQL functions available to you.

### Resources

Use Resources to manage and add database connections for use within custom scripts. With the feature you can set up connections to both internal and external databases, which are stored by ScriptRunner in a connection pool. See the [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources) page for more details on this feature and to find all of the Resources available to you.

### Script Editor

Use Script Editor to manage your Groovy script files and folders. Reuse and share scripts across an instance without the need for FTP services or server administrators. With this feature you can create, edit, move, save, rename, and delete Groovy script files and folders in root folders from the ScriptRunner front-end. See the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) page for more details on this feature.

### Mail Handler

Use Mail Handler to expand on Jira's built-in feature. This feature and allows you to run Groovy scripts when a message is received. See the [Mail Handler](https://docs.adaptavist.com/sr4js/latest/features/mail-handler) page for more details on this feature and to find more examples of how to use this feature.

### Useful features to improve your scripting experience

We have developed the following features to make the scripting experience in ScriptRunner as seamless as possible.

#### HAPI

HAPI is an API (application programming interface) we have developed for doing common tasks in Jira, including managing issues, searching for issues, updating fields and much more! HAPI is a simple alternative to Jira's regular API and can be used in your Groovy scripts. See the [HAPI](../h/hapi.md) page for more details on this feature and to find examples of how to use HAPI.

#### Dynamic Forms

Use the Dynamic Forms feature to simplify the process of adding variables to your ScriptRunner Groovy scripts. With Dynamic Forms, you can annotate your variables in a script so they appear as selectable form fields. You can then save that script as a file to be shared with multiple users, allowing one script to be used for various use cases. See the [Dynamic Forms](../../best-practices/dynamic-forms.md) page for more details on this feature and to find examples of how to use Dynamic Forms.

### Related content

-   [Training](../t/training.md)
-   [Permissions](../../get-started/permissions.md)
-   [Introduction to HAPI](../h/hapi.md)
-   [Best practices](../b/best-practices.md)
