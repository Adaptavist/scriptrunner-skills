# A script field that displays issues where the current issue is selected in Issue Picker fields

- Platform: data-center
- Feature: script-fields
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-show-incoming-issue-picker-fields-onPrem
- Source: https://examples.scriptrunner.io/scripts/show-incoming-issue-picker-fields-onPrem

## Overview

[Issue Pickers](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker)
  function similarly to links, however they are better suited when you want to:

* control the list of possible issues for selection. 
* avoid polluting your instance adding many link types for specialised use cases.
* show/hide or make required entering the "link" according to your worflow.

For example, you enforce that when users close an *Incident* they must select a *Problem* ticket, with the field being named _Root Cause_. 

A downside to using Issue Pickers is that you can't easily see on the *Problem* ticket all the *Incident* tickets that link to it.  
  
We have a JQL function named [issuePickerField](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links) 
that allows you to find the "incoming links" by attribute of the target.

For example, to find all *Incidents* that relate to open *Problem* tickets you could run the following query:

`issuePickerField('Issue Picker', 'issuetype = Problem and resolution is empty')`

Using this function, and a script field, we can show all the issues that reference the current issue in a particular Issue Picker field:

![Output example](https://gist.githubusercontent.com/jechlin-adaptavist/0a888a582946a3a2bf8351cb0a25eb65/raw/e1d041455b0356de3bdb3d028c18970eb489f4ab/Screenshot%2520from%25202022-02-21%252020-29-40.png)

## Good to Know

* Add a new Custom Scripted Field. Give it a descriptive name. In our example we call it _Causes Incidents_
* Change the template to *Issue(s)* as in the image below:
  ![Field setup](https://gist.githubusercontent.com/jechlin-adaptavist/0a888a582946a3a2bf8351cb0a25eb65/raw/e1d041455b0356de3bdb3d028c18970eb489f4ab/Screenshot%2520from%25202022-02-21%252020-23-28.png)
* Enter the script as either an inline script or file.
* Modify the name of the Issue Picker field in the script shown below.
* **NOTE** - do *not* add a searcher for this field - you cannot do a JQL search within a script field that also has a searcher. This causes timeouts doing a full reindex, as you would be trying to query the index when it is imcomplete.

## Description

#### Overview

[Issue Pickers](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker)
  function similarly to links, however they are better suited when you want to:

* control the list of possible issues for selection. 
* avoid polluting your instance adding many link types for specialised use cases.
* show/hide or make required entering the "link" according to your worflow.

For example, you enforce that when users close an *Incident* they must select a *Problem* ticket, with the field being named _Root Cause_. 

A downside to using Issue Pickers is that you can't easily see on the *Problem* ticket all the *Incident* tickets that link to it.  
  
We have a JQL function named [issuePickerField](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links) 
that allows you to find the "incoming links" by attribute of the target.

For example, to find all *Incidents* that relate to open *Problem* tickets you could run the following query:

`issuePickerField('Issue Picker', 'issuetype = Problem and resolution is empty')`

Using this function, and a script field, we can show all the issues that reference the current issue in a particular Issue Picker field:

![Output example](https://gist.githubusercontent.com/jechlin-adaptavist/0a888a582946a3a2bf8351cb0a25eb65/raw/e1d041455b0356de3bdb3d028c18970eb489f4ab/Screenshot%2520from%25202022-02-21%252020-29-40.png)

#### Good to Know
* Add a new Custom Scripted Field. Give it a descriptive name. In our example we call it _Causes Incidents_
* Change the template to *Issue(s)* as in the image below:
  ![Field setup](https://gist.githubusercontent.com/jechlin-adaptavist/0a888a582946a3a2bf8351cb0a25eb65/raw/e1d041455b0356de3bdb3d028c18970eb489f4ab/Screenshot%2520from%25202022-02-21%252020-23-28.png)
* Enter the script as either an inline script or file.
* Modify the name of the Issue Picker field in the script shown below.
* **NOTE** - do *not* add a searcher for this field - you cannot do a JQL search within a script field that also has a searcher. This causes timeouts doing a full reindex, as you would be trying to query the index when it is imcomplete.

## Script

```groovy
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.builder.JqlQueryBuilder
import com.atlassian.jira.web.bean.PagerFilter
import com.atlassian.query.operator.Operator

def searchService = ComponentAccessor.getComponent(SearchService)
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

// Modify the name of your issue picker field here
def issuePickerFieldName = 'Root Cause'

// This creates a query like: "issueFunction in issuePickerField('Root Cause', 'key = ${issue.key}')"
// You could also use JqlQueryParser.
def query = JqlQueryBuilder.newClauseBuilder().addFunctionCondition(
    'issueFunction',
    Operator.IN,
    'issuePickerField',
    issuePickerFieldName,
    "key = ${issue.key}"
).buildQuery()

def searchResults = searchService.search(loggedInUser, query, PagerFilter.getUnlimitedFilter())

searchResults.results ?: null
```

