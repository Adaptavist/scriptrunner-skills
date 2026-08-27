# Example Scripts

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-console
- Doc ID: doc-sr4jc-103678193
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-console/example-scripts

We have provided a few example scripts below. These examples serve as a good starting point for writing and editing your own code. Once you have completed your code changes, you can test it by clicking the **Run** button. 

Run code as user

Code that is run from the Script Console can make requests back to Jira using either the **ScriptRunner Add-on user** or the **Current User**. See the [Run As User section of Workflow Extensions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields) for more information.

## Add a user or group to a space role

Say we would like to add a user to a group. This can be quickly achieved using the following, assuming that the user, group, space, and role all exist

```
def myself = Users.getLoggedInUser()

def spaceKey = 'TP'
def roleId = '10002'

def result = post("rest/api/3/project/${spaceKey}/role/${roleId}")
    .header('Content-Type', 'application/json')
    .body([
        "user": [myself.accountId]
    ])
    .asObject(Map)

result.body
```

**Line 6:** Then the url for the specified role is found to use to post to

**Line 9:** In this case we have a group and a user to add, `user` and `group` must be arrays

## Add comment using Atlassian Document Format (ADF)

This example shows how you can add a comment on a work item using Atlassian Document Format to add rich text markup in the comment.

```
def adf = [
    version: 1,
    type: "doc",
    content: [
        [
            type: "paragraph",
            content: [
                [
                    type: "text",
                    text: "A demo comment added using Atlassian document format"
                ]
            ]
        ]
    ]
]

WorkItems.getByKey('workItemKey').update { 
    setComment(adf)
}
```

## Bulk set flag on multiple work items

This example extends the previous example and shows how you can set the Impediment flag on multiple work items.

```
// Define a JQL query to search for the issues on which you want to set the impediment flag
def query = "<JQLQueryHere>"

// Iterate through the search results and set the Impediment flag for each work item returned
WorkItems.search(query).each { workItem ->
    workItem.update {
        setCustomFieldValue("Flagged", "Impediment")
    }
    logger.info("The ${workItem.key} issue was flagged as an Impediment.")
}

"Script Completed - Check the Logs tab for information on which work items were updated."
```

## Bulk update multiple work item resolutions

This example code highlights how to bulk update the resolution of all work items returned from a JQL search that meet the specified condition. For example, say a Jira admin wants to change the resolution of a large number of work items that were mislabeled. This script can be used to update the resolution of all these work items to their corresponding one (like "Duplicate").

You can use this code as part of a larger script to update the work item resolution based on additional logic, and you can look up the available resolution names in "Jira Settings" > "ISSUE ATTRIBUTES" > "Resolutions".

```
// The Name of the resolution to be set
def resolutionName = 'Cannot Reproduce'

// Get all issues matching the specified JQL Query
WorkItems.search("project = TEST AND issueType = Bug").each { workItem ->
    workItem.transition('Done') {
        setResolution(resolutionName)
    }
    logger.info("Resolution set to ${resolutionName} for the ${workItem.key} issue")
}
```

## Connect to databases

You can make database connection calls via groovy within ScriptRunner for Jira Cloud, meaning that you can read or write to a database as part of a script. 

As this feature is provided from within the groovy scripts, in order to use it, you need to import SQL modules in groovy that allow you to run SQL against an external database, as outlined in the examples below.

Connecting to postgres database:

```
import groovy.sql.Sql
import java.sql.Driver

def db = [url:'jdbc:postgresql://my.example.com:1234/', user:'username', password:'password', driver:'org.postgresql.Driver']
def sql = Sql.newInstance(db.url, db.user, db.password, db.driver)
 
    sql.rows '''
        SELECT *
        FROM "example"
        LIMIT 100
    '''
```

Connecting to mySQL database:

```
import groovy.sql.Sql
import java.sql.Driver

def db = [url:'jdbc:mysql://my.example.com', user:'username', password:'password', driver:'com.mysql.cj.jdbc.Driver']
def sql = Sql.newInstance(db.url, db.user, db.password, db.driver)
 
    sql.rows '''
        SELECT *
        FROM "example"
        LIMIT 100
    '''
```

Connecting to MSSQL database:

```
import groovy.sql.Sql
import java.sql.Driver

def db = [url:'jdbc:sqlserver://my.example.com', user:'username', password:'password', driver:'com.microsoft.sqlserver.jdbc.SQLServerDriver']
def sql = Sql.newInstance(db.url, db.user, db.password, db.driver)
 
    sql.rows '''
        SELECT *
        FROM "example"
        LIMIT 100
    '''
```

## Copy space

The copy space ScriptRunner for Jira Server/DC built-in script can achieve the same functionality in Jira Cloud by using the Script Console and a script. There are limitations to what can be copied to the new space due to the request body parameters for the [create project API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-post) call. 

