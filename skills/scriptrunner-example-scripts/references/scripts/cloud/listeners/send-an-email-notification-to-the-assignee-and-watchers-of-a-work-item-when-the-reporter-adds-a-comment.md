# Send an email notification to the assignee and watchers of a work item when the reporter adds a comment.

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, user
- Language: groovy
- Doc ID: example-cloud-Notify-Assignee-And-Watchers-When_Reporter-Adds-A-Comment-cloud
- Source: https://examples.scriptrunner.io/scripts/Notify-Assignee-And-Watchers-When_Reporter-Adds-A-Comment-cloud

## Overview

Ensure the assignee and watchers are notified when the the reporter of a work item adds a comment to it.

## Example

As a product owner I need to ensure the assignee and watchers, know about all the updates reporters make to tickets to ensure important updates do not get missed.

## Good to Know

* This script should be configured to run as the *Add-On User* as the *notify* API from atlassian does not allow users to notify themselves. 
* This script should be configured to run on the *Comment Created* event.
* The email body can be formatted how you like it using *HTML* syntax to specify the formatting.

## Script

```groovy
// Get the reporter details as the work item property in the comment_created webhook only contains limited fields
def reporterDetails = get('/rest/api/2/issue/' + issue.key)
        .header('Content-Type', 'application/json')
        .asObject(Map)
        .body
        .fields
        .reporter

// Get the reporter accountId and displayName values
def reporterAccountId = reporterDetails.accountId
def reporterDisplayName = reporterDetails.displayName

// Get the commment authors accountId
def commentAuthorAccountId = comment.author.accountId

if (commentAuthorAccountId == reporterAccountId) {
    // Define the body of the notification using HTML to format it.
    def messageBody = "<p><b>${reporterDisplayName}</b> who is the reporter on the <b>${workItem.key}</b> ticket has updated the work item.<p> <br/> <p> Please go and review the updates on the ticket.</p>"

    // Send the email notification
    def sendNotification = post("/rest/api/2/issue/${issue.key}/notify")
            .header("Content-Type", "application/json")
            .body([
                    subject : "The reporter has updated the ${issue.key} issue",
                    htmlBody: messageBody,
                    to      : [
                            assignee: issue.fields.assignee != null,
                            watchers: true,
                    ]
            ])
            .asString()

    assert sendNotification.status == 204
}
```

