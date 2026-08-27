# Remove All Unused Issue Type Screen Schemes

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, manage, project
- Language: groovy
- Doc ID: example-dataCenter-remove-unused-issue-type-screen-schemes-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-unused-issue-type-screen-schemes-onPrem

## Overview

Remove unused issue type screen schemes across all projects on the instance.

## Example

I want to declutter my instance by removing obsolete issue type screen schemes and 
preserving those planned for future use. I can use this script to delete issue type 
screen schemes that have no associated project while retaining 
specified issue type screen scheme names.

## Description

#### Overview

Remove unused issue type screen schemes across all projects on the instance.

#### Example
I want to declutter my instance by removing obsolete issue type screen schemes and 
preserving those planned for future use. I can use this script to delete issue type 
screen schemes that have no associated project while retaining 
specified issue type screen scheme names.

## Script

```groovy
/*
We need issueTypeScreenSchemeManager to go through each scheme and check if it is assigned to the project.
If not, delete it.
*/

import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.canned.util.OutputFormatter

def issueTypeScreenSchemeManager = ComponentAccessor.getIssueTypeScreenSchemeManager()
def defaultIssueTypeScreenScheme = issueTypeScreenSchemeManager.defaultScheme

// Schemes in this list will be ignored when the script runs.
// Add the full name into the list to not delete it, even if it is unused.
// Adding a partial name (e.g. "TEST") will keep schemes that contain
// the partial name (e.g. the 2nd and 3rd schemes will be kept the example below).
// Useful if there is a naming convention in place
// in the instance for similar schemes.
def unusedSchemeNamesToIgnore = [
        'JRA: Software Development Issue Type Screen Scheme',
        'TEST: Software Development Issue Type Screen Scheme',
        'TESTTWO: Software Development Issue Type Screen Scheme']

def deletedIssueTypeScreenSchemes = []
def errorIssueTypeScreenSchemes = [:]

issueTypeScreenSchemeManager.issueTypeScreenSchemes.each {
    try {
        if (it == defaultIssueTypeScreenScheme || unusedSchemeNamesToIgnore.contains(it.name)) {
            // Do not delete the default scheme or a scheme for an excluded project
            return
        }

        if (it.projects.size() == 0) {
            // Remove any associations with screen schemes
            issueTypeScreenSchemeManager.removeIssueTypeSchemeEntities(it)

            // Remove the issue type screen scheme
            issueTypeScreenSchemeManager.removeIssueTypeScreenScheme(it)
            deletedIssueTypeScreenSchemes.add(it.name)
        }
    } catch (Exception e) {
        errorIssueTypeScreenSchemes.put(it.name, e.getMessage())
    }
}

OutputFormatter.markupBuilder {
    h2('Issue Type Screen Schemes Report')
    !deletedIssueTypeScreenSchemes && !errorIssueTypeScreenSchemes && p('No unused issue type screen schemes found')
    if (deletedIssueTypeScreenSchemes) {
        h3('Deleted Issue Type Screen Schemes:')
        ul {
            deletedIssueTypeScreenSchemes.each {
                li(it)
            }
        }
    }
    if (errorIssueTypeScreenSchemes) {
        h3('Errors:')
        table(class: 'aui') {
            thead {
                tr {
                    th('Issue Type Screen Scheme Name')
                    th('Error')
                }
            }
            tbody {
                errorIssueTypeScreenSchemes.each { screenScheme, error ->
                    tr {
                        td(screenScheme)
                        td(error)

                    }
                }
            }
        }
    }
}
```

