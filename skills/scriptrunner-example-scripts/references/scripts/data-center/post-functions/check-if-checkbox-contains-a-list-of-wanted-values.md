# Check if Checkbox Contains a List of Wanted Values

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-checkbox-contains-list-wanted-values-onPrem
- Source: https://examples.scriptrunner.io/scripts/checkbox-contains-list-wanted-values-onPrem

## Overview

Detect when a checkbox field contains a given list of string values. If the condition is met, a wide range of actions
can be done, such as updating another custom field or clearing the checkbox fields values.

## Example

As a product manager, I have set up a list of acceptance criteria which must be completed before an issue can be
transitioned. I want to ensure all criteria checkboxes are reset after the issue transitions to a new status, ensuring
the tasks are repeated before the issue can transition again.

## Good to Know

* If the script is used as a post-function and is placed before the default "Update change history for an issue and
  store the issue in the database" Jira post-function, updating the issue is not required.
* If the issue needs updating, there are three ways to update it. See this
  [Jira Agile Article](https://community.atlassian.com/t5/Agile-articles/Three-ways-to-update-an-issue-in-Jira-Java-Api/ba-p/736585)
  for more information.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.customfields.option.LazyLoadedOption
import org.apache.log4j.Level

// Set log level
log.setLevel(Level.DEBUG)

final fieldName = 'CheckBoxA'
final wantedOptions = ['Yes', 'No']

def customFieldManager = ComponentAccessor.customFieldManager
def checkBoxFieldA = customFieldManager.customFieldObjects.find { it.name == fieldName }

// If checkbox field does not exist, it is not needed to continue
if (!checkBoxFieldA) {
    return
}

def checkBoxFieldAValue = issue.getCustomFieldValue(checkBoxFieldA)
// If checkbox does not contain values, it is not needed to continue
if (!(checkBoxFieldAValue in List)) {
    return
}

def selectedOptions = checkBoxFieldAValue?.collect { (it as LazyLoadedOption).value }
def containsAllWanted = selectedOptions.containsAll(wantedOptions)
log.debug("""
selected Options string list = $selectedOptions
Boolean check if contains wanted = $containsAllWanted
""")
if (containsAllWanted) {
    // Run the logic that you want to run when the checkbox fields contains all wanted values here
    // For example, all check box options that were selected can be cleared
    def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
    issue.setCustomFieldValue(checkBoxFieldA, null)
    // If you use this as a post-function and place it before the default "Update change history for an issue and store
    // the issue in the database" Jira post-function the following line is not needed.
    ComponentAccessor.issueManager.updateIssue(currentUser, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
}
```

