# Work with Work Items

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-322830810
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items

Here, we can demonstrate how HAPI simplifies creating and updating work items. This section also explains how to transition work items in Jira, including updating fields during transitions. Additionally, HAPI streamlines searching for work items, enabling you to run JQL queries with ease.

## Create work items

HAPI allows you to quickly and easily create work items and set parameters.

You can use the following code to create a work item:

```
WorkItems.create('ABC', 'Task') {
	setSummary('my first HAPI 😍')
}
```

![](/sr4jc/files/latest/322830810/524224188/1/1774347529000/my+first+hapi.png)

The script above sets only the four fields that are always required when creating a work item in Jira:

-   Space
-   Work type
-   Summary
-   Reporter (automatically defaults to the current user).

The above code will fail if other mandatory fields are set through the configuration scheme. Either set those fields or test on a space with the default configuration scheme.

### Populate additional fields when creating work items

When creating a work item, you have the option to populate additional fields to provide more detailed information. For a comprehensive list of available fields, refer to our [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html).

Here are a few examples of additional fields you might want to specify, along with the format to use when creating a work item:

```
WorkItems.create('JRA', 'Task') {
    setSummary('my first HAPI 😍')
    setPriority('High')
    setDescription("HAPI issue description")
    setLabels('Test1')
    setFixVersions("1.1")
    setCustomFieldValue('Story Points', 5)
}
```

After entering `set` you can use the keyboard shortcut **Control + Space** to show available completions.

### Create a subtask

To create a subtask, use `createSubTask` and specify the subtask work type. You can also add additional fields such as **Summary**, **Description**, and more to provide detailed information. For example:

```
WorkItems.getByKey('ABC-1').createSubTask('Sub-task') {
    setSummary('This is the summary')
    setDescription("This is the description")
}
```

The `createSubTask` method can actually create all kinds of child work items, depending on the level of the current work item. In an `Epic,` you can use it to create child work items such as stories, tasks, bugs, and so on.

## Update work items

In this example, we're updating the summary of a work item and setting the description.

You can update a work item as follows:

```
def workItem = WorkItems.getByKey('ABC-1')
             
workItem.update {
	setSummary('an updated summary')
	setDescription('hello *world*')
    setPriority('Medium')
}
```

The example below shows that you can update multiple fields at once: 

![](/sr4jc/files/latest/322830810/524224187/1/1774347622000/update+multiple+fields.png)

The `workItem` variable above is a standard `[com.adaptavist.hapi.cloud.jira.workitems.WorkItem](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/workitems/WorkItem.html)`. So you can update a work item like this anywhere you have a `[com.adaptavist.hapi.cloud.jira.workitems.WorkItem](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/workitems/WorkItem.html)` object.

Refer to the [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html) for a complete list of methods available for updating a work item.

Transition a work item

