# Set Behaviour Hidden

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-basics-behaviours-set-hidden-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-behaviours-set-hidden-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue *Create* or *Update* screens.
Using this script, you can set a field as hidden on these screens, so the user cannot see it.

## Example

As an admin, I want to hidden a field temporarily so users can't see it for a specified time.
I use this script to make the field hidden for a set time, after which it is visible again.

## Good to Know

* Set up this script as an initialiser.
* As an example, the script set makes two fields hidden: the default "Description" field and a custom field with name "TextField".
* You can use this script as part of a larger script to hide fields based on additional conditions.

## Script

```groovy
import com.atlassian.jira.issue.IssueFieldConstants
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

final String fieldName = 'TextField'

// get field by name and hide it
getFieldByName(fieldName).setHidden(true)

// get a filed by id and hide it
getFieldById(IssueFieldConstants.DESCRIPTION).setHidden(true)
```

