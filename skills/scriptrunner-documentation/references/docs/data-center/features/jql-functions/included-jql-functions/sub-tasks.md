# Sub-tasks

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-441364550
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks

This page provides information on various functions used to find issues with sub-tasks and parents:

## Find issues with sub-tasks (`hasSubtasks`)

Use hasSubtasks() to find issues with sub-tasks:

```
issueFunction in hasSubtasks()
```

## Find sub-tasks of issues specified by a subquery (`subtasksOf`)

Use `subtasksOf()` to find the sub-tasks of issues specified by the subquery:

```
issueFunction in subtasksOf("subquery")
```

You can leave the subquery as an empty string to find all subtasks of any issue:

```
issueFunction in subtasksOf("")
```

### subtasksOf() examples

Additional example

See an additional example on our Issue Links page for how to [Find all issues in an epic, and their subtasks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#additional-example-find-all-issues-in-an-epic-and-their-subtasks). 

We want to find all subtasks in project SSP that do not have a resolution:

```
issueFunction in subtasksOf("project = SSP") AND resolution is empty
```

We want to find all unresolved sub-tasks of resolved issues in project SSP:

```
issueFunction in subtasksOf("project = SSP AND resolution is not empty") AND resolution is empty
```

We want to find all sub-tasks of issues that are in the _To do_ status:

```
issueFunction in subtasksOf("status = 'To do'")
```

We want to find all sub-tasks that are _Open_, but their parent issue has a resolution of _Fixed_:

```
issueFunction in subtasksOf("resolution = Fixed") AND status = Open
```

## Find all parents of issues specified by a subquery (`parentsOf`)

Use `parentsOf()` to find the parents of issues specified by the subquery:

```
issueFunction in parentsOf("subquery")
```

### `parentsOf` examples

In this context, parent issues are any issues that have sub-tasks. This function does not cover _Epic-Story_ or _Epic-Task_ relationships.

We want to find any resolved parent issues in project SSP that still have open sub-tasks:

```
resolution is not empty AND issueFunction in parentsOf("project = SSP AND resolution is empty")
```

We want find all parent issues where the current user is the assignee of an open sub-task:

```
issueFunction in parentsOf("resolution is empty AND assignee = currentUser()")
```

We want to find all parent issues that have at least one sub-task In progress, in the SSP project:

```
issueFunction in parentsOf("project = JRA AND status = 'In progress'")
```

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
