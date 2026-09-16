# Troubleshooting REST Endpoints

- Platform: data-center
- Space: SR4JS
- Hierarchy: Get Help > Troubleshooting
- Doc ID: doc-sr4js-80eb8714-d3e6-4524-8b2c-8d834e6bb1f5-d97c024df984e9b7
- Source: https://docs.adaptavist.com/sr4js/latest/get-help#troubleshooting--en#troubleshooting-rest-endpoints--en

## Delete a REST endpoint that had broken the REST endpoints page

### Problem

You have created a REST endpoint that had some code in it which caused the REST endpoints page to fail to load.

Proceed with the following solution to delete REST endpoint that caused the issue.

Note: For support to tell you why the failure happened, please send us the script that causes the problem so we can reproduce the issue.

### Solution

Note: We assume you know which REST Endpoint caused the issue. If you do not then please contact support.

1.  Run the following script from the script console to get the REST endpoint data.
    
    You need this data so you can find the ID of the endpoint. If it does not work please contact support and we can troubleshoot further:
    
    Get REST endpoints from the script console
    
    ```
    import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
    import com.onresolve.scriptrunner.runner.RestEndpointManager
    import com.fasterxml.jackson.databind.ObjectMapper
    
    def restEndpointManager = ScriptRunnerImpl.scriptRunner.getBean(RestEndpointManager)
    def objectMapper = new ObjectMapper()
    
    def result = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(restEndpointManager.load())
    
    "<pre>$result</pre>"
    ```
    
    The following example output is for two REST endpoints:
    
    Warning: Make a copy of this output in case you delete the wrong REST endpoint.
    
    JSON output example 
    
    ```
    [ {
     "id" : "99048e03-21b8-4109-bbe9-94fc9324592b",
     "version" : 1,
     "ownedBy" : null,
     "disabled" : false,
     "FIELD_SCRIPT_FILE_OR_SCRIPT" : {
     "script" : "import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
    import groovy.json.JsonBuilder
    import groovy.transform.BaseScript
    
    import javax.ws.rs.core.MultivaluedMap
    import javax.ws.rs.core.Response
    
    @BaseScript CustomEndpointDelegate delegate
    
    doItAgain(httpMethod: \"GET\", groups: [\"jira-administrators\"]) { MultivaluedMap queryParams, String body ->
        return Response.ok(new JsonBuilder([abc: 42]).toString()).build();
    }
    ",
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
     "script" : "import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
    import groovy.json.JsonBuilder
    import groovy.transform.BaseScript
    
    import javax.ws.rs.core.MultivaluedMap
    import javax.ws.rs.core.Response
    
    @BaseScript CustomEndpointDelegate delegate
    
    doThisThing(httpMethod: \"GET\", groups: [\"jira-administrators\"]) { MultivaluedMap queryParams, String body ->
        return Response.ok(new JsonBuilder([total: 87845485]).toString()).build();
    }
    ",
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
    
    Note: Replace the <AdminUser>, <AdminPassword> and <ID\_OF\_YOUR\_ENDPOINT> with the values specific to your environment.
    
    ```
    curl -X DELETE -u <AdminUser>:<AdminPassword> <BASE_URL>/rest/scriptrunner/latest/custom/customadmin/<ID OF YOUR ENDPOINT>
    ```
    
6.  After running the above go back to your Jira user interface, clear the browser cache, and then reload the REST endpoints page.
    
    If you successfully deleted the endpoint, it should not show anymore, and the first script should also not return any information on the deleted endpoint.
