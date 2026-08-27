# Automatic Imports and Extension Methods

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-306811124
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/automatic-imports-and-extension-methods

This page provides technical information on automatic imports and extension methods.

## Automatic imports

For convenience, HAPI classes such as `WorkItems`, `Users`, and `Spaces` are automatically imported into all scripts compiled within ScriptRunner, so an explicit import is not required.

If you import another class called `WorkItems` it results in a conflict. To avoid conflicts, HAPI classes won't automatically import if there is an existing import for a class with the same name in a script.

For cases where you have a script that contains a conflicting import, you can access HAPI via the `Hapi` automatic import. This automatic import is unlikely to conflict with other classes. For example:

```
Hapi.workItems.create('ABC', 'Task') {
    summary = 'Hello world'
}
```

## Extension methods

Extension methods are methods that ScriptRunner adds to classes that are not part of its own API, for instance, the Atlassian Jira API. In the following example, `delete()` is an extension method that is added by ScriptRunner.

```
def workItem = WorkItems.getByKey('ABC-1')

workItem.delete()
```

Other examples of extension methods include workItem`.update()`, `user.delete()` and `group.add()`. 

* * *

## Related content

-   Our [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html?overview-summary.html) provide details of all available extension methods.
