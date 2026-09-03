# Sprint

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-441364112
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint

## addedAfterSprintStart

Show issues that were added to the named board after the named sprint started (or all active sprints if a second argument is not provided). 

```
addedAfterSprintStart(board name/ID, [sprint name/ID])
```

This query is available from the planning board by default. Click the **Added after Sprint Start** icon next to the sprint name in the _Backlog_ screen to run the query for that sprint.   
![](/sr4js/files/latest/441364112/441364117/1/1732189792000/image2021-6-9_11-1-47.png)

These icons and functionality are provided byScriptRunner and not Jira, so if you have any problems or suggestions, please reach out to our [Support team](https://productsupport.adaptavist.com/servicedesk/customer/portal/2?_ga=2.205790550.451163597.1623660519-1583911499.1621942551). 

**Example**

As a project manager, I want to find all issues on the _Development Scrum_ board that were added after the start of the current sprint (Sprint 25) so I can keep track of the sprint and see how the scope has changed. I can then drill down on issues that were added after the scope was agreed, both in the planning and work boards.

```
addedAfterSprintStart("Development Scrum", "Sprint 25")
```

I project manage two teams and have combined issues from both projects onto one board so I can see an overview. I want to see a list of all issues on my combined _Product Overview_ board that were added after the start of all active sprints.

```
addedAfterSprintStart("Product Overview")
```

## removedAfterSprintStart

Show issues that were removed from the named board after the named sprint started (or all active sprints if second argument is not provided).

```
removedAfterSprintStart (board name/ID, [sprint name/ID])
```

  

**Example**

As a project manager, I want to find all issues on the _Development Scrum_ board that were removed after the start of the current sprint (Sprint 25) so I can keep track of the sprint and see how the scope has changed. 

```
removedAfterSprintStart("Development Scrum", "Sprint 25")
```

I project manage two teams and have combined issues from both projects onto one board so I can see an overview. I want to see a list of all issues on my combined _Product Overview_ board that were removed after the start of all active sprints.

```
removedAfterSprintStart("Product Overview")
```

## incompleteInSprint

Show incomplete issues in the named sprint (or all active sprints if a second argument is not provided). 

```
incompleteInSprint(board name/ID, [sprint name/ID])
```

You can use plain JQL to show incomplete issues in any given sprint:

```
sprint = [sprint name] and resolution is empty
```

However, the incompleteInSprint function allows you to see incomplete issues in all currently active sprints on a given board.

**Example**

As a project manager, I want to find all incomplete issues on the _Development Scrum_ board in the current sprint (Sprint 25) so I can get an overview of how much work is left in the sprint. I can then check the status of incomplete issues and ensure there are no blockers.

```
incompleteInSprint("Development Scrum", "Sprint 25")
```

I project manage two teams and have combined issues from both projects onto one board so I can see an overview. I want to see a list of all incomplete issues on my combined _Product Overview_ board for all active sprints.

```
incompleteInSprint("Product Overview")
```

## completeInSprint

Show complete issues in the named sprint (or all active sprints if a second argument is not provided).

```
completeInSprint(board name/ID, [sprint name/ID])
```

**Example**

As a technical writer, I want to see a list of all completed issues on the _Development Scrum_ board in the current sprint (Sprint 25) so I can ensure all corresponding documentation updates have been made.

```
completeInSprint("Development Scrum", "Sprint 25")
```

## nextSprint

Show issues that are assigned to the upcoming sprint on the specified board. 

```
nextSprint(board name/ID)
```

This only shows issues on the next sprint that has not yet started. 

**Example**

As a project manager, I want to see all issues assigned to the _Development Scrum_ board for the upcoming sprint so I can see the build-up of the next sprint and the work involved.

```
nextSprint("Development Scrum")
```

## previousSprint

Show issues that were assigned to the last completed sprint.

```
previousSprint(board name/ID)
```

**Example**

As a project manager, I want to see all issues assigned to the _Development Scrum_ board for the last completed sprint. 

```
previousSprint("Development Scrum")
```

## inSprint

`inSprint` was made redundant in Jira 6.3. We recommend you use `[completeInSprint](#id-.Sprintv9.x-completeInSprint)` or [i`ncompleteInSprint`](#id-.Sprintv9.x-incompleteInSprint) if you still wish to search for what is in a board.

Show issues that are assigned to the named sprint. 

```
inSprint(board name/ID or sprint name/ID)
```

This query returns all issues, including sub-tasks, whereas by default, these are not shown in the planning mode on the board. To return parent tasks only, add: `and issuetype in standardIssueTypes()`.

To see issues in the same order don’t forget to **Order by Rank** otherwise the ordering is unlikely to be the same as shown in the board.

This query is available from the planning board by default. Click the **View in Issue Navigator** icon next to the sprint name in the _Backlog_ screen to run the query for that sprint. 

![](/sr4js/files/latest/441364112/441364115/1/1732189792000/image2021-6-10_14-21-19.png)

These icons and functionality are provided byScriptRunner and not Jira, so if you have any problems or suggestions, please reach out to our [Support team](https://productsupport.adaptavist.com/servicedesk/customer/portal/2?_ga=2.205790550.451163597.1623660519-1583911499.1621942551). 

The function does not take into account any quick filters applied, or the epic links etc.

If you don’t want this functionality (i.e. the links added to the planning board), disable the module named _Resource to add View in Navigator to sprints on the rapid board_ in the ScriptRunner plugin.
