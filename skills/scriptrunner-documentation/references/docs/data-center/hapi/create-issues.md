# Create Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-db2f3459-96b7-4f20-ba0e-9e782c6fbfbc-5f5399301e0c181f
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#create-issues--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items) |

With HAPI you can quickly and easily create issues and set parameters.

## Creating issues

You can use the following code to create an issue:

Note: You can also create issues using the issue type ID. For example, instead of `'Task'` you might use the ID `10101`.

Please note, the ID for the _Task_ issue type might differ in your instance. See the Atlassian documentation for [Finding the ID for Issue Types](https://confluence.atlassian.com/jirakb/finding-the-id-for-issue-types-646186508.html).

```
Issues.create('ABC', 'Task') {
	setSummary('my first HAPI 😍')
}
```

The script above only sets the four fields that are always required when creating an issue in Jira:

-   The project
-   Issue type
-   Summary
-   Reporter (taken from the current user).

Warning: The above code will fail if other mandatory fields are set through the configuration scheme. Either set them or test on a project with the default configuration scheme.

## Fill out more fields when creating issues

You can fill out more fields when you create an issue. See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/7.11.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/AbstractIssuesDelegate.html) for a full list of fields.

To fill out more fields, enter the following:

Note: After you enter `set` you can use the keyboard shortcut of control + space to show available completions.

```
Issues.create('ABC', 'Task') {
	setSummary('my issue created with HAPI ')
	set...
}
```

## Creating a subtask

To create a subtask, use `createSubTask` and specify the subtask issue type. For example:

```
def issue = Issues.getByKey('ABC-1')

issue.createSubTask('Sub-task') {
	setSummary('This is the summary')
}
```

## Related content

-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
-   [Javadocs link (AbstractIssuesDelegate)](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/AbstractIssuesDelegate.html)
-   [Javadocs link (Issues)](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/Issues.html)
