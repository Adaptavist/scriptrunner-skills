# Show the number of Linked Test Cases from the Issue

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-show-number-linked-testcases-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/show-number-linked-testcases-field-onPrem

## Overview

Add a field that shows the number of test cases linked to an issue.

## Example

I work in the QA team and would like to see the number of linked test cases for a given issue, allowing me to
quickly see how many tests are related to an issue and filter by this.

## Good to Know

* Use 'Number Field' as the template for the custom script field.

## Script

```groovy
import com.adaptavist.tm4j.api.service.common.ServiceResult
import com.adaptavist.tm4j.api.service.tracelink.TraceLinkService
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin('com.kanoah.test-manager')
final userKey = 'someUserKey'

def traceLinkService = ComponentAccessor.getOSGiComponentInstanceOfType(TraceLinkService)

ServiceResult result = traceLinkService.getTestCaseTraceLinkCountByIssueId(userKey, issue.id)

result.valid ? result.result : 0
```

