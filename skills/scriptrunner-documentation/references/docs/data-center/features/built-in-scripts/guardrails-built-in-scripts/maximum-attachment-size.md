# Maximum Attachment Size

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts > guardrails-built-in-scripts
- Doc ID: doc-sr4js-442887644
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-attachment-size

Use this built-in script to find attachments over the specified size, and delete them. View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Attachments) on the recommended size of attachments. 

![Image of the maximum attachment size built in script](/sr4js/files/latest/442887644/442887651/1/1758746870000/Max_attachment_size.png)

## Reporting

This built-in script returns all projects that are over the specified maximum attachment size limit. Atlassian recommends a maximum attachment size of 10.0 MB, but you can set a size of your choice. 

You can also use the **Attachment filter** to search for attachments that fit the criteria of a script. For example, you can search for ISO images only, or you can search for attachments uploaded by named users. Select **Example scripts** to see scripts that you can use to filter attachments.

## Deleting Attachments

Attachments are permanently deleted. You cannot get them back without restoring from a backup. 

If this built-in script finds attachments that exceed the recommended attachment size, you have the option to delete these attachments. You can use the **Attachment filter**, as described above, if you wish to further filter attachments by a set criteria.

![Image of the results](/sr4js/files/latest/442887644/442887647/3/1737997512000/Guardrails_delete_attechments.png)

## Running this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts** **→ Guardrails: Maximum attachment size**.
2.  Enter a value under **Max size of attachments**, or leave at the default of _10 MB_.
3.  Select the project(s) you wish to search, or leave the **Project** field blank to search all projects.
4.  If you wish to further filter attachments, enter a script into the **Attachment filter** script console.
5.  Select **Preview** to display the number of attachments that fulfill the criteria you have set.
6.  Select **Permanently delete X attachment(s)** if you wish to delete the selected attachments.
    
    Attachments are permanently deleted. You cannot get them back without restoring from a backup. 
    

## Tips 

### Want to delete all attachments that fulfill a filter?

If you wish to delete all attachments that fulfill the filter, regardless of whether they are over 10 MB in size, just reduce the size to zero.

### Test on your non-production instance first

Be sure to test first on a copy of your production instance. Deleting attachments is a destructive operation, there is no "undo" button.
