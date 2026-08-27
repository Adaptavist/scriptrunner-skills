# Update the Value of Custom Fields through the Script Console in Jira Cloud

- Platform: cloud
- Feature: script-console
- Tags: administer, fields
- Language: groovy
- Doc ID: example-cloud-basics-updating-customfields-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/basics-updating-customfields-cloud-cloud

## Overview

Bulk update the values of a custom field, saving time manually editing a work item.

## Example

I am a project manager, and I have realised that there is a mistake in some of my custom fields.
I want to automatically update my Summary custom field value to New Summary. I can use this snippet as part of a
larger script to automate this process.

## Good to Know

* Field types include *select lists*, *space pickers*, *user pickers*, *checkboxes*, *radio buttons*, etc.

## Script

```groovy
final customfieldID = 'customfield_1000' //get this from /fields api
final newFieldValue = 'New Value'
final workItemKey = 'MY_SPACE_1'

put("/rest/api/2/issue/${workItemKey}")
    .header('Content-Type', 'application/json')
    .body([
        fields: [
            (customfieldID): newFieldValue
        ]
    ]).asString()
```

