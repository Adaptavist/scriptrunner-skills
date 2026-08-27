# Rewrite Scripts with HAPI

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-288524093
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/rewrite-scripts-with-hapi

Here you'll find useful information on how you can simplify your current scripts with HAPI, and learn some helpful tips too.

## Reasons to rewrite current scripts

There are many reasons you should simplify your scripts with HAPI:

-   It significantly reduces script length, making it easier to read.
-   HAPI scripts are easier to maintain, reducing the time spent troubleshooting when scripts stop working.
-   Your HAPI functions will not break when Atlassian updates its underlying API, as we maintain the functions.
-   We maintain HAPI functions, ensuring they remain unaffected when Atlassian updates its underlying API. 
-   Scripts that are 100% HAPI will not need modifying during the [migration process](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist). In fact, scripts built with HAPI are easier to migrate when moving to Jira Cloud. HAPI in ScriptRunner for Jira Cloud works the same as in Data Center, making migration smoother. Scripts fully written with HAPI **require no modifications during migration**, while those partially using HAPI are still easier to migrate compared to scripts without HAPI.

## How to simplify scripts using HAPI examples

This script automates the copying of every label from a work item to all work items linked to it, specifically targeting those with an outward link.

```
// Specify the Work Item's key
final workItemKey = "TEST-1"

// Make a rest call to return the Work Item
def workItem = get("/rest/api/2/issue/${workItemKey}")
    .header('Content-Type', 'application/json')
    .asObject(Map)
    .body as Map

def fields = workItem.fields as Map
// Get the labels from the work item
def labels = fields.labels

// Find the linked work items
def linkedWorkItems = fields.issuelinks as List<Map>

// Loop over each linked work item
def successStatusByWorkItemKey = linkedWorkItems.collectEntries { Map linkedWorkItem ->
    if (!linkedWorkItem.outwardIssue) {
        def inwardWorkItem = linkedWorkItem.inwardIssue as Map
        return [(inwardWorkItem.key): "Link is not outward for linked work item ${inwardWorkItem.key}"]
    }
    // Update each linked work item to set the labels using the key for each linked work item
    def outwardWorkItem = linkedWorkItem.outwardIssue as Map
    def updateLinkedWorkItem = put("/rest/api/2/issue/${outwardWorkItem.key}")
        .header('Content-Type', 'application/json')
        .body([
            fields: [
                labels: labels
            ]
        ])
        .asString()
    if (updateLinkedWorkItem.status == 204) {
        // Print to the log tabs what iteration the loop is on and the key of the work item that was updated
        logger.info("Labels on ${outwardWorkItem.key} work item has been set.")
    } else {
        // Print to the log tabs what iteration the loop is on and the key of the work item that was not updated
        logger.error("Labels on ${outwardWorkItem.key} work item has not been set.")
    }
    [(outwardWorkItem.key): (updateLinkedWorkItem.status == 204)]
}

"""Status by work item key (labels copied?): ${successStatusByWorkItemKey}.
Please see the 'Logs' tab for more information on what work items were updated."""
```

```
// Specify the Work Item by key
def workItem = WorkItems.getByKey("TEST-9");
String[] labels = workItem.labels.collect{it.toString()}.toArray(new String[0]);

// Loop linked work item, outward links specifically
def successStatusByWorkItemKey = workItem.getOutwardLinks().collect { linkedWorkItem ->
    WorkItems.getByKey(linkedWorkItem.outwardIssue.key).update {
        setLabels (labels)
    }
    linkedWorkItem.outwardIssue.key
}

successStatusByWorkItemKey ? """Labels successfully copied to work items: ${successStatusByWorkItemKey}. 
Please see the 'Logs' tab for more information on what work items were updated.""" : "No outward links found. No labels copied."
```

This script enables you to select work items that match criteria specified in a JQL query and set the _impediment_ flag on each of them.

```
// Define a JQL query to search for the work items on which you want to set the impediment flag
def query = "<JQLQueryHere>"

// Look up the custom field ID for the flagged field
def flaggedCustomField = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find {
    (it as Map).name == "Flagged"
} as Map

// Search for the work items we want to update
def searchReq = get("/rest/api/2/search")
        .queryString("jql", query)
        .queryString("fields", "Flagged")
        .asObject(Map)

// Verify the search completed successfully
assert searchReq.status == 200

// Save the search results as a Map
Map searchResult = searchReq.body

// Iterate through the search results and set the Impediment flag for each work item returned
searchResult.issues.each { Map workItem ->
    def result = put("/rest/api/2/issue/${workItem.key}")
            .queryString("overrideScreenSecurity", Boolean.TRUE)
            .header("Content-Type", "application/json")
            .body([
            fields:[
                    // The format below specifies the Array format for the flagged field
                    // More information on flagging an issue can be found in the documentation at:
                    // https://confluence.atlassian.com/jirasoftwarecloud/flagging-an-issue-777002748.html
                    // Initialise the Array
                    (flaggedCustomField.id): [
                                                  [ // set the component value
                                                    value: "Impediment",
                                                  ],

                    ]
            ]
    ])
            .asString()

    // Log out the work items updated or which failed to update
    if (result.status == 204) {
        logger.info("The ${workItem.key} work item was flagged as an Impediment.")
    } else {
        logger.warn("Failed to set the Impediment flag on the ${workItem.key} work item. ${result.status}: ${result.body}")
    }
}  // end of loop

"Script Completed - Check the Logs tab for information on which work items were updated."
```

