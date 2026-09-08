# Maximum Change History Records Per Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts > guardrails-built-in-scripts
- Doc ID: doc-sr4js-442887685
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-change-history-records-per-issue

Use this built-in script to find issues with change items that exceed the recommended amount, and delete the oldest. Change groups left empty through the deletion of change items are also deleted. View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Changehistory) on the recommended number of change items and change groups. An issue is automatically re-indexed if any of its change items or groups are deleted. 

![Image of the change history built in script](/sr4js/files/latest/442887685/442887689/3/1737998064000/Guardrails_change_history.png)

## Reporting

This built-in script returns all issues that contain change items over the specified maximum limit. Atlassian recommends a maximum of 20,000 change items or change groups, but you can set your own maximum value. For every change item, or set of change items, there is also a change group. We have set a default number of 10,000 change items which takes into account change groups. Change groups left empty through the deletion of change items are also deleted.

You can use the **Change item filter** to search for change items that fit the criteria of a script. For example, you can search for changes made by named users, or you can search for changes to a priority field. Select **Example scripts** to see scripts that you can use to filter change items.

## Deleting change items and change groups

Change items and groups are permanently deleted. You cannot retrieve deleted change items and groups without restoring from a backup. 

If this built-in script finds issues with a change item amount that exceeds the threshold, you are provided with the option to delete the oldest. You can use the **Change item** **filter**, as described above, if you wish to further filter issues or change items by a set criteria.

![Delete change items screenshot](/sr4js/files/latest/442887685/442887687/3/1737998065000/guardrails_change_history_delete.png)

## Running this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts** **→ Guardrails: Maximum change history records per issue**.
2.  Enter a value under **Max number of change items**, or leave at the default of _10000_.
3.  Select the project(s) you wish to search, or leave the **Project** field blank to search all projects.
4.  Enter a script into the **Change item filter** script console, if you wish to further filter change items.
5.  Select **Preview** to display the number of issues that fulfill the criteria you have set.
6.  Select **Permanently delete X change item(s)** if you wish to delete the selected change item(s). Change groups left empty through the deletion of change items are also deleted.
    
    Change items and groups are permanently deleted. You cannot retrieve deleted change items and groups without restoring from a backup. 
    
    Issues are automatically re-indexed if any of its change items or groups are deleted. 
    

## Tips

### Test on your non-production instance first

Be sure to test on a _copy_ of your production instance first. This is a destructive operation, there is no "undo" button.

### Want to delete all change items that fulfil a filter?

If you wish to delete all change items that fulfil the filter, regardless of whether they are over the threshold, just reduce the threshold number to zero.

### Revisit this cleanup activity

You may wish to revisit this cleanup activity, for example on a quarterly basis.
