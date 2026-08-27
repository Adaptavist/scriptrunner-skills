# Update the Labels for an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-labels-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-labels-onPrem

## Overview

You can use labels to help with categorising or searching for issues.
For example, you may want to apply the label **accounting** to all issues related to accounting and financing. Use this snippet to automate adding labels to issues.

## Description

#### Overview
You can use labels to help with categorising or searching for issues.
For example, you may want to apply the label **accounting** to all issues related to accounting and financing. Use this snippet to automate adding labels to issues.

## Script

```groovy
// you can set labels on creation/transition
def issue = Issues.create('SR', 'Task') {
    setSummary('Help me!')
    setLabels('first-label', 'second-label')
}

// you can *add* labels like this (using the syntax above would overwrite all labels)
issue = issue.update {
    setLabels {
        add('my-label')
    }
}

// you can also *remove* or *replace* labels
issue.update {
    setLabels {
        remove('first-label')
        replace('some-label', 'another-label')
    }
}
```