```
// Define a JQL query to search for the work items on which you want to set the impediment flag
def query = "<JQLQueryHere>"

// Iterate through the search results and set the Impediment flag for each work item returned
WorkItems.search(query).each { workItem ->
    workItem.update {
        setCustomFieldValue("Flagged", "Impediment")
    }
    logger.info("The ${workItem.key} work item was flagged as an Impediment.")
}

"Script Completed - Check the Logs tab for information on which work items were updated."
```

This script adds all the values of a custom field from all the work items and subtasks contained in an epic, and sets the sum as the value of the same custom field in the epic work item.

```
//Epic Link Custom Field ID
final epicLinkCf = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find {
            (it as Map).name == 'Epic Link'
        } as Map
logger.info("epicLinkCf : ${epicLinkCf}")

//Number Custom Field ID
final numberCf = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find {
            (it as Map).name == 'Custom Field 1'
        } as Map
logger.info("numberCf : ${numberCf}")

def workItemFields = get("/rest/api/2/issue/$workItem.key")
        .asObject(Map)
        .body
        .fields as Map


//If the work item has no parent or is not related with an epic, the script will not be executed
def workItemParent = workItemFields.find { it.key == 'parent' }?.value as Map
def epicKey = workItemFields.find { it.key == epicLinkCf.id }?.value
logger.info("workItemParent: ${workItemParent}, epicKey: ${epicKey}")
if (!epicKey && !workItemParent) {
    return
}

logger.info("work item: ${workItem}")
//If the work item is sub-task, Epic Key is obtained from the parent work item
if (workItem.fields.issuetype.subtask) {
    def parentWorkItemField = get("/rest/api/2/issue/$workItemParent.key")
            .asObject(Map)
            .body
            .fields as Map

    epicKey = parentWorkItemField.find { it.key == epicLinkCf.id }.value
}

//Obtain all related epic work items, including sub-tasks
def allChildWorkItem = get("/rest/api/2/search")
        .queryString('jql', "linkedissue = $epicKey")
        .header('Content-Type', 'application/json')
        .asObject(Map)
        .body
        .issues as List<Map>

def sum = 0
def workItems = allChildWorkItems.findAll { it.key != epicKey }

worktItems.each {
    def fields = get("/rest/api/2/issue/$it.key")
            .header('Content-Type', 'application/json')
            .asObject(Map)
            .body
            .fields as Map
    def numberCfValue = fields[numberCf.id] ?: 0
    sum += numberCfValue as Integer
}

put("/rest/api/2/issue/$epicKey")
        .header("Content-Type", "application/json")
        .body([
                fields: [
                        (numberCf.id): sum
                ]
        ]).asString()
```

 

```
//the name of the custom field. This code will work just as well with the custom field ID instead i.e. 10124L
def sumCustomFieldName = 'custom field name i.e. Sum Of Value'
def eventWorkItem = WorkItems.getByKey(workItem.key as String)

//for regular work items the parent is an Epic
def epicKey = eventWorkItem.getParentObject()?.key ?: null

if(!epicKey) {
    // Checks the 'Epic Link' custom field
    epicKey = eventWorkItem.getEpic()?.key ?: null
}

if (!epicKey && eventWorkItem.issueType.subtask) {
    epicKey = eventWorkItem.parentObject?.epic?.key ?: null
}

if (!epicKey) {
    logger.info("We did not find an Epic in the hierarchy of this work item. Exiting.")
    return
}

//find all work items linked to the epic, taking care to exclude the epic itself as we sum over this list
def epicWorkItem
def sum = WorkItems.search("linkedissue = ${epicKey}").sum { workItem ->
    if (workItem.key == epicKey) {
        epicWorkItem = workItem // Store the epic work item
        return 0 // Exclude the epic work item from the sum
    }
    return workItem.getCustomFieldValue(sumCustomFieldName) ?: 0 // Safely sum non-epic values
}

epicWorkItem.update {
    setCustomFieldValue(sumCustomFieldName, sum)
}
```

Once the code has been updated, you might not need some imports - hover over them to see if they’re still required in your script.

## How to rewrite existing scripts video demo

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;
