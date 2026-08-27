# Get Email Address of Approvers

- Platform: data-center
- Feature: rest-endpoints
- Tags: issue, email, project
- Language: groovy
- Doc ID: example-dataCenter-get-email-address-of-approvers-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-email-address-of-approvers-onPrem

## Overview

When the details of the approvers of an issue on a Service Desk are required, a REST Endpoint request is made to
retrieve the details.

## Example

In this example, only the email addresses of the approvers who have not yet approved the ticket are included.
The information from this REST Endpoint is invoked by the [Scheduled Job](https://library.adaptavist.com/entity/notify-approvers-of-pending-approvals-via-email)
and triggers the reminder email.

## Good to Know

* When invoking the REST Endpoint, ensure the issue key is included. For example:
`http://<JIRA base URL>/rest/scriptrunner/latest/custom/getApprovers?issueKey=<IssueKey>`
* If the issue key is not included when the REST Endpoint is invoked, a runtime exception will be returned. For example:
`http://<JIRA base URL>/rest/scriptrunner/latest/custom/getApprovers`
* The service project request type (for example, Report a Bug) has to be selected for the ticket to be accessible.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient
import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate
getApprovers { MultivaluedMap queryParams, body, HttpServletRequest request ->
    def issueKey = queryParams.getFirst('issueKey')

    def applicationProperties = ComponentAccessor.applicationProperties

    final def baseUrl = applicationProperties.getString('jira.baseurl')
    final def username = 'admin'
    final def password = 'q'
    final def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}",
                         'X-ExperimentalApi': 'opt-in', 'Accept': 'application/json'] as Map

    def http = new RESTClient(baseUrl)
    http.setHeaders(headers)

    def resp = http.get(path: "/rest/servicedeskapi/request/${issueKey}/approval") as HttpResponseDecorator

    if (resp.status != 200) {
        log.warn 'Commander did not respond with 200 for retrieving project list'
    }

    def issueJson = resp.data as Map

    def approvers = [] as List

    def totalValues = issueJson.get('values') as Map

    def filteredMap = totalValues[-1] as Map

    approvers.add(filteredMap.get('approvers'))

    def result = approvers[0].findAll { Map output ->
        output.approverDecision == 'pending'
    }.collect {
        def output = it as Map
        (output.approver as Map).emailAddress
    }

    Response.ok(new JsonBuilder(result).toPrettyString()).build()
}
```

