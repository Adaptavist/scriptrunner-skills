# Get the Request Type Name in an Issue Event Listener or Workflow Function

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-get-sd-requesttype-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-sd-requesttype-onPrem

## Overview

This script retrieves the request type name in an event listener or workflow function.

## Example

I need to do something in an "issue" event listener or workflow function, depending on the request type name. Note that there is
not a one-to-one mapping between issue type name and request type name, so we need to use the following code rather
than look it up from the issue type name.

## Good to Know

* Associate this script with an issue listener, such as "Issue Created" or "Issue Updated".
* For a workflow function, the `issue` object is already passed in the binding, so remove the line `def issue = event.issue`.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.servicedesk.api.requesttype.RequestTypeService
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.atlassian.servicedesk.internal.customfields.origin.VpOrigin
import com.atlassian.servicedesk.internal.feature.customer.request.requesttype.CachedImmutableRequestTypeImpl

@WithPlugin("com.atlassian.servicedesk")

@PluginModule
RequestTypeService requestTypeService

def issue = event.issue
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def customFieldManager = ComponentAccessor.customFieldManager

def requestTypeCustomField = customFieldManager.getCustomFieldObjects(issue).findByName('Customer Request Type')
def requestTypeKey = (issue.getCustomFieldValue(requestTypeCustomField) as VpOrigin)?.requestTypeKey

if (!requestTypeKey) {
    return
}

def query = requestTypeService.newQueryBuilder().issue(issue.id).build()
def requestType = requestTypeService.getRequestTypes(currentUser, query).results.find {
    (it as CachedImmutableRequestTypeImpl).key == requestTypeKey
}

def requestTypeName = requestType.name // requestTypeName contains the name of the request type
requestTypeName
```

