# Clean Workflows

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-32bc89a6-02be-4529-887a-1acdcfeedb33-747a518668390173
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#clean-workflows--en

Use the _Clean Workflows_ built-in script to clean up your instance by removing workflow functions left behind by uninstalled/disabled apps.

The Preview action for this built-in script scans all or selected workflows and returns a table of workflow functions that were created with currently disabled or uninstalled apps. The table displays the _Workflow Name_, _Workflow Status_ (Active, Inactive, Draft), _Function Class Name,_ and a _Function Link_ that takes you to the workflow transition where the function exists.

The Run action for this built-in script will remove all _workflow functions_ created with currently disabled or uninstalled apps from either all workflows, or the workflows selected from the _workflows_ selection drop-down.

## Using this built-in script

Warning: Before you run this, back up your workflows by [exporting](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/#Importingandexportingissueworkflows-Exportacompany-managedworkflowtoaserverinstance) them. There is no way to recover deleted functions after running this built-in script.

1.  From ScriptRunner, navigate to Built-in Scripts > Clean Workflows.
2.  Choose Global (All Workflows) to preview/run for all workflows.
    
    Or choose the Select workflow(s) option and specify the workflows you want the script to run on.
    
3.  Select Preview to see a table listing all workflow functions created with currently disabled or uninstalled apps.
    
    These are the workflow functions that will be removed when the script is run. Check this list thoroughly before moving to the next step.
    
    Tip: Always use Preview before you run this script to validate the functions that will be removed.
    
4.  Select Run when you are certain you want to delete the disabled or uninstalled apps workflow functions.
    
    When the script finishes a report displays details of the workflows that have been updated.
    
    Note: If the workflow is in Draft mode when you run the _Clean Workflows_ built-in script, it will remove the functions from the draft and the changes will not be published unless the user editing the draft publishes the workflow.
    

### Preview examples

Preview example for Global(All Workflows):

Preview example for a single selected workflow:
