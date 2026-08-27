# Example Custom Scripts

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules > perform-actions
- Doc ID: doc-sr4jc-104376138
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/example-custom-scripts

## Add an automated comment for every work item created inside a JSM customer portal

Add an automated comment including a greeting and a request for information. Also, explain that the work item will be closed if left inactive on all new work created in Jira Service Management.

```
def comment = """
                Hi, ${issue.fields.reporter.displayName} from ${issue.fields.customfield_12818.value} office,

                Thank you for creating this ticket in our service desk. You have requested a laptop replacement delivered to the following destination:

                ${issue.fields.customfield_12831}

                Please make sure the address is correct. We will respond to your request shortly.

                Kindly also note that if the ticket remains inactive for 10 days, it will be automatically closed.
            """

def addComment = post("/rest/servicedeskapi/request/${issue.key}/comment")
        .header('Content-Type', 'application/json')
        .body([
                body: comment,
                // Make comment visible in the customer portal
                public: true,
        ])
        .asObject(Map)

assert addComment.status >= 200 && addComment.status <= 300
```

## Add label

This example script shows how you can add a label when using the clone work item workflow action.

```
List labels = issue.fields.labels ?: [] // get the labels for the current item
labels += "newLabel"
issueInput.fields.labels = labels
```

## Add a comment to linked work items when this work item is transitioned

```
def issueHapi = Issues.getByKey(issue.key)
def linkedIssues = issueHapi.getLinkedIssues()

// Loop through the linked work items to add a comment to inward work items
linkedIssues.each { linkedIssue ->
    linkedIssue.comment("Parent issue ${issue.key} has been transitioned to ${issueHapi.getStatus().name}.")
}
```

## Add a comment to this work item

```
def issue = Issues.getByKey(issue.key)
issue.comment("This is a work item comment on transition.")
```

## Add a customer-facing comment on a linked service management

This script allows you to add a comment on a linked Jira Service Management Cloud space after the transition of a work item. For example, you may want to let a bug reporter know that the related development is marked as complete.

We advise you to run this script as the _ScriptRunner Add-on User_.

```
// Define a counter which will be the number of support tickets updated by this script
def counter = 0

// Define the Service Desk Issuetypes you only want updated if a linked Jira software work item is closed
def serviceDeskIssueTypes = [
    "Incident",
    "Feature Request"
]

def issueHapi = Issues.getByKey(issue.key)
def linkedIssues = issueHapi.getLinkedIssues()

// Loop over each linked issue
linkedIssues.each { linkedIssue ->
    // For each linked issue, comment only on Service Desk Tickets
    if (serviceDeskIssueTypes.contains(linkedIssue.getIssueType().name)) {
        linkedIssue.comment("""
            Good news! We've now completed the development work related to this ticket.
        """)
        counter++
        // Log info about which Service Desk ticket was just updated
        logger.info("Issue ${issue.key} has been closed. \nService Desk ticket ${linkedIssue.getKey()} has been commented to inform affected customers.")
    }
}

return "The script finished successfully. ${counter} support ticket/s were commented on.
```

## Add a customer to an organization when a work item is created through the customer portal

Add customers to configured organisations when they create a work item through the service desk portal and select their organisation in a select list custom field.

```
**Note:** Service Desk API calls don't have HAPI equivalents, so this remains as REST API.

def serviceDeskId = "2"
def issueHapi = Issues.getByKey(issue.key)
def currentUser = issueHapi.getReporter().accountId

// Get the Custom field to get the option value from
def organisationCustomField = get("/rest/api/2/field")
    .asObject(List)
    .body
    .find { (it as Map).name == "Organisation" } as Map

assert organisationCustomField

def organisationValue = issueHapi.getCustomFieldValue(organisationCustomField.id)?.value

def organisations = get("rest/servicedeskapi/servicedesk/${serviceDeskId}/organization")
    .asObject(Map)

assert organisations

def organisationsValues = organisations.body.values

switch (organisationValue) {
    case "Adaptavist":
        def adaptavistId = organisationsValues.find { (it as Map).name == "Adaptavist" } as Map
        addToOrganisation(adaptavistId, currentUser)
        break
    case "Google":
        def googleId = organisationsValues.find { (it as Map).name == "Google" } as Map
        addToOrganisation(googleId, currentUser)
        break
    case "Atlassian":
        def atlassianId = organisationsValues.find { (it as Map).name == "Atlassian" } as Map
        addToOrganisation(atlassianId, currentUser)
        break
    default:
        logger.info("No matching organisation specified.")
        break
}

// Utility method for handling all the logic to add users to an organisation
def addToOrganisation(Map organisation, currentUser) {
    def currentUsersInOrganistion = get("/rest/servicedeskapi/organization/${organisation.id}/user")
        .asObject(Map)
        .body
        .values
    
    if (currentUser in currentUsersInOrganistion.accountId) {
        logger.info("User already in organisation, script terminating.")
        return
    }
    
    def addToOrganisation = post("rest/servicedeskapi/organization/${organisation.id}/user")
        .header("Content-Type", "application/json")
        .body([
            accountIds: [currentUser],
            organisationId: organisation.id
        ])
        .asObject(Map)
    
    assert addToOrganisation.status >= 200 && addToOrganisation.status <= 300
}
```

## Add the current user as a watcher

```
final issueKey = issue.key

def result = get('/rest/api/2/user/assignable/search')
    .queryString('issueKey', "${issueKey}")
    .header('Content-Type', 'application/json')
    .asObject(List)

def usersAssignableToIssue = result.body as List<Map>

def currentUser = get('/rest/api/3/myself')
    .asObject(Map)
    .body

usersAssignableToIssue.forEach { Map user ->
    def displayName = user.displayName as String
    logger.info(displayName + " : " + currentUser)
    if (displayName == currentUser.displayName) {
        logger.info("Match")
        def watcherResp = post("/rest/api/2/issue/${issueKey}/watchers")
            .header('Content-Type', 'application/json')
            .body("\"${currentUser.accountId}\"")
            .asObject(List)

        if (watcherResp.status == 204) {
            logger.info("Successfully added ${displayName} as watcher of ${issueKey}")
        } else {
            logger.error("Error adding watcher: ${watcherResp.body}")
        }
    }
}
```

## Automatically close all sub-tasks when the parent work item is transitioned to a done status

Automatically close all subtasks when the parent work item transitions to the Done status to keep your Jira instance clean.

```
// Get all subtasks below a work item
def jqlQuery = "parent=${issue.key}"

// Specify the name below for the global Done transition
def doneTransitionName = "Done"

// Get all subtask issues for the current work item
def allSubtasks = Issues.search(jqlQuery)

/**
 * You can also get the subtasks for the desired work item in the following way
 *
 * def allSubtasks = Issues.getByKey(issue.key).getSubtasks()
 */

// Iterate over each subtask returned
allSubtasks.each { subtask ->
    subtask.transition(doneTransitionName)
}
```

## Calculated custom field

This example is similar to the [calculated field example](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/script-listener-examples) for Script Listeners, except that the calculation occurs when the work item transitions to a specific workflow status.

```
def issueHapi = Issues.getByKey(issue.key)

// Get custom field values using HAPI
def input1 = issueHapi.getCustomFieldValue('Custom Field 1') as Integer
def input2 = issueHapi.getCustomFieldValue('Custom Field 2') as Integer

if (input1 == null || input2 == null) { 
    logger.info("Calculation using ${input1} and ${input2} was not possible")
    return
}

def output = input1 + input2
def currentOutput = issueHapi.getCustomFieldValue('Output Custom Field') as Integer

if (output == currentOutput) { 
    logger.info("already been updated")
    return
}

issueHapi.update {
    setCustomFieldValue('Output Custom Field', output)
}
```

**Line 1:** Grab the values of the custom fields from the event.

**Line 14:** Sanity check for null values - the work item may not have a value for any input.

**Line 20:** Here, we check if the output field already has the calculated value; if it does, we do nothing. This is important because an IssueUpdated event will fire for the update we are about to perform.

**Line 24:** Update the value of the custom field.

**Line 25:** If using the Add-on user to run the script, it is possible to set the overrideScreenSecurity property to modify fields that are not on the current screen.

## Clone a work item on transition with new due date and update date attribute of associated Assets

This script shows how to clone a work item with associated assets, setting the new work item's due date to 3 months from now. Then, update the date attribute of the associated assets.

```
import java.time.format.DateTimeFormatter
import java.time.LocalDate
import java.sql.Timestamp

// To find the Assets Attribute ID: Navigate to Scheme > Object Type > Attributes
def assetCustomFieldName = "customfield_12834"
final lastMaintenanceDateAssetAttributeId = 153

def sourceIssue = Issues.getByKey(issue.key) // Get the hapi issue
def dueDate = sourceIssue.getDueDate()

if (!dueDate) {
    logger.error "No original due date"
    return
}

def assetFieldValue = sourceIssue.getCustomFieldValue(assetCustomFieldName)

if (!assetFieldValue) {
    logger.error "No value in Assets field: $assetCustomFieldName"
    return
}

final dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")

def newDueDate = dueDate.toLocalDate().plusMonths(3)
def projectKey = sourceIssue.getProjectObject().key
def issueTypeName = sourceIssue.getIssueType().name

Issues.create(projectKey, issueTypeName) {
    setSummary(sourceIssue.getSummary())
    setDescription(sourceIssue.getDescription())
    setDueDate(newDueDate.format(dateFormatter))
    setCustomFieldValue(assetCustomFieldName, assetFieldValue)
}.link("clones", sourceIssue)

assetFieldValue.each { asset ->
    def assetWorkspaceId = asset.workspaceId
    def assetObjectId = asset.objectId
    def updatedAssetResponse = put("https://api.atlassian.com/jsm/assets/workspace/" + assetWorkspaceId + "/v1/object/" + assetObjectId)
            .header("Content-Type", "application/json")
            .basicAuth("email@example.com", "<api_token>")
            .body([
                    attributes: [
                            [
                                    objectTypeAttributeId: lastMaintenanceDateAssetAttributeId,
                                    objectAttributeValues: [
                                            [
                                                    value: dueDate.toLocalDate().format(dateFormatter).toString(),
                                            ]
                                    ]
                            ]
                    ]
            ])
            .asObject(Map)

    assert updatedAssetResponse.status >= 200 && updatedAssetResponse.status < 300
}
```

## Condition work item must have assignee

The condition for the workflow action that will run only if the work item has an Assignee.

```
issue.fields.assignee != null
```

## Create a linked development bug when a bug is raised in a service management space

Each time a customer raises a bug inside a service management space, using this example script automatically creates a linked bug work ticket in the development space.

```
// Specify the key of the space to create the work in.
def projectKey = "Demo"

// Specify the name of the Bug work type
def bugIssueType = "Bug"

def issueHapi = Issues.getByKey(issue.key as String)
// Get the value entered on the Service Desk ticket for Summary and Description
def serviceDeskIssueSummary = issueHapi.getSummary()
def serviceDeskIssueDescription =  issueHapi.getDescription()

def createdIssue =  Issues.create(projectKey, bugIssueType) {
    setSummary(serviceDeskIssueSummary)
    setDescription(serviceDeskIssueDescription)
}

// Create the work link between both items
issueHapi.link("relates to", createdIssue)
```

## Create work based on data retrieved from external systems

This example script makes an external system call and creates a new work item in a selected space based on the returned information.

```
import java.time.LocalDateTime
import java.time.ZoneOffset

final projectKey = 'TEST'
//External task type name
final externalIssueTypeName = 'External Task'
//External system URL
final externalUrl = 'https://external.system'

//We can compute the time between epoch and one hour before now to obtain work items from external by this time.
def timestamp = LocalDateTime.now()
    .minusHours(1)
    .toInstant(ZoneOffset.UTC).toEpochMilli()

//We can define here the endpoint to retrieve data from the external system and the required query strings.
//In this example, we use "since" as a query string parameter, which defines the time by which we want to search.
def results = get("$externalUrl/rest/api/1/results")
    .queryString('since', timestamp)
    .asObject(List)
    .body as List<Map>

//For every result obtained, a new work item is created.
results.each { Map result ->
    Issues.create(projectKey, externalIssueTypeName ) {
        summary = result.name
        description = result.message
    }
}
```

## Create sub-tasks when a work item is created

This example script automatically creates sub-tasks when a new work item is created.

```
def eventIssue = Issues.getByKey(issue.key as String)

if (eventIssue.issueType.subtask) { // If the newly created work item is a subtask, skip the execution
    return
}

def listOfsummaries = ['Subtask summary 1', 'Subtask summary 2'] // The summaries to use for
def subtaskIssueType = 'Sub-task' // The Sub Task Work Type to Use

def projectKey = eventIssue.getProjectObject().key

listOfsummaries.forEach { summary ->
    eventIssue.createSubTask(subtaskIssueType) {
        setSummary(summary)
    }
}
```

## Clear field(s) workflow action

```
def issueHapi = Issues.getByKey(issue.key)
def fieldsToClear = ["customfield_10047", "customfield_10007", "customfield_10040"]

issueHapi.update {
    fieldsToClear.each { fieldId ->
        setCustomFieldValue(fieldId, null)
    }
}
```

## Link to a work item

Automatically link the work item being transitioned to another item.

```
def issueHapi = Issues.getByKey(issue.key)
def targetIssue = Issues.getByKey('EX-1')
issueHapi.link("Blocks", targetIssue)
```

## Post to Slack

Use this example to send a simple Slack post, notifying users that a work item has been updated.

```
def apiToken = 'YOUR_SECRET_TOKEN'

def msg = [
        channel: 'your-channel-here',
        username: 'Any Username Here',
        icon emoji: ':rocket:',
        text: "${issue.key} Updated",
]

post('https://slack.com/api/chat.postMessage')
        .header('Content-Type', 'application/json')
        .header(Authorization', "Bearer ${apiToken}")
        .body(msg)
        .asString()
```

**Line 1:** Generate a Slack API token and use it here. This API token should be saved as a script variable.

**Line 4:** Add the name of the channel you wish to post to.

**Line 5:** Enter the username ScriptRunner will post as.

**Line 7:** Enter the notification text.

**Line 10:** Post the message to Slack.

## Set label

This example script shows how you can set labels when updating a work item.

```
issueInput.update.labels = [[set: ["finance"]]]
```

## Update the Assets field from AQL based on another Assets field value

This example shows how you can retrieve an **Assets** field value. Then, perform an AQL query to retrieve a list of asset objects and save them into another **Assets** field.

```
final MODEL_ASSETS_CUSTOMFIELD_ID = 'customfield_12832'
final PHONES_ASSETS_CUSTOMFIELD_ID = 'customfield_12834'
final ATTRIBUTE_NAME_OF_MODEL_IN_PHONES = 'Model Name'

def issueHapi = Issues.getByKey(issue.key)

def getModelNameResponse = get('/rest/api/3/issue/' + issue.key)
    .header('Content-Type', 'application/json')
    .queryString("expand", "${MODEL_ASSETS_CUSTOMFIELD_ID}.cmdb.attributes")
    .asObject(Map)

assert getModelNameResponse.status == 200

if (!getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID]) {
    logger.warn "No value in Assets field: $MODEL_ASSETS_CUSTOMFIELD_ID"
    return
}

def workspaceId = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().workspaceId
def objectSchemaId = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().objectType.objectSchemaId
def modelName = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().label

def aql = """
    "objectSchemaId" = "$objectSchemaId" and "$ATTRIBUTE_NAME_OF_MODEL_IN_PHONES" = "$modelName"
"""

def aqlQueryResponse = post("https://api.atlassian.com/jsm/assets/workspace/$workspaceId/v1/object/aql")
    .header('Content-Type', 'application/json')
    .basicAuth("user@example.com", "<api_token>")
    .body([
        qlQuery: aql
    ])
    .asObject(Map)

assert aqlQueryResponse.status == 200

def matchedPhoneAssetIds = aqlQueryResponse.body.values*.globalId

issueHapi.update {
    setCustomFieldValue(PHONES_ASSETS_CUSTOMFIELD_ID, matchedPhoneAssetIds.collect { id -> [id: id] })
}
```

## Update transition comment message

This example script shows how you can update the comment identifying the transition.

```
// this only works when there is a transition screen
Map addComment = transition.update.comment[0].add as Map
addComment.body = "${issue.key} caused this to be transitioned"
```
