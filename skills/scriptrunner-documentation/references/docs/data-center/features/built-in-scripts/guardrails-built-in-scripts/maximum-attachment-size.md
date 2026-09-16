# Maximum Attachment Size

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts > Guardrails Built-in Scripts
- Doc ID: doc-sr4js-c9c1c9f9-4a20-4a47-b60c-84e8fef80a92-3520af3074b4c95a
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#guardrails-built-in-scripts--en#maximum-attachment-size--en

Use this built-in script to find attachments over the specified size, and delete them.

View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Attachments) on the recommended size of attachments.

## Reporting

This built-in script returns all projects that are over the specified maximum attachment size limit. Atlassian recommends a maximum attachment size of 10.0 MB, but you can set a size of your choice.

You can also use the Attachment filter to search for attachments that fit the criteria of a script. For example, you can search for ISO images only, or you can search for attachments uploaded by named users. Select Example scripts to see scripts that you can use to filter attachments.

## Deleting Attachments

Warning: Attachments are permanently deleted. You cannot get them back without restoring from a backup.

If this built-in script finds attachments that exceed the recommended attachment size, you have the option to delete these attachments. You can use the Attachment filter, as described above, if you wish to further filter attachments by a set criteria.

## Running this built-in script

1.  From ScriptRunner, navigate to Built-in Scripts > Guardrails: Maximum attachment size.
2.  Enter a value under Max size of attachments, or leave at the default of _10 MB_.
3.  Select the project(s) you wish to search, or leave the Project field blank to search all projects.
4.  If you wish to further filter attachments, enter a script into the Attachment filter script console.
5.  Select Preview to display the number of attachments that fulfill the criteria you have set.
6.  Select Permanently delete X attachment(s) if you wish to delete the selected attachments.

Warning: Attachments are permanently deleted. You cannot get them back without restoring from a backup.

## Tips

### Want to delete all attachments that fulfill a filter?

If you wish to delete all attachments that fulfill the filter, regardless of whether they are over 10 MB in size, just reduce the size to zero.

### Test on your non-production instance first

Be sure to test first on a _copy_ of your production instance. Deleting is a destructive operation, there is no "undo" button.
