# Example Escalation Code

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Escalation Service
- Doc ID: doc-sr4jc-2e069482-b2ef-4947-b93a-9e703e50ce03-758d897aa4cc77b0
- Source: https://docs.adaptavist.com/sr4jc/latest/features/escalation-service#example-escalation-code--en

You can use one of the examples below as a good starting point to begin writing and editing code that meets your requirements.

## Add a Label to a Work Item

With this example script, you can add a label to all work items matching the escalation service JQL query.

Use the following script to add a label to all work items matching the escalation service JQL query.

```
def currentIssue = Issues.getByKey(issue.key as String)
// you can *add* a label to existing labels
currentIssue.update {
    setLabels {
        add('MY_LABEL_1')
    }
}
// *OR* you can set multiple labels at once (this syntax overwrites all labels)
currentIssue.update {
    setLabels('MY_LABEL_1', 'MY_LABEL_2')
}
// you can *remove* or *replace* labels
currentIssue.update {
    setLabels {
        remove('MY_LABEL_1')
        replace('MY_LABEL_2', 'MY_LABEL_3')
    }
}
```

## Add Comments to unresolved Sub-tasks

This example script demonstrates how to add a comment to all unresolved subtasks.

  

```
def currentIssue = Issues.getByKey(issue.key as String)
def issueSubtasks = currentIssue.subtasks
 
issueSubtasks.forEach { subtask ->
 if (subtask.getStatus().name == "Done") {
 return
    }
    subtask.addComment("""Parent task ${issue.key} is resolved and has status: '${(currentIssue.status as Map).name}'.
        Please change status of this issue.""")
}
```

## Flag a Work Item

This example demonstrates how to flag the work items returned by the JQL search, which is executed at a specified time.

To use this example, you will need to specify the JQL query to search for the work items to be updated, along with the schedule of when this escalation service should run.

```
// Look up the custom field ID for the flagged field
def flaggedCustomField = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find {
    (it as Map).name == 'Flagged'
} as Map
 
// Update the issue setting the flagged field
def result = put("/rest/api/2/issue/${issue.key}")
        .header('Content-Type', 'application/json')
        .body([
        fields:[
 // The format below specifies the Array format for the flagged field
 // More information on flagging an issue can be found in the documentation at:
 // https://confluence.atlassian.com/jirasoftwarecloud/flagging-an-issue-777002748.html
                (flaggedCustomField.id): [ // Initialise the Array
                                           [ // set the component value
                                             value: "Impediment",
                                           ],
 
                ]
        ]
 
])
        .asString()
 
// Check if the issue was updated correctly
// Log out the issues updated or which failed to update
if (result.status == 204) { (11)
    logger.info("The ${issue.key} issue was flagged as an Impediment. ")
} else {
    logger.warn("Failed to set the Impediment flag on the ${issue.key} issue. ${result.status}: ${result.body}")
}
 
// Add a return message to show which issues the escalation service ran on.
return "Escalation Service completed on ${issue.key}"
```

## Transition a Work Item

This example demonstrates how to automatically transition the work items returned by a JQL search, which is executed at a specified time.

To use this example, you will need to specify the JQL Query to search for the work items to be updated, along with the schedule of when this escalation service should run.

```
// The ID of the workflow transition to execute.
// Note - The transition ID must represent a valid transition for the workflow that the issue uses.
def transitionID = '<TransitionIDHere>'
 
// The rest call to transition the issue
def result = post("/rest/api/2/issue/${issue.key}/transitions")
        .header("Content-Type", "application/json")
        .body([transition: [id: transitionID]])
        .asObject(Map)
 
// Check if the issue was transitioned correctly
// Log out the issues updated or which failed to update
if (result.status == 204) {
    logger.info("The ${issue.key} issue was transitioned by the escalation service.")
} else {
    logger.warn("The escalation service failed to transition the ${issue.key}issue. ${result.status}: ${result.body}")
}
 
// Add a return message to show which issues the escalation service ran on.
return "Escalation Service completed on ${issue.key}"
```
