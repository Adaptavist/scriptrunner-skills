# Bulk Update the Value of a Fields

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-update-cf-values-all-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-cf-values-all-issues-onPrem

## Overview

Use these examples to update the values of fields, for all issues returned by a query.
Two examples are given, one which sets the value of a text custom field, the other that replaces a word within the **description** with another.

## Example

I have renamed my product, I would like to bulk update issues to reflect the new name.

## Description

#### Overview

Use these examples to update the values of fields, for all issues returned by a query.
Two examples are given, one which sets the value of a text custom field, the other that replaces a word within the **description** with another.

#### Example

I have renamed my product, I would like to bulk update issues to reflect the new name.

## Script

```groovy
// This example finds all instances where TextFieldA contains the word Marathon, and sets the value to Snickers
Issues.search('project = SR and TextFieldA ~ Marathon').each { issue ->
    issue.update {
        setCustomFieldValue('TextFieldA', 'Snickers')
    }
}

// This example finds all issues where the description contains Marathon, and *replaces* that word with Snickers
Issues.search('project = SR and description ~ Marathon').each { issue ->
    issue.update {
        setDescription {
            replace('Marathon', 'Snickers')
        }
    }
}

// This example finds all issues where the description contains Snickers and set the component field to Confectionery
Issues.search('project = SR and description ~ Snickers').each { issue ->
    issue.update {
        setComponents('Confectionery')
    }
}
```

