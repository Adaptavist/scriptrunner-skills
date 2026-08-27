# Limitations

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started
- Doc ID: doc-sr4jc-101629578
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/limitations

Several limitations are applied to scripts when they run, as detailed below. The limits should be more than sufficient for most scripts and are designed to catch erroneous scripts. 

## Timeouts

There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated. Any logs from the first 240 seconds of execution will be logged on the [Script Logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs#id-.ReviewLogsvCurrent-scriptlogs) page.

There is a limit of 30 seconds for each call made to the API. We impose these timeouts to prevent scripts/API calls from running for a long time period and impacting the performance of the Jira Cloud infrastructure provided by Atlassian. We cannot change the timeout for each API call.

### ScriptRunner Enhanced Search timeouts

ScriptRunner Enhanced Search is moving to Atlassian’s native Forge platform this year. As part of this transition, there are two new limits: 

-   Result limit of 1,000 issues
-   Timeout limit of 25 seconds

Both of these limits are per precomputation. A precomputation is an individual use of an ScriptRunner Enhanced Search function. Filters can contain multiple precomputations, and each one can return up to 1,000 issues and run for 25 seconds. 

**Example**: `issueFunction` in `linkedIssuesOf("project = test")` and `issueFunction` in `addedAfterSprintStart(1)`. Each use of a function, or precomputation, can return 1000 issues, so the entire filter could return 2,000 issues since there are two. For timeout limits, each function, or precomputation, can take 25-seconds to process. They will run at the same time. 

For more information about the new limits, please visit [Timeouts and Performance for ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/current/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/timeouts-and-performance). For more information about the Forge migration, please visit [Enhanced Search Migration to Forge Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/enhanced-search-migration-to-forge). 

## Data limit

There is a limit of 10MB on how much data you can send in a REST API request to Jira or Confluence. This is likely only to impact uploading attachments to Jira or Confluence. The REST API call may fail with a 500 or 413 HTTP response.

## Method size

There is a JVM limitation that relates to the size of methods within scripts. This is imposed by Java rather than ScriptRunner or Jira, as documented in the [Atlassian KB](https://confluence.atlassian.com/jirakb/groovy-script-cannot-be-executed-due-to-method-code-too-large-error-1063568679.html). A single method can consist of up to 65536 bytes of bytecodes before the JVM limit returns the error shown below:

`General error during class generation: Method code too large`

## Scripts in ScriptRunner Cloud Storage

Our scripts are stored externally from your Jira instance in ScriptRunner Cloud Storage. The scripts are not part of any Jira exports, meaning that they cannot be automatically migrated between Jira Cloud instances. Currently, it is not possible to migrate your scripts back into Jira Cloud’s storage. 

Please note that we store [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-behaviourscripts) using the [UI Modifications API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-ui-modifications--apps-/#api-rest-api-3-uimodifications-get:~:text=Each%20app%20can%20define%20up%20to%203000%20UI%20modifications.%20Each%20UI%20modification%20can%20define%20up%20to%201000%20contexts.%20The%20same%20context%20can%20be%20assigned%20to%20maximum%20100%20UI%20modifications), so at a maximum, you can create 3000 Behaviours. However, a context (combination of space, work item type and view that the behaviour is executed on) can only be used for 100 behaviours. Find out more details in our [Behaviours Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) section.

Jira back-ups and ScriptRunner data

As scripts are stored in our AWS hosting infrastructure and NOT stored within Jira (with the exception of [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)), then you should be aware that if a Jira backup is performed, you are not backing up any links to the ScriptRunner Cloud data.

Unfortunately, the instance URL is irrelevant. Therefore, performing a site import or restoring a backup, even with the same URL, does not guarantee that ScriptRunner Cloud will be restored. In some cases, the opposite is true.

## Package imports

You cannot import external libraries as this is not supported. Whilst you can import packages into your scripts in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console), Script Events and [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), you can only import from the standard Java 17 classes and the following libraries:

-   org.apache.groovy:groovy:4.0.28
    
-   org.apache.groovy:groovy-datetime:4.0.28
    
-   org.apache.groovy:groovy-dateutil:4.0.28
    
-   org.apache.groovy:groovy-json:4.0.28
    
-   org.apache.groovy:groovy-jsr223:4.0.28
    
-   org.apache.groovy:groovy-nio:4.0.28
    
-   org.apache.groovy:groovy-sql:4.0.28
    
-   org.apache.groovy:groovy-templates:4.0.28
    
-   org.apache.groovy:groovy-xml:4.0.28
    
-   com.fasterxml.jackson.core:jackson-core:2.17.2
    
-   com.fasterxml.jackson.core:jackson-annotations:2.17.2
    
-   com.fasterxml.jackson.core:jackson-core:2.17.2
    
-   com.fasterxml.jackson.core:jackson-databind:2.17.2
    
-   com.fasterxml.jackson.datatype:jackson-datatype-jdk8:2.17.2
    
-   com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.17.2
    
-   com.fasterxml.jackson.module:jackson-module-jaxb-annotations:2.17.2
    
-   io.github.openunirest:unirest-java:2.2.10
    
-   com.google.code.gson:gson:2.13.1
    
-   commons-logging:commons-logging:1.2
    
-   commons-codec:commons-codec:1.11
    
-   org.apache.httpcomponents:httpclient:4.5.13
    
-   org.apache.httpcomponents:httpcore:4.4.13
    
-   org.apache.httpcomponents:httpmime:4.5.13
    
-   org.apache.httpcomponents:httpasyncclient:4.1.4
    
-   org.apache.httpcomponents:httpcore-nio:4.4.10
    
-   org.apache.httpcomponents:httpcore:4.4.13
    
-   org.slf4j:slf4j-api:1.7.36
    
-   io.jsonwebtoken:jjwt:0.9.1
    
-   org.jsoup:jsoup:1.15.3
    
-   com.amazonaws:aws-lambda-java-log4j2:1.5.1
    
-   org.apache.logging.log4j:log4j-api:2.19.0
    
-   org.apache.logging.log4j:log4j-core:2.19.0 (\*)
    
-   org.apache.logging.log4j:log4j-slf4j-impl:2.19.0
    
-   org.apache.logging.log4j:log4j-iostreams:2.19.0
    
-   org.apache.logging.log4j:log4j-1.2-api:2.19.0
    
-   com.sun.mail:javax.mail:1.6.2
    
-   org.postgresql:postgresql:42.2.19
    
-   mysql:mysql-connector-java:8.0.33
    
-   com.microsoft.sqlserver:mssql-jdbc:9.2.1.jre11
    

## UniRest library

ScriptRunner is built to use the UniRest library as shown in the above list for making REST API calls. This allows you to make a REST API call with BasicAuthentication using a structure similar to the one outlined below. Remember to make sure you are doing this over HTTPS.

```
def result = get('/rest/project-templates/1.0/createshared/10005')
        .basicAuth('username@company.com', 'XXXX') // enter here your username and API token. 
        .asObject(Map)
        .body
```
