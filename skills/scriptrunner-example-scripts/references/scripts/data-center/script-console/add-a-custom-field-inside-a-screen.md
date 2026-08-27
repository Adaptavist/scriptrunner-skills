# Add a Custom Field inside a Screen

- Platform: data-center
- Feature: script-console
- Tags: manage
- Language: groovy
- Doc ID: example-dataCenter-add-a-custom-field-inside-a-screen-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-a-custom-field-inside-a-screen-onPrem

## Overview

This sample code enables a user to add a custom field inside a specific screen.

## Example

As a Jira administrator, I receive a lot of requests from users to add a custom field inside a screen.
This script saves me time and effort by automating the process of adding a custom field to a screen. It checks the 
specified screen to ensure that the custom field is not already on there to prevent duplication. Then, assuming that 
check comes back clear, it adds the requested custom field to the screen.

## Good to Know

* You can change 'customFieldName' and 'screenName' variable to your own.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def customFieldName = '<customfield_name>'
def screenName = '<screen_name>'

def customFieldId = ComponentAccessor.customFieldManager.getCustomFieldObjectsByName(customFieldName).find().id

def fieldscreenManager = ComponentAccessor.fieldScreenManager
def allscreen  = fieldscreenManager.fieldScreens
def screen = allscreen.findByName(screenName)
def tab = screen.getTab(0)

//Check if the Field already exists inside the screen if not proceed to add it inside the screen.
if ( tab.isContainsField(customFieldId) ) {
    "Field <b>'$customFieldName'</b> already added inside <b>'$screen.name'</b>"
} else {
    tab.addFieldScreenLayoutItem(customFieldId)
    "Field <b>'$customFieldName'</b> added inside <b>'$screen.name'</b>"
}
```

