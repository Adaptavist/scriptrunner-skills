# Add options to custom field

- Platform: cloud
- Feature: script-console
- Tags: fields
- Language: groovy
- Doc ID: example-cloud-add-options-to-custom-field-cloud
- Source: https://examples.scriptrunner.io/scripts/add-options-to-custom-field-cloud

## Overview

This script is to add one or more options to a custom field where a list of options is available, like a select multi list.

## Example

I have a multi-select list custom field with three options, e.g. "Team A", "Team B", "Team C".
By running this script on the script console, I can add more options e.g. "Team D", "Team E" etc.
After executing this script, the options of the custom field will then be "Team A", "Team B", "Team C", "Team D", "Team E" etc.

## Good to Know

This script will not overwrite the list of current options, but simply add the new provided ones to the existing ones.
This script works with custom fields that are options-based, such as: Select List (Single choice), Select List (Multiple choice), Select List (Cascading), Radio Buttons.

## Script

```groovy
import groovy.json.JsonOutput

def fieldId= "customfield_10083"  // Id of the custom field that needs new options
def contextId = "10193" // Context associated with the field

// List of option values to be added to the custom field
def optionValueList = ["1","2","3"]

// Payload with the options (for the POST request that will add them as field options)
optionValueList.each
        {
            def optionValue = it
            def optionPayload = [
                    options: [
                            [
                                    value: optionValue,
                                    disabled: false // Assuming the option should be enabled
                            ]
                    ]
            ]

// The POST request to add the option
def response = post("/rest/api/3/field/${fieldId}/context/${contextId}/option")
        .header("Content-Type", "application/json")
        .body(JsonOutput.toJson(optionPayload))
        .asString()
        }
```