```
// Set the source space key
def sourceSpaceKey = 'SUP'

// Get the source space
def sourceSpace = get("/rest/api/3/project/${sourceSpaceKey}")
	.header('Content-Type','application/json')
	.asObject(Map)

if(sourceSpace.status == 200){
// Assign space variables and build body
	def copyKey = 'TEST'
	def copyName = 'Test Space'
	def spaceTypeKey = sourceSpace.body.spaceTypeKey
	def spaceTemplateKey = 'com.pyxis.greenhopper.jira:gh-simplified-scrum-classic'
	def description = sourceSpace.body.description
	def leadAccountId = sourceSpace.body.lead.accountId
	def assigneeType = sourceSpace.body.assigneeType

    def notifyScheme = get("/rest/api/3/project/${sourceSpaceKey}/notificationscheme")
    .header('Content-Type', 'application/json')
    .asObject(Map)
    .body as Map

    def notifySchemeId = notifyScheme.id

    def permissionScheme = get("/rest/api/3/project/${sourceSpaceKey}/permissionscheme")
    .header('Content-Type', 'application/json')
    .asObject(Map)
    .body as Map

    def permissionSchemeId = permissionScheme.id

def body = [
		"key": copyKey,
		"name": copyName,
		"projectTypeKey": spaceTypeKey,
		"projectTemplateKey": spaceTemplateKey,
		"description": description,
		"leadAccountId": leadAccountId,
        "assigneeType": assigneeType,
        "notificationScheme": notifySchemeId,
        "permissionScheme": permissionSchemeId
	]

// Create new space
	def newSpace = post("/rest/api/3/project")
	.header('Content-Type','application/json')
	.body(body)
	.asString()
	if(newSpace.status == 201){
		return "Space ${sourceSpaceKey} copied to create new space ${copyKey}"
	} else{
		return "Failed to create new space - ${newSpace.status}"
	}
} else{
	return "Failed to find space ${sourceSpaceKey}"
}
```

## Copy versions to a new space

This example shows how you can copy a set of versions from one space to another space.

This example will only copy versions where a version with the same name does not exist in the target space.

```
// Specify the master space  to get the versions form
final sourceSpaceKey = 'SRC'

// Specify the key of the space to copy the version to
final destinationSpaceKey = 'DST'

// Get the space versions
def versions = get("/rest/api/2/project/${sourceSpaceKey}/versions")
    .header('Content-Type', 'application/json')
    .asObject(List).body as List<Map>

// Loop over each version returned and create a version in the new space
def successStatusByVersionId = versions.collectEntries { version ->
    // Copy the version and specify the destination project
    def versionCopy = version.subMap(['name', 'description', 'archived', 'released', 'startDate', 'releaseDate', 'project'])
    versionCopy['project'] = destinationSpaceKey

    // Make the rest call to create the version
    logger.info("Copying the version with id '${version.id}' and name '${version.name}'")
    def createdVersionResponse = post('/rest/api/2/version')
        .header('Content-Type', 'application/json')
        .body(versionCopy)
        .asObject(Map)

    // Log out the versions copied or which failed to be copied
    if (createdVersionResponse.status == 201) {
        logger.info("Version with id '${version.id}' and name '${version.name}' copied. New id: ${createdVersionResponse.body.id}")
    } else {
        logger.warn("Failed to copy version with id '${version.id}' and name '${version.name}'. ${createdVersionResponse.status}: ${createdVersionResponse.body}")
    }

    [(version.id): (createdVersionResponse.status == 201)]
}

"Status by source version id (copied?): ${successStatusByVersionId}"
```

## Create a link to an external URL on a work item

This example shows how you can create a link to an external URL on a work item.

```
// The url for the link
def linkURL = '<LinkURLHere>'

// the title for the link
def linkTitle = '<LinkTitleHere>'

// The work item key
def workItemKey = '<WorkItemKeyHere>'

// Create the link on the specified work item
def result = post("/rest/api/2/issue/${workItemKey}/remotelink")
        .header('Content-Type', 'application/json')
        .body([
        object: [
                title:linkTitle,
                url:linkURL
        ]

])
        .asObject(String)

// Check if the link created successfully
if (result.status == 201) {
    return "Remote link with name of ${linkTitle} which links to ${linkURL} created successfully"
} else {
    return "${result.status}: ${result.body}"
}
```

## Create a Confluence page with a label

This example shows how you can create a page inside of a Confluence instance and add a label to the newly created page.

This example requires that you have both **ScriptRunner for Jira Cloud** and **ScriptRunner for Confluence Cloud** installed. If you do not have **ScriptRunner for Confluence Cloud** installed then you will need to update this example to specify user credentials to access the Confluence instance.

