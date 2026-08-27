# Add Label To Work Item with Escalation Service

- Platform: cloud
- Feature: escalation-services
- Tags: hapi, issue
- Language: groovy
- Doc ID: example-cloud-add-label-to-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/add-label-to-issue-cloud

## Overview

With this script you can add a label to all work items matching the escalation service JQL query.

## Example

I want to add a label to every work item matching my JQL query in Escalation Service.
I can use this snippet to achieve that.

## Description

#### Overview
With this script you can add a label to all work items matching the escalation service JQL query.

#### Example
I want to add a label to every work item matching my JQL query in Escalation Service.
I can use this snippet to achieve that.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
// you can *add* a label to existing labels
currentWorkItem.update {
    setLabels {
        add('MY_LABEL_1')
    }
}

// *OR* you can set multiple labels at once (this syntax overwrites all labels)
currentWorkItem.update {
    setLabels('MY_LABEL_1', 'MY_LABEL_2')
}

// you can *remove* or *replace* labels
currentWorkItem.update {
    setLabels {
        remove('MY_LABEL_1')
        replace('MY_LABEL_2', 'MY_LABEL_3')
    }
}
```

