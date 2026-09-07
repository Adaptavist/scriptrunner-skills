# Maximum Number of Issue Links Per Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts > guardrails-built-in-scripts
- Doc ID: doc-sr4js-442887665
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-issue-links-per-issue

Use this built-in script to find issues that contain more issue links than the recommended amount, and archive or delete the oldest. View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Issuelinks) on the recommended number of issue links. 

![Image of this built in script](/sr4js/files/latest/442887665/442887671/1/1758746871000/max_issue_link_per_issue.png)

## Reporting

This built-in script returns all issues that are over the specified maximum number of issue links. Atlassian recommends a maximum of 1,000 issue links per issue, but you can set your own maximum value.

You can use the **Link type(s)** filter to search for specific issue links only. You can also use the **Issue link filter** to search for issues or issue links that fit the criteria of a script. For example, you can search for issues that have a named issue as a destination link, or you can search for issues that have a named issue as a source link. Select **Example scripts** to see scripts that you can use to filter issues.

## Deleting issue links

Issue links are permanently deleted. You cannot retrieve deleted issue links without restoring from a backup. 

If this built-in script finds issues with issue links that exceed the selected amount, you have the option to delete the oldest issue links. You can use the **Link type(s)** filter and **Issue link filter**, as described above, if you wish to further filter issues or issue links by a set criteria.

![Delete issue links screenshot](/sr4js/files/latest/442887665/442887667/3/1737997639000/Guardrails_delete_issue_links.png)

## Running this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts** **→ Guardrails: Maximum issue links per issue**.
2.  Enter a value under **Max issue links**, or leave at the default of 1,000 issue links.
3.  Select the project(s) you wish to search, or leave the **Project(s)** field blank to search all projects.
4.  Select the type of link you wish to search, or leave the **Link type(s)** field blank to search all link types.
5.  Under **Execution type**, select one of the following options:
    
    Archiving is available for Data Center only.
    
    -   **Archive issues**. Select this option if you want to archive issues that match your search parameters.
    -   **Delete issue links**. Select this option if you want to delete the oldest issue links of issues that match your search parameters.
6.  Enter a script into the **Issue link filter** script console, if you wish to further filter issues. 
7.  Select **Preview** to display the number of issues that match your search parameters. 
8.  Perform one of the following options:
    -   Select **Archive X issue(s)** if you wish to archive the selected issues.  
        ![Archive issues screenshot](/sr4js/files/latest/442887665/442887669/3/1737997639000/Guardrails_archive_issues.png) 
    -   Select **Permanently delete X issue link(s)** if you wish to delete the oldest issue links of the selected issues.
        
        Issue links are permanently deleted. You cannot retrieve deleted issue links without restoring from a backup. 
        

## Restoring archived issues

If you have archived an issue and wish to restore it, see how to [restore an issue](https://confluence.atlassian.com/servicedeskserver048/archiving-an-issue-1005788646.html#Archivinganissue-Restoringanissue) in the Atlassian documentation.

## Tips

### Test on your non-production instance first

Be sure to test first on a _copy_ of your production instance. Deleting is a destructive operation, there is no "undo" button.

### Delete archived issues after a set amount of time

We recommend that you delete archived issues if they haven't been restored or asked about since X months/years after archiving. The amount of time depends on your company policy when it comes to such matters.
