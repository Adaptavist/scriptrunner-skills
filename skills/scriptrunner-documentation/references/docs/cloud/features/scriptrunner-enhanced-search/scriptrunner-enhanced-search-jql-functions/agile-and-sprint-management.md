# Agile and Sprint Management

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-functions
- Doc ID: doc-sr4jc-313196618
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management

These ScriptRunner Enhanced Search JQL functions are particularly useful for Scrum Masters and Team Leads as they focus on agile methodologies. They enable sprint progress tracking, planning of future sprints, and management of sprint backlogs.

The `board` parameter in the functions below may be either the name of the board, or the board ID. You can find the board ID in the page URL when viewing the board e.g. [https://example.atlassian.net/secure/RapidBoard.jspa?rapidView=24&projectKey=EXAMPLE](https://example.atlassian.net/secure/RapidBoard.jspa?rapidView=24&projectKey=EXAMPLE) shows the board ID to be 24.

## Differences with ScriptRunner for Jira Server agile functions

You can read about the differences between ScriptRunner for Jira Server, and Jira Cloud advanced JQL functions in the side-by-side comparison [here](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#id-.ComparisonwithScriptRunnerforJiraServervCurrent-JQLQueryComparison). There is also a [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) table, which outlines feature differences that include JQL functions.

The following agile functions are available on ScriptRunner for Jira Server but are not available on ScriptRunner for Jira Cloud:

-   removedAfterSprintStart
    
-   incompleteInSprint
    
-   completeInSprint
    

## addedAfterSprintStart

The `addedAfterSprintStart` function identifies issues added after the sprint has already commenced. This function is crucial for agile teams to monitor and adapt to changes in their sprint commitments, offering benefits such as:

-   Enabling real-time tracking of scope creep or modifications within an active sprint, which is essential for maintaining sprint goals and expectations.
    
-   Providing insights into team adaptability and the dynamics of sprint planning, which can inform future sprint planning sessions and retrospective analyses.
    
-   Assisting in maintaining transparency and communication within teams by clearly delineating changes that occur during the sprint.
    

This function also considers issues added to the sprint after the sprint start date, even if those issues were initially part of the sprint before it began.

Known Issue: addedAfterSprintStart

**Issue Description:** It is possible that the `addedAfterSprintStart` function may return inaccurate results when sprints are reopened. 

Jira has a known limitation where, if a sprint is closed and then reopened, new changelog entries are created for all issues in the sprint using timestamps from the reopening event. Because the system relies on the latest changelog entry to determine when an issue was added to a sprint, this can affect the accuracy of tracking issue additions. While future improvements may be considered, there is currently no immediate fix due to the risk of impacting other scenarios.

**Workaround:** It is recommended to use explicit date-based queries together with the `addedAfterSprintStart` function to help address this Jira limitation.

### Syntax and parameters

```
addedAfterSprintStart(Board, [Sprint])
```

-   **Board:** The name or ID of the agile board.
    
-   **Sprint (Optional):** The specific sprint to query. This can be the sprint name or ID. If using an ID, it should not be enclosed in quotes. If omitted, the function defaults to the current active sprint, unless there are multiple active sprints, in which case it is required to specify a particular sprint.
    

### **Examples:**

1.  **Tracking scope changes in an active sprint:**
    
    For teams wanting to monitor what new issues have been added since the start of "Sprint 3" on the "EX Scrum Board":
    
    ```
issueFunction in addedAfterSprintStart("EX Scrum Board", "Sprint 3")
```
    
    This query helps the team stay aware of any new commitments or changes in their current workload, allowing for more informed daily stand-ups and planning meetings.
    
2.  **Using Sprint ID to Specify the Sprint:**
    
    To specify a sprint by its ID for a more direct query without the need for quotes:
    
    ```
issueFunction in addedAfterSprintStart("EX Scrum Board", 30)
```
    
    This approach is useful when working with dynamic board setups where sprint names might be reused or when integrating automated systems that track sprint changes by ID.  
    To find the sprint ID:
    
    1.  Go to the board's backlog.
    2.  Right click the elipsis icon just above the sprint.  
        ![](/sr4jc/files/latest/313196618/313196621/1/1734104010000/copy+link.jpg)  
        
    3.  Copy the link, or URL, that looks similar to [https://your-jira-instance.atlassian.net/rest/greenhopper/1.0/xboard/plan/sprints/actions?sprintId=30](https://your-jira-instance.atlassian.net/rest/greenhopper/1.0/xboard/plan/sprints/actions?sprintId=30).
    4.  Go to the end of the link where you can retrieve the ID. In this example, the ID is 30.

**Ensure accurate board and sprint linking:** Remember that the sprint must be associated with the specified board; otherwise, the query will return no results.

## inSprint

The `inSprint` function provides an overview of all issues currently scheduled in a specific sprint on a given agile board. This function is crucial for:

-   Monitoring current sprint progress, helping teams to stay aligned with their sprint goals and timelines.
    
-   Facilitating sprint reviews by providing a complete list of tasks that are part of the sprint.
    
-   Supporting scrum masters and project managers in maintaining a clear view of sprint dynamics and ensuring that the sprint backlog is managed effectively.
    

### Syntax and parameters

```
inSprint(Board, Sprint)
```

-   **Board:** The name or ID of the agile board. This can be a string name or a numeric ID, which is found in the board's URL.
    
-   **Sprint:** The name of the sprint for which issues are to be queried. This should correspond exactly to how the sprint is named in Jira.
    

### **Example**

**Reviewing current sprint issues:**

For a team looking to get a snapshot of all tasks within "`Sprint 3`" on the "`EX Scrum Board`":

```
issueFunction in inSprint("EX Scrum Board", "Sprint 3")
```

This query helps the team quickly access all the issues they are working on in the current sprint, useful for daily stand-ups or sprint planning meetings.

**Accurate sprint naming:** Ensure that the sprint names used in queries match exactly those used in Jira to avoid discrepancies in issue retrieval.

## nextSprint

The `nextSprint` function allows you to find issues slated for the upcoming active sprint of a specified agile board. This functionality is especially useful for:

-   Preparing teams for upcoming sprints by giving them a preview of tasks that will be their responsibility
    
-   Enabling proactive identification and resolution of potential bottlenecks or issues before the sprint begins.
    
-   Assisting in sprint planning by ensuring that all tasks are appropriately assigned and balanced among team members.
    

### Syntax and parameters

```
nextSprint(Board)
```

-   **Board:** The name or ID of the agile board from which to retrieve the issues of the next sprint. The board ID can be used directly in the function without quotes (found in the board’s URL).
    

### **Example**

****Checking personal assignments for the next sprint**:**

For individuals looking to prepare for their responsibilities in the next sprint:

```
issueFunction in nextSprint(452) AND assignee = currentUser()
```

This query helps team members to see what tasks are coming up for them, allowing them to start thinking about priorities and dependencies ahead of time

## previousSprint

The `previousSprint` function allows you to identify issues from the last active sprint of a specified agile board. This function is invaluable for:

-   Conducting detailed retrospectives to identify what worked well and what could be improved from the previous sprint, helping teams to continuously refine their agile practices.
    
-   Analysing the completion rates and identifying carry-over tasks that weren't finished in the previous sprint, which can inform the planning of future sprints.
    
-   Preparing reports and metrics on sprint performance, supporting transparent communication and continuous improvement within agile teams.
    

### Syntax and parameters

```
previousSprint(Board)
```

-   **Board:** The name or ID of the agile board from which to retrieve the issues of the previous sprint.
    

### **Example**

**Analysing unfinished work from the previous sprint:**

To find out which issues were not completed in the previous sprint and do not yet have a targeted release version:

```
issueFunction in previousSprint("Kanban Board") AND fixVersion IS EMPTY
```

This query helps in tracking tasks that are still pending and need to be addressed or reassigned in the current or upcoming sprints.