```
// Specify the id of the parent page that the new page will be created under
def parentPageId = "<PageIDHere>"

//Specify a title for the new page
def pageTitle = "<PageTitleHere>"

// Specify the space key of the Confluence space that the new page will be created in
def spaceKey = "<SpaceKeyHere>"


// Specify the body of the page in storage format - below is some example storage format.
def storageFormat = """<h1>A page created by ScriptRunner</h1>
                        <p>The first line of my page.</p>
                        <p>The second line of my page</p>"""

// Specify the body of the rest request
def body = [
             type: "page",
             title: pageTitle,
             space: [
                     key: spaceKey
             ],
             ancestors: [[
                                 id: parentPageId
                         ]],
             body:[
                     storage:[
                             value: storageFormat,
                             representation: "storage"
                     ]
             ]
]

//create confluence (cloud) page
def createPageResult = post("/wiki/rest/api/content")
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .body(body)
        .asObject(Map)
// Assert that the new page created successfully
assert createPageResult.status == 200 : "Failed to create the page"


// Add some labels to the newly created Confluence page
def addLabels = post("/wiki/rest/api/content/${createPageResult.body.id}/label")
        .header("Content-Type", "application/json")
        .header("Accept", "application/json")
        .body(
        [
                // Note you can specify a comma seperated lists of strings here if you wish to add multiple labels to a page.
                // An example of adding more than 1 label is "name"  : "ALabel,label2"
                "name"  : "<LabelNameHere>",
                "prefix": "global"
        ])
        .asString()
// Assert that the label was added to the page correctly
assert addLabels.status == 200 : "Failed to add labels to the page"

// Return the result of the created page
return "Confluence page created with the name of: ${pageTitle} \n" + createPageResult
```

**Line 12:** Here we specify the content to be added to the page using the 'Storage Format' for Confluence.

**Line 17:** Here we specify the body that is passed into the rest call to create the Confluence page.

**Line 35:** The rest API call to create the Confluence page.

**Line 45:** The rest API call to add a label to the newly created page.

## Create a sub-task

This example shows how you can create a subtask below for a specified parent work item.

This example only works with **Company Managed** spaces.

```
WorkItems.getByKey("WORK_ITEM_KEY").createSubTask('Sub-task') {
    summary = 'subtask summary'
}
```

## Extract the value from a radio button custom field

This example shows how you can extract the value that has been specified inside a radio button field on a work item.

```
def workItemKey = "<WorkItemKeyHere>"
WorkItems.getByKey(workItemKey).getCustomFieldValue('<CustomFieldNameHere>').value
```

## Extract the value from a select list custom field

This example shows how you can extract the value that has been specified inside a select list field on a work item.

```
def workItem = WorkItems.getByKey('<WorkItemKeyHere>')

//Get the custom field value for the work item by the custom field name i.e. "Change Reason"
def value = workItem.getCustomFieldValue('<CustomFieldNameHere>').value

// Return the option value
return "The value of the select list from the <CustomFieldNameHere> custom field is: ${value}"
```

## Extract the values from a checkbox custom field

This example shows how you can extract the values that have been specified inside a checkbox field on a work item.

```
def workItemKey = "<WorkItemKeyHere>"
def customFieldName = "<CustomFieldNameHere>"

def workItem = WorkItems.getByKey(workItemKey)

def checkboxes = workItem.getCustomFieldValue(customFieldName) as List<Map>
checkboxes.value
```

## Extract the values from a multi-select list custom field

This example shows how you can extract the values that have been specified inside a multi-select list field on a work item.

```
//Get the work item
def workItem = WorkItems.getByKey('<WorkItemKeyHere>')

//Get the custom field value for the work item by the custom field name i.e. "Teams To Notify Of This Change"
//We know that it is a multi select field and we cast the result to a Map so we can extract the value of each option
def values = workItem.getCustomFieldValue('<CustomFieldNameHere>') as Map

values*.value
```

## Flag a work item as an impediment

This example shows how you can flag a work item as an impediment.

```
// Specify the work item by its key and perform the update
WorkItems.getByKey('<WorkItemKeyHere>').update {
    setCustomFieldValue("Flagged", "Impediment")
}
```

## Get Jira version

Starting with a very simple script to read the Jira version and display it in the console. [API Reference.](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-serverInfo-get)

```
get('/rest/api/2/serverInfo')
        .queryString('doHealthCheck', 'true')
        .asObject(Map) 
        .body 
        .version
```

**Line 1:** This is a get request to the serverInfo resource

**Line 2:** Just as an example we see how to add a query string parameter of `doHeathCheck` and set it to `true`

**Line 3:** `asObject(Map)` makes the request and converts the response into a `Map`

