# Send Custom Notification to Slack

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, workflow, email
- Language: groovy
- Doc ID: example-dataCenter-send-notification-to-slack-onPrem
- Source: https://examples.scriptrunner.io/scripts/send-notification-to-slack-onPrem

## Overview

Add custom slack notifications on a workflow post function, or as a custom listener after an issue event.
Configure the message content and direct the message to a room or specific user.

## Example

As a project manager, I want to keep track of all changes to my watched issues.
I can use this script to send me a slack notification when one of my watched issues is transitioned.

## Good to Know

* A <a href="https://api.slack.com/incoming-webhooks">slack incoming webhook</a> is required to use this code.
* Visit the following link for information on adding and modifying formatting: https://api.slack.com/incoming-webhooks#advanced_message_formatting
* We are using the last version of Slack Web Api (5.12.0) at the moment of writing this document. Check the last version of the API visiting: https://slack.dev/node-slack-sdk/changelog

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import groovyx.net.http.ContentType
import groovyx.net.http.RESTClient
import groovyx.net.http.HttpResponseDecorator

// You have to create a webhook first:
// https://api.slack.com/messaging/webhooks#posting_with_webhooks
// Your webhook is related to one channel or user to which you will be able to send messages
// Once you have your webhook, split it into it's base URL and it's URL path
final webhookBase = 'https://hooks.slack.com'
final webhookPath = '/services/XYZ/XYZ/XYZ'

def jiraBaseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)
// We have to convert this GString into String explicitly here
def message = "New issue created in project $issue.projectObject.name : <https://$jiraBaseUrl/browse/$issue.key|$issue.key>" as String

def body = [
    text       : message,
    attachments: [
        [
            color : '#f2c744',
            blocks: [
                [
                    type  : 'section',
                    fields: [
                        [
                            type: 'mrkdwn',
                            text: "*Summary*\n$issue.summary" as String
                        ],
                        [
                            type: 'mrkdwn',
                            text: "*Reporter*\n$issue.reporter.displayName" as String
                        ],
                        [
                            type: 'mrkdwn',
                            text: "*Description*\n$issue.description" as String
                        ]
                    ]
                ]
            ]
        ]
    ]
]

def response = new RESTClient(webhookBase).post(
    path: webhookPath,
    contentType: ContentType.HTML,
    body: body,
    requestContentType: ContentType.JSON
) as HttpResponseDecorator

assert response.status == 200: "Request failed with status $response.status. $response.entity.content.text"
```

