# Send Custom Email

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, email, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-send-email-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-send-email-onPrem

## Overview

You can use this script to send a custom email in Jira.

## Example

I want to send an email when an issue transitions from In progress to Done to update the customer on their issue status. 
I can use this snippet inside a post-function script.

## Good to Know

* An outgoing mail server needs to be enabled.

## Script

```groovy
Mail.send {
    setTo('jdoe@mail.com', 'jsmith@mail.com')
    setSubject("Issue ${issue.id} has been updated")
    setBody("Issue has been transitioned to ${issue.status}.")
}
```

