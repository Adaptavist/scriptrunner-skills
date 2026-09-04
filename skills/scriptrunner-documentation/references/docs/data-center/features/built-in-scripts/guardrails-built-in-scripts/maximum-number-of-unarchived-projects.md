# Maximum Number of Unarchived Projects

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts > guardrails-built-in-scripts
- Doc ID: doc-sr4js-442887635
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-unarchived-projects

This built-in script is available for Data Center only.

Use this built-in script to find projects that have not been updated for a specified amount of time, and archive them. View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Projects) on the recommended maximum number of active projects. 

![Image of this built in script](/sr4js/files/latest/442887635/442887642/1/1758746868000/Max_unarchived_projects.png)

## Reporting

This built-in script returns all projects that have not been updated a specified amount of time. For example, you can choose to display projects that haven't been updated in 6 months, 1 year, 2 years, or a time length specified by you. 

You can also use the **Project filter** to archive the projects that fit the criteria of the script.

## Running this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts** **→ Guardrails: Maximum number of unarchived projects**.
2.  Select an option from the **Elapsed time since last update** drop-down list. 
3.  If you wish to filter projects, enter a script into the **Project filter** script console. You can select **Example scripts** to display examples that target projects, for example, though categories, names, or the project lead.
4.  Select **Preview** to display the projects that match the criteria you have specified.   
    ![Image of the results](/sr4js/files/latest/442887635/442887640/3/1737996683000/Guardrails_archive_projects.png) 
    
5.  Select **Archive X project(s)** to archive the chosen project(s). 

## Restoring archived projects

If you accidentally archived a project and wish to restore it, see how to [restore and re-index a project](https://confluence.atlassian.com/adminjiraserver/archiving-a-project-938847621.html?_ga=2.80998487.1773378735.1662365190-2029362582.1658496808&_gac=1.251470514.1661247955.EAIaIQobChMIrO_L8Nbc-QIV0OR3Ch0eUwuIEAAYASAAEgIqx_D_BwE#Archivingaproject-Restoringandre-indexingaproject) in the Atlassian documentation.

## Archiving tip

### Delete archived projects after a set amount of time

We recommend that you delete archived projects if they haven't been restored or asked about since X months/years after archiving. The amount of time depends on your company policy when it comes to such matters. This is a process you can set up automatically with ScriptRunner, or perform manually.
