# Work with Watchers

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888633
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-watchers

With HAPI, we've made it easy for you to work with watchers. 

## Add a watcher to an issue

Add a watcher to an issue as follows:

```
Issues.getByKey('SR-10').addWatcher('jdoe')
```

![Image showing you how to add a watcher to an issue with HAPI](/sr4js/files/latest/442888633/442888638/1/1758746957000/Watchers_create_watcher_2.png)

## Remove a watcher from an issue

Remove a watcher from an issue as follows:

```
Issues.getByKey('SR-10').removeWatcher('jdoe')
```

## Retrieve the watchers from an issue

Retrieve watchers from an issue as follows:

```
Issues.getByKey('SR-10').watchers
```

**Video**

Your browser does not support the HTML5 video element

## Security

By default all watcher operations respect the permissions of the current logged in user. You may want to ignore permission checks with the `overrideSecurity` property:

In this example we're using the `overrideSecurity` property to ignore permission checks when adding a watcher to an issue.

```
Issues.getByKey('SR-10').addWatcherOverrideSecurity('jdoe')
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/implementation/IssuesImplementation.html)
-   [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)
-   [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)
