# Delete a REST Endpoint That Broke the REST Endpoint Page

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Help
- Doc ID: doc-sr4c-be804660-6575-447e-9d5e-0a4fbb897038-13422e584410e8ed
- Source: https://docs.adaptavist.com/sr4c/latest/get-help#delete-a-rest-endpoint-that-broke-the-rest-endpoint-page--en

Remedy for the problem of creating a REST endpoint that causes the REST Endpoints page to fail to load.

## Problem

You created a [REST endpoint](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints) that had some code that caused the REST endpoints page to fail to load.

Tip: Support

For Support to tell you why the failure happened, please send us the script that caused the problem so we can reproduce the issue.

## Solution

Warning: Identifying the broken REST endpoint

We assume you know which REST endpoint caused the issue. If you do not, please [contact Support](https://www.scriptrunnerhq.com/help/support).

Proceed with the following solution to delete the REST endpoint that caused the issue:

1.  Run the following script from the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console) to get the REST endpoint data, so you can find the ID of the endpoint.
    
    Get REST endpoints from the Script Console
    
    ```
    import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
    import com.onresolve.scriptrunner.runner.RestEndpointManager
    import com.onresolve.scriptrunner.canned.ConfiguredObjectMapper
     
    def restEndpointManager = ScriptRunnerImpl.scriptRunner.getBean(RestEndpointManager)
    def objectMapper = ScriptRunnerImpl.scriptRunner.getBean(ConfiguredObjectMapper).get()
     
    def result = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(restEndpointManager.load())
     
    "<pre>$result</pre>"
    ```
    
    Example Result: The following example output is of two REST Endpoints.
    
    Tip: Protect against data loss
    
    Make a copy of this output in case you delete the wrong REST endpoint.
    
    ```
    [ {
      "id" : "99048e03-21b8-4109-bbe9-94fc9324592b",
      "version" : 1,
      "ownedBy" : null,
      "disabled" : false,
      "FIELD_SCRIPT_FILE_OR_SCRIPT" : {
        "script" : "import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate\nimport groovy.json.JsonBuilder\nimport groovy.transform.BaseScript\n\nimport javax.ws.rs.core.MultivaluedMap\nimport javax.ws.rs.core.Response\n\n@BaseScript CustomEndpointDelegate delegate\n\ndoItAgain(httpMethod: \"GET\", groups: [\"jira-administrators\"]) { MultivaluedMap queryParams, String body ->\n    return Response.ok(new JsonBuilder([abc: 42]).toString()).build();\n}\n",
        "scriptPath" : null,
        "parameters" : { }
      },
      "FIELD_NOTES" : "another end point",
      "canned-script" : "com.onresolve.scriptrunner.canned.common.rest.CustomRestEndpoint"
    }, {
      "id" : "0e479c4c-be29-41a9-aeb5-ed84a94a8706",
      "version" : 1,
      "ownedBy" : null,
      "disabled" : false,
      "FIELD_SCRIPT_FILE_OR_SCRIPT" : {
        "script" : "import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate\nimport groovy.json.JsonBuilder\nimport groovy.transform.BaseScript\n\nimport javax.ws.rs.core.MultivaluedMap\nimport javax.ws.rs.core.Response\n\n@BaseScript CustomEndpointDelegate delegate\n\ndoThisThing(httpMethod: \"GET\", groups: [\"jira-administrators\"]) { MultivaluedMap queryParams, String body ->\n    return Response.ok(new JsonBuilder([total: 87845485]).toString()).build();\n}\n",
        "scriptPath" : null,
        "parameters" : { }
      },
      "FIELD_NOTES" : null,
      "canned-script" : "com.onresolve.scriptrunner.canned.common.rest.CustomRestEndpoint"
    } ]
    ```
    
    Each REST endpoint has a `"FIELD_SCRIPT_FILE_OR_SCRIPT"` section, and in this section there is a `"script"` section which contains your REST endpoint's inline code.
    
2.  Review the `"script"` section to find the broken REST endpoint.
3.  Once you have found the broken endpoint, look for the `"id"` element above the `"FIELD_SCRIPT_FILE_OR_SCRIPT"` section.
    
    For example, in the above output, the id `"99048e03-21b8-4109-bbe9-94fc9324592b"` is for the first REST endpoint. You can use this ID to delete the problem REST endpoint.
    
4.  Open your terminal or application that lets you run CURL requests.
5.  Run this command to delete the problem endpoint:
    
    Example CURL command template 
    
    ```
    curl -X DELETE -u <AdminUser>:<AdminPassword> <BASE_URL>/rest/scriptrunner/latest/custom/customadmin/<ID OF YOUR ENDPOINT>
     
    //Replace the <AdminUser>, <AdminPassword> and <ID_OF_YOUR_ENDPOINT> with the values specific to your environment.
    ```
    
6.  After running the command, go back to your Jira user interface, clear the browser cache, and then reload the REST endpoints page.

## Result

If you successfully deleted the endpoint, it should not show anymore, and the first script should also not return any information on the deleted endpoint.
