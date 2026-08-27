# Jira User Properties

- Platform: data-center
- Feature: script-console
- Tags: customise, workflow
- Language: groovy
- Doc ID: example-dataCenter-jira-user-properties-onPrem
- Source: https://examples.scriptrunner.io/scripts/jira-user-properties-onPrem

## Overview

Store and retrieve data specific to a user from the ScriptRunner *Script Console*, utilising Jira user properties.

## Example

As an administrator, I want to store more information about a particular user, for example, phone number. I can use
this script to add the phone number as a user property.

## Good to Know

* See 'Add a property to a user' section [in this article](https://confluence.atlassian.com/adminjiraserver/create-edit-or-remove-a-user-938847025.html)
  for more information.
* The 'key' can only contain alphanumeric characters.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// The user name of the user you want to store user properties in
final userName = "user"

// The key of the user property to set
final userPropertyKey = "jira.meta.favoritePlugin"

// The value of the user property
final userPropertyValue = "ScriptRunner"

def userPropertyManager = ComponentAccessor.userPropertyManager
def user = ComponentAccessor.userManager.getUserByName(userName)

assert user : "Could not find user with user name $userName"

// Set the user property
userPropertyManager.getPropertySet(user).setString(userPropertyKey, userPropertyValue)

// Get the user property
userPropertyManager.getPropertySet(user).getString(userPropertyKey)
```

