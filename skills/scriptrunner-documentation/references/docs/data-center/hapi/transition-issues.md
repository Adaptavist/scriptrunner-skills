# Transition Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-74402a33-691f-4fb1-9c4f-0662a62da325-7c51ec41f496ae75
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#transition-issues--en

Transition issues using HAPI, with examples for updating fields and skipping permissions while you transition issues.

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items#transition-work-items--en) |

## Transitioning issues

To transition an issue, run the following script from the script console:

Note: In this example we're starting progress on an issue.

```
def issue = Issues.getByKey('ABC-1')
 
	issue.transition('Start Progress')
```

## Updating fields while transitioning issues

You can also update fields during a transition. For example:

Note: In this example we're resolving an issue, setting the resolution, and adding a comment.

```
def issue = Issues.getByKey('ABC-1')
 
issue.transition('Resolve Issue') {
	setResolution('Done')
	setComment('resolving this issue')            
}
```

Note: See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/7.11.0/hapi/jira/groovydoc/index.html) for a full list of fields.

## Skipping conditions, validators, and permissions while transitioning issues

You can use `transitionOptions` to skip conditions, validators and permissions during a transition. For example:

```
def issue = Issues.getByKey('ABC-1')
 
issue.transition('To Do') {
    transitionOptions {
        skipConditions()
        skipPermissions()
        skipValidators()
    }
}
```

## Known limitation when transitioning from a post-function

Due to a limitation, we recommend against calling `issue.transition()` on the current issue inside a custom script post-function. When this is done, the transition is recorded in the issue's activity history, but the issue's current status may not update correctly.

## Workaround

Use a Custom Listener instead. If the listener updates system fields (such as Assignee or Summary) of the issue being transitioned, those changes are overwritten when the transition finishes, unless you also set them on `event.issue`. For more information, see [Listeners and issue transitions](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener#listeners-and-issue-transitions--en).

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/IssueTransitionDelegate.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
