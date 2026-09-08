# Built-In Scripts

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886879
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts

![](/sr4js/files/latest/442886879/441364748/1/1750863731000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#built-in-scripts) for more details.**

## What are Built-in Scripts?

ScriptRunner built-in scripts automate manual, complex, and time-consuming tasks. The flexibility of ScriptRunner for Jira lets you do almost anything with your data, meaning some routine tasks can become complicated and incredibly tedious. Aimed at users with limited Groovy knowledge, built-in scripts allow you to quickly achieve your goals without having to write Groovy code from scratch. 

All built-in scripts are always visible and executable by users with Jira Administration and Jira System Administration permissions.

## How to use Built-in Scripts

Built-in scripts have been created for some of the most commonly run tasks in ScriptRunner. For example we have scripts to:

-   Modify the resolution field of multiple issues at once with the [Bulk Fix Resolutions](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-fix-resolutions) script.
-   Copy the value of a field from one field to another in your instance with [Copy Field Values](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values). 
-   [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user) to complete tasks as a different user.
-   Show all configured ScriptRunner scripts on your instance with the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry). 

## Before you Start

  

![Hat icon](/sr4js/files/latest/442886879/442886970/1/1758746759000/Copy+of+sr-icon-mortar-board.png)

See our Built-in Scripts Tutorial to learn about setting up and using built-in scripts.

  

  

[Built-in Scripts Tutorial](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/built-in-scripts-tutorial)

  

## Executing Built-In Scripts Remotely

It’s possible to automate use of built-in scripts, i.e. calling them programatically. All scripts take a JSON payload. Currently this is url-encoded…​ which is likely to change in the future.

The payload contains the names and values of the parameters, plus the name of the built-in script we want to execute. The easiest way to get these is to execute the _Preview_ function, and copy the **scriptParams** parameter.

### Curl example

As an example, let’s use the script which bulk imports custom field options. We need to post data similar to the following, which will add the three options AAA, BBB and CCC.

```
{
	"FIELD_FCS":"10208",
	"FIELD_IMPORT_VALUES":"AAA\nBBB\nCCC",
	"canned-script":"com.onresolve.scriptrunner.canned.jira.admin.BulkImportCustomFieldValues"
}
```

Put the above in a file, in this example called **add-opt.json**. Now post this to the correct endpoint using curl:

```
> curl -u admin:admin "http://<jira>/rest/scriptrunner/latest/canned/com.onresolve.scriptrunner.canned.jira.admin.BulkImportCustomFieldValues" -H "X-Atlassian-token: no-check" -H "Content-Type: application/json; charset=UTF-8" -H "Accept: application/json" --data "@add-opt.json"

{"output":"Added 2 new option(s) to scheme: <b>Default Configuration Scheme for SelectListA</b> for custom field: <b>SelectListA</b>. 1 option(s) already existed"}
```

In all the examples, enter appropriate administrator credentials.

If there is an error running the script, you will get a 500 status code, and a message.

### HttpBuilder example

You can call these from code, for example from Groovy.

The following example executes the same built-in script as the curl example above:

```
import groovyx.net.http.ContentType
import groovyx.net.http.RESTClient

// Use your Jira instance URL here
def restClient = new RESTClient("http://localhost:8080/")

// Replace this with your own authentication
def auth = "admin:admin".bytes.encodeBase64()

restClient.setHeaders("Authorization": "Basic ${auth}")
restClient.setContentType(ContentType.JSON)

def response = restClient.post(
        path: "/jira/rest/scriptrunner/latest/canned/com.onresolve.scriptrunner.canned.jira.admin.BulkImportCustomFieldValues",
        body: [
                "FIELD_FCS":"10208",
                "FIELD_IMPORT_VALUES":"AAA\nBBB\nCCC",
                "canned-script":"com.onresolve.scriptrunner.canned.jira.admin.BulkImportCustomFieldValues"
        ],
)

response['data']
```

The following example executes the Test Runner script:

```
import groovyx.net.http.Method
import groovyx.net.http.ContentType
import groovyx.net.http.RESTClient

def testConfiguration = [
        FIELD_SCAN_PACKAGES: "com.onresolve.jira,com.onresolve.base,com.acme.scriptrunner.test",
        FIELD_TEST         : [
                "com.onresolve.jira.AAASetupAllFixtures",
        ],
]

// Use your Jira instance URL here
def restClient = new RESTClient("http://localhost:8080/")

// Replace this with your own authentication
def auth = "username:password".bytes.encodeBase64()
restClient.headers["Authorization"] = "Basic ${auth}"

def response = restClient.request(Method.POST, ContentType.JSON) {
    uri.path = "/jira/rest/scriptrunner/latest/canned/com.onresolve.scriptrunner.canned.common.admin.RunUnitTests"
    body = testConfiguration
}

response.data.json
```
