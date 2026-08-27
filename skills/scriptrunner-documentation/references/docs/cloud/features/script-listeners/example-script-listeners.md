# Example Script Listeners

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-listeners
- Doc ID: doc-sr4jc-459571685
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/example-script-listeners

Condition script examples

The condition script will be evaluated before your code is executed. In the case where a value **other than true** is returned then we get a **false** result, and the code will **not** execute. The condition is evaluated using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/software/jira-expressions/?_ga=2.230038236.1976807474.1684141123-2016015256.1672998146#introduction).

You can refer to our [Example Restrictions and Validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators) page for further details.

### Add a comment on work created

If you have a support space, you might want to respond to newly created work with a canned response. This script adds a comment to each new work item in a particular space.

```
def eventIssue = Issues.getByKey(issue.key as String)

def author = eventIssue.getCreator().displayName
eventIssue.addComment("""Thank you ${author} for creating a support request.
We'll respond to your query within 24hrs.
In the meantime, please read our documentation: http://example.com/documentation""")
```

### Adds the current user as a watcher

```
final issueKey = issue.key
def currentUser = Users.getLoggedInUser()

def watcherResp = post("/rest/api/2/issue/${issueKey}/watchers")
    .header('Content-Type', 'application/json')
    .body("\"${currentUser.accountId}\"")
    .asObject(List)

if (watcherResp.status == 204) {
    logger.info("Successfully added ${currentUser.displayName} as watcher of ${issueKey}")
} else {
    logger.error("Error adding watcher: ${watcherResp.body}")
}
```

### Calculate custom field on work item update

Currently in Jira Cloud calculating a custom field is not possible, but we can update a field in response to an `IssueUpdated` event, creating a simple calculated custom field. 

For example, say a space has three custom fields: _Cost_, _Shipping Cost_, and _Total Cost_. These fields are available for all work types. When an work itemor sub-task is created, the values of the _Cost_ and _Shipping Cost_ fields can be defined, however, the _Total Cost_ field is not automatically calculated as calculated custom fields are not available in Jira Cloud. Using the script example below you can trigger a calculation when the work item is updated, so you can sum the _Cost_ and _Shipping Cost_ for the _Total Cost_ field.

Remember that:

-   The code in the example below is designed to be used with the `Updated` event.
-   If using the add-on user to run the script, it is possible to set the `overrideScreenSecurity` property to modify fields that are not on the current screen.

```
def eventIssue = Issues.getByKey(issue.key as String)

final projectKey = 'TEST'

if (eventIssue.projectObject.key != projectKey) {
    logger.info("Wrong Project ${eventIssue.projectObject.key}")
    return
}

//get the value of each of the custom fields or use 0 as default if a value isn't set yet
def input1 = eventIssue.getCustomFieldValue("Custom Field 1") as Integer ?: 0
def input2 = eventIssue.getCustomFieldValue("Custom Field 2") as Integer ?: 0

def output = input1 + input2

//do not attempt to update the result if it is the same as the existing one.
if(eventIssue.getCustomFieldValue("Output Custom Field") == output) {
    logger.info("The reulst was the same as the existing one, no update needed.")
} else {
    eventIssue.update {
        setCustomFieldValue("Output Custom Field", output)
    }
    logger.info("Output Custom Field updated to ${output}")
}
```

Whereas the example code above relates to calculating the sum of multiple fields when a work item is updated, we recommend using the example code below to extract the value of a custom field for a work item using the custom field name. It's also useful for clearing the value of a custom field using the custom field name. 

The following example script can be used in various contexts where you need to access a work item's custom field values, or if you need to remove a value. You can also use it for scripting tasks in Jira where you need to manipulate or report on custom field data.

```
def eventIssue = Issues.getByKey(issue.key as String)
def expectedValue = 'some value you expect to see in the custom field'

//get custom field value
def value = eventIssue.getCustomFieldValue('customFieldName')

//clear custom field value
if(value != expectedValue) {
    eventIssue.update {
        eventIssue.clearCustomFieldValue('customFieldName')
    }
}
```

