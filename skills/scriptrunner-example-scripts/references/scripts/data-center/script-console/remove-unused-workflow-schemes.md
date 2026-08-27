# Remove Unused Workflow Schemes

- Platform: data-center
- Feature: script-console
- Tags: automate, user, workflow, administer
- Language: groovy
- Doc ID: example-dataCenter-remove-unused-workflow-schemes-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-unused-workflow-schemes-onPrem

## Overview

Remove all unused workflow schemes instead of doing it manually to save time searching through projects.

## Example

I want to de-clutter my instance by removing Workflow Schemes that are not used by any Project.
I can save time by using this script to get rid of these unused Workflow Schemes.

## Description

#### Overview

Remove all unused workflow schemes instead of doing it manually to save time searching through projects.

#### Example
I want to de-clutter my instance by removing Workflow Schemes that are not used by any Project.
I can save time by using this script to get rid of these unused Workflow Schemes.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.scheme.Scheme
import com.atlassian.jira.workflow.AssignableWorkflowScheme
import com.onresolve.scriptrunner.canned.util.OutputFormatter

// This script is based on https://confluence.atlassian.com/clean/advanced-cleanup-1018789335.html

def workflowSchemeManager = ComponentAccessor.getWorkflowSchemeManager()

// Keep a list of all deleted WorkFlowSchemes so we can report them later
List<AssignableWorkflowScheme> deletedSchemes = []

// Keep a list of all errors during deletion so we can report them later
List<Map<String, String>> deletionErrors = []

workflowSchemeManager.assignableSchemes.each { scheme ->
    try {
        def workflowSchemeIsUnlinked = workflowSchemeManager.getProjectsUsing(scheme).size() == 0

        if (workflowSchemeIsUnlinked) {
            workflowSchemeManager.deleteScheme(scheme.id)
            deletedSchemes.push(scheme)
        }
    } catch (Exception e) {
        deletionErrors.push([schemeName: scheme.name, errorMessage: e.message])
    }
}

// MarkupBuilder writes a HTML string to the output, making sure that any special characters in the
// scheme names (or error messages) are represented correctly in HTML.
OutputFormatter.markupBuilder {
    h2('Workflow Schemes Report')
    !deletedSchemes && !deletionErrors && p('No unused workflow schemes found')
    if (deletedSchemes) {
        h3('Deleted Unused Workflow Schemes:')
        ul {
            deletedSchemes.each { scheme ->
                li(scheme.name)
            }
        }
    }
    if (deletionErrors) {
        h3('Errors:')
        table(class: 'aui') {
            thead {
                tr {
                    th('Screen Scheme Name')
                    th('Error')
                }
            }
            tbody {
                deletionErrors.each { entry ->
                    tr {
                        td(entry.schemeName)
                        td(entry.errorMessage)
                    }
                }
            }
        }
    }
}
```