**Line 4:** Calling `.body` on the result of `asObject(Map)` returns a `Map` representation of the JSON response

**Line 5:** We now read the version property of the resulting `Map`

## Post to Slack

This example posts a message to Slack in the format specified, along with work item details.

```
// Specify the work item key.
def workItemKey = '<WorkItemKeyHere>'

//Get the work item
def workItemResp = get("/rest/api/2/issue/${workItemKey}")
        .header("Content-Type", "application/json")
        .asObject(Map)

assert workItemResp.status == 200

def workItem = workItemResp.body

// Get the work item summary.
def summary = workItem.fields.summary

// Get the work item description.
def description = workItem.fields.description

// Specify the name of the Slack room you want to post to.
def channelName = '<ChannelName>'

// Specify the name of the user who will make the post.
def username = '<SlackUsername>'

// Specify the message metadata.
Map msg_meta = [ channel: channelName, username: username ,icon_emoji: ':rocket:']

// Specify the message body which is a simple string.
Map msg_dets = [text: "A new work item was created with the details below: \n Work Item key = ${workItemKey} \n Work Item Summary = ${summary} \n Work Item Description = ${description}"]

// Post the constructed message to Slack.
def postToSlack = post('https://slack.com/api/chat.postMessage')
        .header('Content-Type', 'application/json')
        .header('Authorization', "Bearer ${SLACK_API_TOKEN}") // Store the API token as a script variable named SLACK_API_TOKEN.
        .body(msg_meta + msg_dets)
        .asObject(Map)
        .body

assert postToSlack : "Failed to create Slack message check the logs tab for more details"

return "Slack message created successfully"
```

## Set custom date field value

This example shows how you can set a custom date picker field on a work item.

```
WorkItems.getByKey('<WorkItemKeyHere>').update {
    setCustomFieldValue('<DatePickerCustomFieldNameHere>', "2025-12-31")
}
```

## Set due date field value

This example shows how you can set the due date field on a work item.

```
import java.time.LocalDate

// Get a future date to set as the due date
def dueDate = LocalDate.now().plusDays(14)

WorkItems.getByKey('<WorkItemKeyHere>').update {
    setDueDate(dueDate)
    //You can also specify the date as a String parameter using this method and format:
    // setDueDate("2025-12-31")
}
```

## Set select list field value

This example shows how you can set the value of a single select list field on a work item.

```
// Specify the work item key to update
def workItemKey = 'WORK_ITEM_KEY'

// Specify the name of the select list field to set
def selectListFieldName = '<SelectListFieldNameHere>'

def workItem = WorkItems.getByKey(workItemKey)

workItem.update {
    setCustomFieldValue(selectListFieldName, '<OptionValueHere>')
}
```

## Set URL field value

This example shows how you can set the value of a custom URL field on a work item.

```
def workItemKey = '<WorkItemKeyHere>'

WorkItems.getByKey(workItemKey).update { 
    setCustomFieldValue('URL', 'https://www.adaptavist.com')
}
```

## Show work item counts for spaces based on JQL

The following example code highlights how to perform a JQL search to find all stories and group them into spaces to determine which spaces have the most stories, and displays them as a table.

```
import groovy.xml.MarkupBuilder

def mapping = WorkItems.search("issuetype = Story").countBy { workItem ->
    ((Map<String, Map>) workItem.fields).project.key
}

def writer = new StringWriter()
def builder = new MarkupBuilder(writer)
builder.table(class: "aui") {
    thead {
        tr {
            th("Space Key")
            th("Count")
        }
    }
    tbody {
        mapping.each { spaceKey, count ->
            tr {
                td {
                    b(spaceKey)
                }
                td(count)
            }
        }
    }
}

writer.toString()
```

As it is not possible to render returned HTML in Cloud (not permitted by Atlassian), you cannot display this data output as a html table. The script returns HTML that can be saved somewhere else to display the table.

## Transition a work item and add a comment

This example shows how you can transition a work item to a different status and add a comment to the work item whilst it is transitioned.

Note that you **cannot** skip or ignore Restrict Transitions and Validate Details when transitioning a work item, so if they are not met, then you need to allow the transition to pass.

```
WorkItems.getByKey('<WorkItemKeyHere>').transition('Done') {
    setComment("Work item moved to Done")
}
```

## Update a resolution on a work item

This example shows how you can update the resolution on a work item when it transitions between workflows.

```
WorkItems.getByKey("WORK_ITEM_KEY").transition('Done') {
    // Can set any resolutions used in your version of Jira
    setResolution('Duplicate')
}
```

## Update a work item

Another common task is to update a field of a work item. In this case, we set the summary to be a new summary.

```
WorkItems.getByKey("WORK_ITEM_KEY").update {
    setSummary("Updated by a script")
}
```
