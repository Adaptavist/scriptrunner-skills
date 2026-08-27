# Remove Unused Screens

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-remove-unused-screens-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-unused-screens-onPrem

## Overview

Use this script to remove all screens that are currently unused.

## Example

As a Jira Administrator I want to de-clutter my instance by removing
any unused screens. Using this script I can automatically find and
delete all screens that do not have an association with a screen
scheme or workflow.

## Description

#### Overview

Use this script to remove all screens that are currently unused.

#### Example

As a Jira Administrator I want to de-clutter my instance by removing
any unused screens. Using this script I can automatically find and
delete all screens that do not have an association with a screen
scheme or workflow.

## Script

```groovy
import com.atlassian.webresource.api.assembler.PageBuilderService
import com.atlassian.jira.bc.issue.fields.screen.FieldScreenService
import com.atlassian.jira.issue.fields.screen.FieldScreenFactory
import com.atlassian.jira.web.action.admin.issuefields.screens.ViewFieldScreens
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.canned.util.OutputFormatter

def fieldScreenManager = ComponentAccessor.getFieldScreenManager()
def fieldScreenFactory = ComponentAccessor.getComponent(FieldScreenFactory)
def fieldScreenSchemeManager = ComponentAccessor.getFieldScreenSchemeManager()
def fieldScreenService = ComponentAccessor.getComponent(FieldScreenService)
def workflowManager = ComponentAccessor.getWorkflowManager()
def jiraAuthenticationContext = ComponentAccessor.getJiraAuthenticationContext()
def pageBuilderService = ComponentAccessor.getComponent(PageBuilderService)

def deletedScreens = []
def errorScreens = [:]

def viewFieldScreens = new ViewFieldScreens(fieldScreenManager,
        fieldScreenFactory,
        fieldScreenSchemeManager,
        fieldScreenService,
        workflowManager,
        jiraAuthenticationContext,
        pageBuilderService)

fieldScreenManager.getFieldScreens().each { fieldScreen ->
    try {
        def screenSchemesIsEmpty = viewFieldScreens.getFieldScreenSchemes(fieldScreen).isEmpty()
        def workflowsIsEmpty = viewFieldScreens.getWorkflows(fieldScreen).isEmpty()

        if (screenSchemesIsEmpty && workflowsIsEmpty) {
            fieldScreenManager.removeFieldScreen(fieldScreen.getId())
            deletedScreens.add(fieldScreen.name)
        }
    } catch (Exception e) {
        errorScreens.put(fieldScreen.name, e.getMessage())
    }
}

OutputFormatter.markupBuilder {
    h2('Screens Report')
    !deletedScreens && !errorScreens && p('No unused screens found')
    if (deletedScreens) {
        h3('Deleted Screens:')
        ul {
            deletedScreens.each {
                li(it)
            }
        }
    }
    if (errorScreens) {
        h3('Errors:')
        table(class: 'aui') {
            thead {
                tr {
                    th('Screen Name')
                    th('Error')
                }
            }
            tbody {
                errorScreens.each { screen, error ->
                    tr {
                        td(screen)
                        td(error)
                    }
                }
            }
        }
    }
}
```

