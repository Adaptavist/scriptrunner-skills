# Update Scripted Field with E-mail from Last Commenter on an Issue

- Platform: data-center
- Feature: script-fields
- Tags: automate, customise, issue, user
- Language: groovy
- Doc ID: example-dataCenter-update-scripted-field-with-email-from-last-commenter-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-scripted-field-with-email-from-last-commenter-onPrem

## Overview

This script displays the e-mail address from the last commenter on an issue in a script field.

## Example

As a Jira Admin, I want a Scripted Field that automatically sets the field value "Contact for more information" 
to the email of the last commenter on an Issue, to avoid spending time navigating the comment history and make sure
I always work with up-to-date contact information.

## Good to Know

* Use `Text Field (Multi-line)` as the template for the custom script field and 'Free Text Searcher' as the searcher.

## Script

```groovy
def comments = issue.comments
if (comments) {
    comments.last().authorApplicationUser?.emailAddress
}
```

