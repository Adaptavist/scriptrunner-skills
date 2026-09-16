# Bulk Copy SLAs

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-b0197f2e-8fdf-400a-a5ba-7474789f5daf-1fa80dd50d3a35d6
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#bulk-copy-slas--en

Use the _Bulk Copy SLA Configuration_ built-in script to copy the Service Level Agreement (SLA) configuration from one Service Management project to one or more additional Service Management projects on the same Jira Service Management instance.

Warning: The SLA configuration of the target project(s) is overwritten by the configuration copied from the source project.

## Using this built-in script

1.  From ScriptRunner, navigate to Built-in Scripts > Bulk Copy SLA Configuration.
2.  Select a Source Project from the drop-down list.
    
    This list shows all Service Management projects on the active Jira instance.
    
3.  Enter the Destination Project/s to which you want the SLA configuration of the source project to be copied.
    
    Multiple projects can be added here.
    
4.  Check/uncheck the Delete SLA checkbox.
    
    This option allows you to delete SLA in the target projects that do not exist in the source project.
    
5.  Select Preview to see an overview of changes.
    
    Warning: If there is a mismatch of issue types between the source project and target project(s), irrelevant information is copied to the destination SLA configuration. Click Preview to display a list warnings when mismatches occur. Mismatches do not cause errors, however we recommend that you ensure the source and target projects contain the same issue types.
    
6.  Select Run to accept all changes and run the script.
