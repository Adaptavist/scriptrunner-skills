# Add automated comment for every work item created inside a Jira Service Management Customer Portal.

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-add-comment-when-service-desk-issue-created-cloud
- Source: https://examples.scriptrunner.io/scripts/add-comment-when-service-desk-issue-created-cloud

## Overview

Add an automated comment with proper greeting and request information. And, also explain that the work item will be closed out if left inactive on all new work items created in Jira Service Management.

## Example

As a support agent, when a customer raises a ticket for laptop replacement, I want a first response that greet the customer properly with display name and office name. The office name is a value from single select list field.

The first response also include the delivery address, which is a text custom field, he has just filled.

Finally, All customers should also know what our SLA is when customers raise a new request as well as to know when their work item will automatically be closed if it is left inactive for a period of time.

## Good to Know

* This script needs to be configured on the *Create* transition in the workflow in *Jira Service Management* space. 
  *Note:* The perform actions rule must be ordered as the last perform actions rule in the list of perform actions rules to ensure the work item is created before it can be linked to. 

  * On line *1* of the script specify the comment text inside of the variable named *comment*. 

  * On line *18* set the public property to false if you do not want the comment to be visible in the *Customer Portal*.

## Script

```groovy
def comment = """
                Hi, ${issue.fields.reporter.displayName} from ${issue.fields.customfield_12818.value} office,

                Thank you for creating this ticket in our service desk. You have requested a laptop replacement delivered to following destination:

                ${issue.fields.customfield_12831}

                Please make sure the address is correct. We will respond to your request shortly.

                Kindly also note if the ticket remains inactive for a period of 10 days then will automatically be closed.
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

