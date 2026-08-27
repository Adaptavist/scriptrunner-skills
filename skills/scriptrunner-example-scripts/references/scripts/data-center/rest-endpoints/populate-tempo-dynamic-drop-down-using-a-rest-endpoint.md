# Populate Tempo Dynamic Drop-down using a REST Endpoint

- Platform: data-center
- Feature: rest-endpoints
- Tags: automate, extend
- Language: groovy
- Doc ID: example-dataCenter-create-tempo-dynamic-dropdown-using-rest-endpoint-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-tempo-dynamic-dropdown-using-rest-endpoint-onPrem

## Overview

Add content to a Tempo Dynamic Drop-downs worklog using attributes obtained using a REST Endpoint. Drop-downs require
keys and values in JSONP format, which can be provided using this script REST endpoint.

## Example

As a project manager, I want to add a drop-down in the worklog window so that the working day type can be filled.
This drop-down can contain the following values: "Regular working day", "Night working day" and "Weekend working day".
I can configure this script to obtain the drop-down values using a REST endpoint.

## Good to Know

* This script requires [Tempo Timesheets](https://marketplace.atlassian.com/apps/6572/tempo-timesheets-time-tracking-report)
* A Tempo Work Attribute of type Dynamic Drop-down must be created. The API URL of this Work Attribute is:
  `http://<JIRA base URL>/rest/scriptrunner/latest/custom/tempoWorkType`, where `tempoWorkType` is the name of the endpoint
  created. More information about [Dynamic Dropdowns](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/370769935/Configuring+External+Drop-down+Lists+for+Worklogs+-+Tempo+Server).
* Available options can be customised based on the query parameters.
* Tempo will automatically supply the callback function name.
* Tempo requires the keys and values for the drop-down in JSONP format.

## Script

```groovy
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

tempoWorkType(httpMethod: "GET") { MultivaluedMap queryParams, String body ->
    def callbackFn = queryParams.getFirst("callback")

    def options = [
        values: [
            [
                key  : "TRIAGE",
                value: "Triage"
            ],
            [
                key  : "DEV",
                value: "Development"
            ],
            [
                key  : "QA",
                value: "Quality Assurance"
            ]
        ]
    ]
    def jsObjectOptions = new JsonBuilder(options).toPrettyString()
    def resp = "${callbackFn} ( ${jsObjectOptions} )".toString()

    // Adding 'application/javascript' is needed to prevent a browser error like this: script cannot be executed due to
    // wrong MIME type.
    // For example, the error in Chrome is: "Refused to execute script from '*' because its MIME type
    // ('application/javascript') is not executable, and strict MIME type checking is enabled."
    Response.ok(resp)
        .header('Content-Type', 'application/javascript')
        .build()
}
```

