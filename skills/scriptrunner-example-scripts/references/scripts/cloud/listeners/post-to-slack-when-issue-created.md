# Post to slack when Issue Created

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-post-to-slack-when-issue-created-cloud
- Source: https://examples.scriptrunner.io/scripts/post-to-slack-when-issue-created-cloud

## Overview

Sends a notification to a specified Slack channel whenever a new Jira work item is created, including key details like 
work item key, summary, and description.

## Example

I am a project manager, and I want to keep my team informed about all newly created work items. I can use this script to 
automatically post a message to a Slack channel so the team stays updated on each work item’s creation and details.

## Good to Know

* The channel name must match an existing Slack channel your bot can post to.
* The script requires a Slack Bot Token with chat:write permission.

## Script

```groovy
// Specify the key of the work item to get the fields from
def workItemKey = issue.key

// Get the work item summary, and description
def workItemObj = WorkItems.getByKey(workItemKey)
def summary = workItemObj.getSummary()
def description = workItemObj.getDescription()

// Specify the name of the slack room to post to
def channelName = '<ChannelNameHere>'

// Specify the name of the user who will make the post
def username = '<UsernameHere>'

// Specify the message metadata
Map msg_meta = [ channel: channelName, username: username ,icon_emoji: ':rocket:']

// Specify the message body which is a simple string
Map msg_dets = [text: "A new work item was created with the details below: \n Work Item key = ${workItemKey} \n Work Item Summary = ${summary} \n Work Item Description = ${description}"]

// Post the constructed message to slack
def postToSlack = post('https://slack.com/api/chat.postMessage')
    .header('Content-Type', 'application/json')
    .header('Authorization', "Bearer ${SLACK_API_TOKEN}") // Store the API token as a script variable named SLACK_API_TOKEN
    .body(msg_meta + msg_dets)
    .asObject(Map)
    .body

assert postToSlack : "Failed to create Slack message check the logs tab for more details"
```

