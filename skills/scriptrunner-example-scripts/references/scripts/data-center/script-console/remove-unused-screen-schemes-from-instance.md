# Remove Unused Screen Schemes from Instance

- Platform: data-center
- Feature: script-console
- Tags: automate, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-remove-unused-screen-schemes-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-unused-screen-schemes-onPrem

## Overview

Remove all unused screen schemes instead of doing it manually to save time searching through projects.

## Example

I want to declutter my instance by removing Screen Schemes that have no
associated Issue Type Screen Scheme. Instead of doing this manually,
I can save time by using this script to get rid of these unused
Screen Schemes.

## Description

#### Overview

Remove all unused screen schemes instead of doing it manually to save time searching through projects.

#### Example
I want to declutter my instance by removing Screen Schemes that have no
associated Issue Type Screen Scheme. Instead of doing this manually,
I can save time by using this script to get rid of these unused
Screen Schemes.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.canned.util.OutputFormatter

def fieldScreenSchemeManager = ComponentAccessor.getFieldScreenSchemeManager()
def issueTypeScreenSchemeManager = ComponentAccessor.getIssueTypeScreenSchemeManager()

def deletedScreenSchemes = []
def errorScreenSchemes = [:]

fieldScreenSchemeManager.getFieldScreenSchemes().each { fieldScreenScheme ->
    try {
        def issueTypeScreenSchemeCollection = issueTypeScreenSchemeManager.getIssueTypeScreenSchemes(fieldScreenScheme)

        // Screen Scheme is classed as unused if it has no associated issue type screen schemes
        def isUnusedScreenScheme = issueTypeScreenSchemeCollection.isEmpty()

        if (isUnusedScreenScheme) {
            // Remove association to any screens
            fieldScreenSchemeManager.removeFieldSchemeItems(fieldScreenScheme)
            // Remove field screen scheme
            fieldScreenSchemeManager.removeFieldScreenScheme(fieldScreenScheme)
            deletedScreenSchemes.add(fieldScreenScheme.name)
        }
    } catch (Exception e) {
        errorScreenSchemes.put(fieldScreenScheme.name, e.getMessage())
    }
}

OutputFormatter.markupBuilder {
    h2('Screen Schemes Report')
    !deletedScreenSchemes && !errorScreenSchemes && p('No unused screen schemes found')
    if (deletedScreenSchemes) {
        h3('Deleted Screen Schemes:')
        ul {
            deletedScreenSchemes.each {
                li(it)
            }
        }
    }
    if (errorScreenSchemes) {
        h3('Errors:')
        table(class: 'aui') {
            thead {
                tr {
                    th('Screen Scheme Name')
                    th('Error')
                }
            }
            tbody {
                errorScreenSchemes.each { screenScheme, error ->
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

