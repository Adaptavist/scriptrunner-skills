# Set a default description when a work item is created

- Platform: cloud
- Feature: behaviours
- Tags: customise, issue, fields
- Language: typescript
- Doc ID: example-cloud-set-default-description-upon-issue-creation-cloud
- Source: https://examples.scriptrunner.io/scripts/set-default-description-upon-issue-creation-cloud

## Overview

This example allows you to set default text in the description field when a work item is created, ensuring the field is only updated when it has no value in it.

## Example

Ensure that all tickets follow a standard structure for defining requirements.

## Good to Know

This example only works when the description field has no content in it, as the if statement on line *7* prevents the Description field from being updated if it already has a value. 

The markup used to specify the description is *Atlassian Document Format* and the [Atlassian Document Format Builder](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) can be used to generate the markup required.

## Script

```typescript
const descriptionValue = getFieldById("description").getValue();

// Check if the description field is a wiki markup type field
if (typeof descriptionValue !== "string") {
    const descriptionValueContent = descriptionValue.content.toString();

    // Only set the field if it does not already have a value
    if (!descriptionValueContent) {

        getFieldById("description").setValue({
            "version": 1,
            "type": "doc",
            "content": [
                {
                    "type": "paragraph",
                    "content": [
                        {
                            "type": "text",
                            "text": "As a ",
                            "marks": [
                                {
                                    "type": "strong"
                                }
                            ]
                        },
                        {
                            "type": "text",
                            "text": "<type of user>"
                        }
                    ]
                },
                {
                    "type": "paragraph",
                    "content": [
                        {
                            "type": "text",
                            "text": "I want ",
                            "marks": [
                                {
                                    "type": "strong"
                                }
                            ]
                        },
                        {
                            "type": "text",
                            "text": "<to achieve some goal>"
                        }
                    ]
                },
                {
                    "type": "paragraph",
                    "content": [
                        {
                            "type": "text",
                            "text": "So that ",
                            "marks": [
                                {
                                    "type": "strong"
                                }
                            ]
                        },
                        {
                            "type": "text",
                            "text": "<some reason is fulfilled>"
                        }
                    ]
                }
            ]
        })
    }
}
// Set default description upon work item creation
```

