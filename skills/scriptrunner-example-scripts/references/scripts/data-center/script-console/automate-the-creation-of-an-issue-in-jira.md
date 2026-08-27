# Automate the Creation of an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-create-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-issue-onPrem

## Overview

This script demonstrates how to create issues programmatically. You can use this script anywhere in Jira
that allows you to add a custom script e.g. listeners, workflow functions, REST Endpoints. You can either add this
as a standalone script or as part of a larger script to create some serious automation!

There are two examples here. The first creates an issue with minimal fields - the project, issue type, summary, 
and the reporter (which will be taken from the current user). By default, no other fields are required in Jira.

The second example demonstrates setting some additional fields.

## Example

I am a product manager, and I need to create several issues weekly for different departments.
For example, I need marketing to provide me with a weekly analytics report for live product campaigns.
Previously, I was having to spend time every week manually assigning these issues. However, with this script, I can
schedule the issues to be created automatically every week.

## Good to Know

* If you do not specify a value, it will take the default value, for example, default priority, or default custom field value.

## Script

```groovy
// By default this is all you need to specify
Issues.create('SR', 'Bug') {
    setSummary('Please help!')
}

// and an example setting more fields
Issues.create('SR', 'Task') {
    setSummary('Please help!')
    setDescription('a longer description')
    setPriority('High')
    setEnvironment('the environment')
    setComponents('Web', 'Database')
    setAffectedVersions('1.0')
    setOriginalEstimate('2d')

    // and custom field values
    setCustomFieldValue('TextFieldA', 'more text')
}
```