You can see from the example that you need to access the value of the select field via result.body.fields\[customFieldName\].value to be used in further computations.

### Create work on space creation

The Script Listener events must be associated with space-related actions, such as _Space Created_, _Space Updated_, or _Space Deleted_. This allows for seamless integration with space management workflows, ensuring that tasks are created in response to relevant space changes.

The following code example demonstrates how to create work items of the type "Task" in Jira. It automates the creation of work, ensuring tasks are generated based on specific triggers.

```
def projectKey = project.key as String

// create two issues
Issues.create(projectKey, 'Task') {
    summary = "Create Confluence space associated to the project"
    description = "Don't forget to do this!."
}
Issues.create(projectKey, 'Task') {
    summary = "Bootstrap connect add-on"
    description = "Some other task"
}
```

### Email notify on priority change

The following example code demonstrates how to send notifications to users when the priority of a work item is changed in Jira. This ensures that all relevant stakeholders are promptly informed of critical updates to work priority.

There is a known Jira bug that can cause a 500 error if the work item lacks a reporter or assignee. To prevent this, the script includes checks for these fields, ensuring that notifications are only sent to valid recipients, avoiding disruptions in your workflow.

The notify API, which this script uses, contains a validation rule that prevents users from notifying themselves.   
However, you may make a change in the _Notification settings_ section of the Jira _Personal settings_ options in order to receive notifications for personally executed changes to work items.  
You'll find the **You make changes to work items** checkbox option in the _Send me emails for work item activity_ section of the _Notifications for spaces and work items_ settings page.  
![](/sr4jc/files/latest/459571685/513345192/1/1771352748000/get-notfified-about-your-changes-to-work-items.png)

```
import groovy.xml.MarkupBuilder
import groovy.xml.XmlSlurper

def eventIssue = Issues.getByKey(issue.key as String)

Map priorityChange = changelog?.items.find { eventIssue.priority } as Map
if (!priorityChange) {
    logger.info("Priority was not updated")
    return;
}

def fromPriority = priorityChange.fromString as String
def toPriority = priorityChange.toString as String

logger.info("Priority changed from ${fromPriority} to ${toPriority}")

if (toPriority == "Highest") {
    def writer = new StringWriter()
    // Note that markup builder will result in static type errors as it is dynamically typed.
    // These can be safely ignored
    def markupBuilder = new MarkupBuilder(writer)
    markupBuilder.div {
        p {
            // update url below:
            a(href: "http://myjira.atlassian.net/issue/${issue.key}", issue.key)
            span(" has had priority changed from ${fromPriority} to ${toPriority}")
        }
        p("You're important so we thought you should know")
    }
    def htmlMessage = writer.toString()
    def textMessage = new XmlSlurper().parseText(htmlMessage).text()

    logger.info("Sending email notification for issue {}", issue.key)

    def recipients = [:]

    if (eventIssue.reporter != null) {
        recipients.reporter = true
    }
    if (eventIssue.assignee != null) {
        recipients.assignee = true
    }
    if (eventIssue.watches != null && eventIssue.votes != null) {
        recipients.watches = true
        recipients.votes = true
    }
    // If no recipients were added, log a message
    if (recipients.isEmpty()) {
        logger.info("No valid recipients found for issue {}", issue.key)
        return
    }
    // Add users/groups to ensure at least one recipient
    recipients.users = [[name: 'admin']]
    recipients.groups = [[name: 'jira-administrators']]

    def resp = post("/rest/api/2/issue/${issue.id}/notify")
            .header("Content-Type", "application/json")
            .body([
                    subject: 'Priority Increased',
                    textBody: textMessage,
                    htmlBody: htmlMessage,
                    to: recipients
            ])
            .asString()

    assert resp.status == 204
}
```

**Line 17:** Only do anything here if the priority change was to Highest.

**Line 21:** Generate a HTML message using `MarkupBuilder`

**Line 24:** The issue URL here is created manually. It should be updated.

**Line 31:** Quick hack to produce a text-only message from the HTML string.

**Line 56:** Post to the Notify endpoint. Note that there is a Jira bug where a missing reporter or assignee will cause a 500 error. The example here is of sending the message to the reporter and assignee, any watchers and voters, as well as a user and group list.