In Jira, [transitioning a work item](#id-.WorkwithWorkItemsvCurrent-transitionissues) allows you to move it from one workflow status to another, reflecting its current progress or state.

### Link and unlink a work item

Linking work items in Jira establishes a relationship between two work items, such as marking one work item as blocking another. This helps maintain traceability and visibility across related tasks.

Here’s an example of linking two work items:

```
workItem.link('blocks', WorkItems.getByKey('ABC-2'))
```

To unlink a work item, you can remove the existing link:

```
workItem.unlink('blocks', WorkItems.getByKey('ABC-2'))
```

This functionality makes it easier to manage dependencies and track work item relationships effectively.

## Transition work items

With HAPI, we've made it easy for you to transition work items and even [update fields](https://docs.adaptavist.com/sr4jc/latest/hapi/update-fields) while you transition work items. 

To transition a work item in Jira, you can use the following script in the script console:

```
def workItem = WorkItems.getByKey('ABC-1')
workItem.transition('In Progress')
```

Transitioning a work item moves it from one workflow status to another, reflecting its current state or progress. For instance, once the work on a work item is completed, you can transition it to the **Done** status.

Here’s another example of transitioning a work item using HAPI:

```
workItem.transition('Done')
```

### ![](/sr4jc/files/latest/322830810/524224185/1/1774347716000/transition+work+item.png)

### Update fields while transitioning work items

Watch our short demo video to understand how this works:

Your browser does not support the HTML5 video element

You can update fields, such as modifying the summary or adding comments, as part of the transition process. For example:

```
def workItem = WorkItems.getByKey('ABC-1')
workItem.transition('Done'){
	setSummary('Work item to be transitioned to done')
    setComment('Work item is completed')
	setPriority('Low')
}
```

![](/sr4jc/files/latest/322830810/524224183/1/1774347780000/transition+in+progress.png)

To update fields, such as the **Summary** or any other field, during a transition, ensure that these fields are included in the **Transition View Screen** for the corresponding workflow transition. Without this configuration, the fields cannot be updated as part of the transition process.

This setup allows transitioning a work item to not only update its status but also capture additional relevant context, enhancing clarity and record-keeping.

For a full list of methods and available transitions, refer to the [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html). 

## Search for work items

With HAPI, we've made it easy for you to search for work items. 

### Run JQL queries to search for work items

You can easily run JQL queries. 

In this example, we're running a query that returns all work items of work type 'Bug' in the 'JRA' space. 

Where the example says "do something with each work item" you can, for example, [update](#id-.WorkwithWorkItemsvCurrent-updateissues) all returned work items using the `[workItem.update](#)` method.

```
WorkItems.search("project = 'JRA' AND issuetype = 'Bug'").each { workItem ->
    // do something with `workItem`
}
```

  

`WorkItems.search` returns an `Iterator`. This is designed for you to iterate through the results instead of retaining many work items in memory.

### Update all returned work items

As previously mentioned, you can [update](#id-.WorkwithWorkItemsvCurrent-updateissues) all returned work items using the `[workItem.update](#)` method. This is particularly useful if you want to **bulk update** work items. 

In this example, we're running a query to return all medium priority stories in the space 'KAN'. At the same time, we're adding a comment to all returned work items, setting the priority to 'High', and printing a line of log.

```
WorkItems.search("project = 'KAN' AND issuetype = 'Story' AND priority = 'Medium").each { workItem ->
	workItem.update {
		setComment('This task needs looking at')
		setPriority('High')
    }
	logger.warn('Updated ' + workItem.key)
}
```

![](/sr4jc/files/latest/322830810/524224181/1/1774347878000/update+all+returned+work+items.png)

### JQL queries and memory

We recommend that you do **NOT** execute queries using an unlimited `PagerFilter`. The returned work items are temporarily stored in memory if you execute a query without paging.

With HAPI, the retrieval of work items ensures that memory usage is constant and that you don't cause an `OutOfMemoryException`.

### Limit list size for JQL queries

If you require a `List` of work items, limit the size, as shown below.

```
WorkItems.search("project = 'KAN' AND issuetype = 'Story' AND priority = 'High'").take(10).toList()
```

In terms of memory usage, having one thousand work items in a `List` is acceptable, tens of thousands might be feasible, but handling millions is not advisable.

If you need a count of work items, use `count`. This provides better performance than executing a query and iterating through them all just to count them:

```
WorkItems.count('project = JRA')
```

### Advanced HAPI JQL usage

You may want to filter the list of work items further because you want a condition that you cannot express in JQL.

In this example, we're filtering work items assigned to James Smith only. This is just for demonstration purposes: it is easier to express this in JQL.

```
WorkItems.search('project = KAN').findAll { workItem -> 
	workItem.assignee?.name == 'James Smith'
}.each { workItem ->
	// perform operations on work item
    logger.info("${workItem.key} assigned to ${workItem.assignee?.displayName}")
}
```

### Limiting the number of work items searched

Groovy Development Kit methods such as `findAll` collect as many work items as they can, which isn't ideal. If you have a very large instance for tasks such as the one above or advanced data processing pipelines, you can use the Java **Streams** API. The `stream()` method is available on the search results for convenience.

In this example, we're filtering work items assigned to James Smith only and limiting the results to 5.

```
import java.util.stream.Collectors
            
WorkItems.search('project = JRA')
    .stream()
    .filter { workItem -> workItem.assignee?.displayName == 'James Smith' }
    .limit(5)
    .collect(Collectors.toList())
```

  

* * *

## Related content

-   [Javadocs \[Groovy\] Class AbstractIssuesDelegate](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/issues/delegates/AbstractIssuesDelegate.html)
-   [Javadocs (Issues)](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/issues/Issues.html)
