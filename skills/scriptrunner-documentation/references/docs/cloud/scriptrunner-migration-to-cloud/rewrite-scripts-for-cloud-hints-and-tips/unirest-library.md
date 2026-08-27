# Unirest Library

- Platform: cloud
- Space: SR4JC
- Hierarchy: scriptrunner-migration-to-cloud > rewrite-scripts-for-cloud-hints-and-tips
- Doc ID: doc-sr4jc-101629534
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips/unirest-library

When working with ScriptRunner for Jira Cloud, the Unirest library is a powerful tool for making HTTP requests to interact with Jira's REST API and other web services. It's important to understand how to use Unirest effectively within ScriptRunner scripts to perform actions like retrieving, creating, or updating Jira issues. Below we detail how to use Unirest in ScriptRunner for Jira Cloud.

## Introduction to Unirest

Unirest is a lightweight HTTP library that simplifies making HTTP requests in Java and Groovy. It supports common HTTP methods such as GET, POST, PUT, DELETE, and more. In ScriptRunner for Jira Cloud, Unirest is auto-imported, meaning you can directly use its methods without additional import statements.

## Basic usage of Unirest in ScriptRunner

### GET requests

Use GET requests to retrieve data from Jira, such as issue details or project information. For example:

```
def response = Unirest.get("https://your-domain.atlassian.net/rest/api/3/issue/{issueIdOrKey}")

         .header("Authorization", "Bearer YOUR_ACCESS_TOKEN")

         .header("Accept", "application/json")

         .routeParam("issueIdOrKey", "TEST-123")

         .asJson()

     if (response.getStatus() == 200) {

         def issueData = response.getBody().getObject()

         log.info("Issue Summary: ${issueData.getString('fields').getString('summary')}")

     } else {

         log.error("Failed to retrieve issue: ${response.getStatusText()}")

     }
```

### POST requests

Use POST requests to create new resources, such as issues or comments. For example:

```
def jsonBody = [

         fields: [

             project: [ key: "TEST" ],

             summary: "New issue created via Unirest",

             issuetype: [ name: "Task" ],

             description: "Description of the new issue"

         ]

     ]

     def response = Unirest.post("https://your-domain.atlassian.net/rest/api/3/issue")

         .header("Authorization", "Bearer YOUR_ACCESS_TOKEN")

         .header("Content-Type", "application/json")

         .body(new groovy.json.JsonBuilder(jsonBody).toString())

         .asJson()

     if (response.getStatus() == 201) {

         log.info("Issue created successfully: ${response.getBody().getObject().getString('key')}")

     } else {

         log.error("Failed to create issue: ${response.getStatusText()}")

     }
```

### PUT requests

Use PUT requests to update existing resources, such as modifying an issue's fields. For example:

```
def jsonBody = [

         fields: [

             summary: "Updated summary via Unirest",

             description: "Updated description"

         ]

     ]

     def response = Unirest.put("https://your-domain.atlassian.net/rest/api/3/issue/{issueIdOrKey}")

         .header("Authorization", "Bearer YOUR_ACCESS_TOKEN")

         .header("Content-Type", "application/json")

         .routeParam("issueIdOrKey", "TEST-123")

         .body(new groovy.json.JsonBuilder(jsonBody).toString())

         .asJson()

     if (response.getStatus() == 204) {

         log.info("Issue updated successfully")

     } else {

         log.error("Failed to update issue: ${response.getStatusText()}")

     }
```

### DELETE requests

Use DELETE requests to remove resources, such as deleting an issue. For example:

```
def response = Unirest.delete("https://your-domain.atlassian.net/rest/api/3/issue/{issueIdOrKey}")

         .header("Authorization", "Bearer YOUR_ACCESS_TOKEN")

         .routeParam("issueIdOrKey", "TEST-123")

         .asEmpty()

     if (response.getStatus() == 204) {

         log.info("Issue deleted successfully")

     } else {

         log.error("Failed to delete issue: ${response.getStatusText()}")

     }
```

## Key considerations

-   **Authorization:** Always include the appropriate authorization headers. For Jira Cloud, this often involves using OAuth 2.0 tokens or API tokens.
-   **Error handling**: Implement error handling to manage unsuccessful requests and capture meaningful error messages.
-   **JSON handling:** Use Groovy's \`JsonBuilder\` or \`JsonSlurper\` to construct and parse JSON payloads effectively.
-   **Logging**: Utilize logging to track the status and outcomes of your HTTP requests, which aids in debugging and monitoring.

By mastering Unirest within ScriptRunner for Jira Cloud, you can efficiently interact with Jira's REST API and automate various tasks, enhancing your Jira Cloud environment's functionality.
