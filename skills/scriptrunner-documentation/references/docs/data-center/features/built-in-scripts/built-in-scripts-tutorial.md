# Built-In Scripts Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442887610
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/built-in-scripts-tutorial

As an administrator, you likely handle lots of tasks in your Jira instance. Many of these tasks can be a bit tedious. And like most of us, you want to make your life easier and handle more tasks automatically- that’s where ScriptRunner built-in scripts come in. While ScriptRunner provides extended functionality in many different ways, its built-in scripts offer several options to automate or simplify different processes in Jira. Also, built-in scripts, as their name indicates, are built into ScriptRunner, so you don’t need to work with Groovy to get them running.

Built-in scripts for the global Jira instance are part of the ScriptRunner functionality in the administration section of Jira. You access these global built-in scripts from the _Built-in Scripts_ page (**Administration > ScriptRunner > Built-In Scripts**).

![Image of the built-in scripts page](/sr4js/files/latest/442887610/442887616/1/1758746864000/Built_in_scripts.png)

## About built-in scripts

A ScriptRunner built-in script is a type of automated functionality that allows a Jira administrator to handle something quickly and automatically that would have been a manual process. These particular built-in scripts, found at the global level of ScriptRunner, help a Jira administrator handle tasks that would affect many projects or the whole Jira instance. For example, you can use the _Bulk Import Custom Field Values_ built-in script to import several custom fields values or use the _List Scheduled Jobs_ built-in script to see a list of all scheduled jobs for a Jira instance. There are other built-in scripts available as part of ScriptRunner functionality, specifically in workflow functions, but those are not accessible at the global administration level.

For each built-in script, you may need to update menu selections, or you may just need to run the script. In this example for the _Bulk Fix Resolutions_ script, you do need to update a couple of menus to bulk change resolutions from one resolution status to another.

![Image of the bulk fix resolutions built in script](/sr4js/files/latest/442887610/442887617/1/1758746864000/Bulk_fix_resolutions.png)

### Why use a built-in script?

Built-in scripts allow you to automate actions that would otherwise be manual as well as provide you with quick information on some parts of your Jira instance. Because these scripts are built-in, they are an excellent way for Jira administrators without groovy knowledge to access functions through the user interface of Jira. There are also built-in scripts that extend some of the bulk edit functionality that you find in Jira, allowing you to quickly handle tasks such as changing a set of resolutions fields automatically saving you time and effort that you can put into other tasks.

Some other cool functionality available as built-in scripts include reviewing your script registry, viewing your server log files, and listing your scheduled jobs. While these built-in scripts don’t complete any actions, they allow you to review information about your system easily. For example, you can use _Script Registry_ to view all Groovy scripts used across your Jira instance. So, if you need to audit your ScriptRunner use and see where both built-in scripts and custom Groovy scripts are used, you can do that with this built-in script. This built-in script provides a list of results broken into multiple tabs, with numbers indicating how many scripts are in use. This particular script could be useful if you want to quickly view where different ScriptRunner scripts are in action, as well as potentially identify problems in custom scripts.

![Image of the script registry](/sr4js/files/latest/442887610/442887618/1/1758746864000/Script_registry_example.png)

## Available built-in scripts

We have developed a number of built-in scripts for you to use in your instance:

-   [Bulk Copy SLAs](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-copy-slas)
-   [Bulk Fix Resolutions](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-fix-resolutions)
-   [Bulk Import Custom Field Values](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-import-custom-field-values)
-   [Change Dashboard, Filter, or Board Ownership](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/change-dashboard-filter-or-board-ownership)
-   [Clean Workflows](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clean-workflows)
-   [Clear Groovy Class Loader](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clear-groovy-class-loader)
-   [Configuration Exporter](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/configuration-exporter)
-   [Copy Field Values](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values)
-   [Copy Project](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-project)
-   [Generate Events](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/generate-events)
-   [Guardrails Built-in Scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts)
-   [List Scheduled Jobs](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/list-scheduled-jobs)
-   [Re-index Issues](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/re-index-issues)
-   [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry)
-   [Split Custom Field Context](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/split-custom-field-context)
-   [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user)
-   [Template Comments (Service Management)](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/template-comments-service-management)
-   [View Server Log Files](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/view-server-log-files)

These built-in scripts are a mix of scripts that need you to enter some information, like a filter ID or a project key, and scripts that you can just run and see the output.

## Built-in script examples

### Bulk fix resolutions

Let’s check out the _Bulk Fix Resolutions_ script to get an idea of how built-in scripts work.

At Great Adventure, the server team imported a project from their test instance, and their resolution status, _Upgraded_, didn’t carry over, so they need to change all _Done_ statuses to _Upgraded_. This is causing problems for the project manager; her reports are incomplete. She could fix it manually, but that would take far too much time. You can easily run the _Bulk Fix Resolutions_ script to correct the errors. This script will take the issues in a filter and alter their resolutions all at once.

1.  From **ScriptRunner**, go to **Built-in Scripts**.
    
2.  Select **Bulk Fix Resolutions**.
    
3.  Set the filter as appropriate, and choose the proper resolution. In the following image, the **Filter ID** field has a filter created to find all the issues that have been resolved incorrectly, and the **New Resolution** field is set as `Upgraded`.
    
    ![Image of the configured built in script](/sr4js/files/latest/442887610/442887619/1/1758746864000/Bulk_fix_resolution_example.png)
4.  Select the **Send mail** checkbox if you want to send an email of this change.
5.  Select **Run**, and the results appear. This function can be extremely useful for a quick fix to multiple issues that have the incorrect resolution. If you wanted to ensure that this action was carried out on a regular basis, you could use the _Escalation Service_ built-in script, which we’ll look at next.
    

### View Server Log Files

Great Adventure has security policies in place to ensure that their server maintenance and Jira front-end administration are done by different individuals. This policy means that when the Jira admin is trying to troubleshoot, they need to contact the server administrator and request the logs. This means that the logs may be unavailable when needed in the moment. With ScriptRunner, you can use the _View Server Log Files_ built-in script to view a number of lines in the -Jira.log files.

1.  From **ScriptRunner**, go to **Built-in Scripts**.
2.  Select **View Server Log Files**.
    
3.  Set the _Log File_ and _Number of Lines_ fields as desired and select **Run**.
    
4.  Once you run the built-in script, you can observe the logs.
    

  

* * *

## Related content

-   [Built-In Scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts)
-   [Guardrails](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts)
-   [Escalation Services](https://docs.adaptavist.com/sr4js/latest/features/jobs/built-in-jobs/escalation-services)