### Populate a user picker field from a text field

The example code below shows how you can create a field that is populated with users. Specifically, when creating a work item for the Jira Service Desk, you can specify a user in the description, so this then populates in the user picker field.

```
import java.util.regex.Matcher;
import java.util.regex.Pattern;
def eventIssue = Issues.getByKey(issue.key as String)
def descriptionVal = eventIssue.getDescription()

// Define the regular expression pattern used to find the user in the description text
def regex = '(?<=The owner of this ticket is:).*';
Pattern pattern = Pattern.compile(regex);
Matcher matcher = pattern.matcher(descriptionVal);

// Extract the name of the user after the text The owner of this ticket is:
if(matcher.find()){
def user = matcher.group(0)

// Find the user details for the user matched from the description
def userSearchRequest = get("/rest/api/3/user/search")
.queryString("query", user)
.asObject(List)

// Assert that the API call to the user search API returned a success response
assert userSearchRequest.status == 200

// Get the accountId for the user returned by the search
def userAccountId = userSearchRequest.body.accountId[0]

eventIssue.update { 
setCustomFieldValue("User Picker", userAccountId) // Change to name of your field here
 }
}
```

**Line 13:** Note that the username is picked up after the text **'**_The owner of this ticket is:_**'**, however, if required you can change this text to something more suitable.

### Post to Slack when work item created

Add this listener to the _Issue Created_ event type to post a notification to Slack when a work item is created.

```
// Specify the key of the work item to get the fields from
def issueKey = issue.key

// Get the work item summary, and description
def issueObj = Issues.getByKey(issueKey)
def summary = issueObj.getSummary()
def description = issueObj.getDescription()

// Specify the name of the slack room to post to
def channelName = '<ChannelNameHere>'

// Specify the name of the user who will make the post
def username = '<UsernameHere>'

// Specify the message metadata
Map msg_meta = [ channel: channelName, username: username ,icon_emoji: ':rocket:']

// Specify the message body which is a simple string
Map msg_dets = [text: "A new issue was created with the details below: \n Issue key = ${issueKey} \n Issue Summary = ${summary} \n Issue Description = ${description}"]

// Post the constructed message to slack
def postToSlack = post('https://slack.com/api/chat.postMessage')
    .header('Content-Type', 'application/json')
    .header('Authorization', "Bearer ${SLACK_API_TOKEN}") // Store the API token as a script variable named SLACK_API_TOKEN
    .body(msg_meta + msg_dets)
    .asObject(Map)
    .body

assert postToSlack : "Failed to create Slack message check the logs tab for more details"
```

### Store sub-task estimates in parent work item on work item events

When a sub-task is created, updated, or deleted, you might want to update the parent work item with some information. This example stores the sum of the estimated fields from each sub-task in their parent work item.

```
def eventIssue = Issues.getByKey(issue.key as String)

def parent = eventIssue.parentObject
def subtasks = parent.subtasks
logger.info("Total subtasks for ${parent.key}: ${subtasks.size()}")

// Sum the estimates
def estimate = subtasks.sum { subtask ->
    subtask.getCustomFieldValue('Time Estimate') ?: 0
}
logger.info("Summed estimate: ${estimate}")

parent.update {
    setCustomFieldValue('Summed Subtask Estimate', estimate)
}
```

### Store the number of sub-tasks in the parent

Similar to the example above, you might want to store the number of sub-tasks in the parent work item when a sub-task is created, updated, or deleted.

```
def eventIssue = Issues.getByKey(issue.key as String)

def issueToUpdate = eventIssue.issueType.subtask ? eventIssue.parentObject : eventIssue

def subTasks= issueToUpdate.getSubTaskObjects()
def subTaskCount = subTasks.size()


if(subTaskCount != issueToUpdate.getCustomFieldValue("Subtasks Count")) {
    println("Total subtasks for ${issueToUpdate.key}: ${subTaskCount}")
    issueToUpdate.update {
        setCustomFieldValue("Subtasks Count", subTaskCount)
    }
}
```
