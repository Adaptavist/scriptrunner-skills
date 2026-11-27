# Limitations

- Platform: cloud
- Space: SR4JC
- Hierarchy: Get Started
- Doc ID: doc-sr4jc-4d01707d-c3f1-4343-95a8-01740f7a8ae7-ee5ab2b1d4bbd552
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/limitations

Understand the limits that apply when scripts run, including safeguards to prevent erroneous or runaway scripts.

Several limitations are applied to scripts when they run, as detailed below. The limits should be more than sufficient for most scripts and are designed to catch erroneous scripts.

## Timeouts

There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated. Any logs from the first 240 seconds of execution will be logged on the [Script Logs](../manage-app/review-logs.md) page.

There is a limit of 30 seconds for each call made to the API. We impose these timeouts to prevent scripts/API calls from running for a long time period and impacting the performance of the Jira Cloud infrastructure provided by Atlassian. We cannot change the timeout for each API call.

### ScriptRunner Enhanced Search timeouts

ScriptRunner Enhanced Search is moving to Atlassian's native Forge platform this year. As part of this transition, there are two new limits:

-   Result limit of 1,000 issues
-   Timeout limit of 55 seconds

Both of these limits are per precomputation. A precomputation is an individual use of an ScriptRunner Enhanced Search function. Filters can contain multiple precomputations, and each one can return up to 1,000 issues and run for 55 seconds.

For more information about the new limits, please visit [Timeouts and Performance for ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/get-started/limitations#scriptrunner-enhanced-search-timeouts--en). For more information about the Forge migration, please visit [Enhanced Search Migration to Forge Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/enhanced-search-migration-to-forge).

## Data limit

There is a limit of 10MB on how much data you can send in a REST API request to Jira or Confluence. This is likely only to impact uploading attachments to Jira or Confluence. The REST API call may fail with a 500 or 413 HTTP response.

## Method size

There is a JVM limitation that relates to the size of methods within scripts. This is imposed by Java rather than ScriptRunner or Jira, as documented in the [Atlassian KB](https://confluence.atlassian.com/jirakb/groovy-script-cannot-be-executed-due-to-method-code-too-large-error-1063568679.html). A single method can consist of up to 65536 bytes of bytecodes before the JVM limit returns the error shown below:

`General error during class generation: Method code too large`

## Scripts in ScriptRunner Cloud Storage

Our scripts are stored externally from your Jira instance in ScriptRunner Cloud Storage. The scripts are not part of any Jira exports, meaning that they cannot be automatically migrated between Jira Cloud instances. Currently, it is not possible to migrate your scripts back into Jira Cloud's storage.

Please note that we store [Behaviours](../features/behaviours.md) using the [UI Modifications API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-ui-modifications--apps-/#api-rest-api-3-uimodifications-get:~:text=Each%20app%20can%20define%20up%20to%203000%20UI%20modifications.%20Each%20UI%20modification%20can%20define%20up%20to%201000%20contexts.%20The%20same%20context%20can%20be%20assigned%20to%20maximum%20100%20UI%20modifications), so at a maximum, you can create 3000 Behaviours. However, a context (combination of space, work item type and view that the behaviour is executed on) can only be used for 100 behaviours. Find out more details in our [Behaviours Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) section.

Note: Jira back-ups and ScriptRunner data

-   As scripts are stored in our AWS hosting infrastructure and NOT stored within Jira (with the exception of [Workflow Rules](../features/workflow-rules.md)), you should be aware that if a Jira backup is performed, you are not backing up any links to the ScriptRunner Cloud data.
-   If you save scripts in [Script Manager](https://adaptavistlabs.atlassian.net/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/script_manager.dita), then load those saved scripts on a Workflow Restrict Transitions or Validate Details, a synced copy resides in ScriptRunner's AWS but it is Atlassian's stored copy that runs. Script Manager watches for edits to the script file and pushes updated code to the Atlassian-stored copy so both copies remain synced.
-   Unfortunately, the instance URL is irrelevant. Therefore, performing a site import or restoring a backup, even with the same URL, does not guarantee that ScriptRunner Cloud will be restored. In some cases, the opposite is true.

## Package imports

You cannot import external libraries as this is not supported. Whilst you can import packages into your scripts in the [Script Console](../features/script-console.md), Script Events and [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), you can only import from the standard Java 17 classes and the following libraries:

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

## Forge platform limitations

ScriptRunner for Jira Cloud now runs on Atlassian's Forge platform, which has stricter limits than Connect. Atlassian is [ending support for Connect](https://www.atlassian.com/blog/development/announcing-connect-end-of-support-timeline-and-next-steps), so all Marketplace apps must migrate. Most scripts continue to work without changes, but some may behave differently or fail.

The key platform limits you should be aware of are highlighted below. They explain how each one affects your scripts, and include workarounds where possible. Many of these limits are imposed by Atlassian, so we cannot change them ourselves, but if Atlassian is working on a fix, we will note that as well.

### Event delivery times

Atlassian states that Forge events may take up to 3 minutes to reach an app after the change ([Forge trigger documentation](https://developer.atlassian.com/platform/forge/manifest-reference/modules/trigger/)). Script Listeners, Workflow Perform Actions (post functions), and Scripted Fields that recalculate on update can therefore run up to 3 minutes after the change that triggered them.

Tip: Take a look at the information related to perform actions, clone issues, restricted comments, and rate limits in [Script listener behavior change on Forge events](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/script-listener-behavior-change-on-forge-events).

-   You should not assume a script will run within seconds of a change, or that one listener's update will complete before another listener runs.
    
-   During Atlassian incidents, delays can be longer. If a listener hasn't run after 3 minutes, check its Execution History before contacting support.
    

### API rate limits and fetched data

Forge events carry less data than Connect events, so ScriptRunner makes more calls to Jira on your behalf, and every one counts toward your site's rate limit. The [Script Listener behavior change on Forge events](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/script-listener-behavior-change-on-forge-events) page explains how ScriptRunner fetches missing data when a script reads it, and what happens when a call is rate limited.

### Events that never reach ScriptRunner

Some Jira changes no longer produce an event that ScriptRunner receives, so listeners for them don't run at all. Nothing appears in the listener's Execution History, because no run was started.

Very large events

Atlassian doesn't deliver Forge events larger than 200 kB ([Forge product events](https://developer.atlassian.com/platform/forge/events-reference/product_events/#known-issues)). Connect allowed up to 25 MB. Very few events are this large, but a change to a work item with very large field values may not trigger your script.

Deletion events for child items

When a parent item is deleted, Forge sends only one event for the parent. See the [deletion events notice](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#concept-6637--en) for which child items are affected.

### Response size limits

Forge limits each response from ScriptRunner's backend to the browser to 5 MB ([Atlassian's invocation limits](https://developer.atlassian.com/platform/forge/limits-invocation/)).

Where you might hit it:

-   Script Console. If a script's combined output (returned values plus logs) is larger than 5 MB, it fails with an error instead of displaying the output.
    

What you can do:

-   Return a summary or a count from the Script Console rather than full objects, and log only what you need.
    
-   For large outputs, process the data in batches, or write it somewhere else, such as an attachment or an external system, rather than returning it.
    

### Workflow Perform Actions

Workflow Perform Actions (post functions) get their `issue` variable from Forge events, the same way Script Listeners do. The behaviors below are specific to Workflow Perform Actions.

-   Whose permissions apply. ScriptRunner fetches missing data using the permissions of the user the Perform Action runs as. If that user can't see the data, the script receives `null` and two warnings appear in the log. If a Perform Action needs data that the initiating user might not be allowed to see, run it as the ScriptRunner add-on user.
    
-   Conditions can now fail with an error. If a Perform Action's condition reads a field that has to be fetched and the fetch fails, the Perform Action stops with an error. Before, the condition counted as false and the Perform Action silently did nothing.
    
-   A failed Perform Action doesn't undo the transition. Perform Actions run after the transition completes. If one fails, the work item stays in its new status, only that Perform Action's work is missing, and ScriptRunner doesn't run it again.
    
-   Clone Issue copies the current state. The built-in Clone Issue Perform Action copies the work item as it is when it runs, including changes made by earlier Perform Actions on the same transition.
    

### Enhanced Search

On Forge, each Enhanced Search function in a filter returns up to 1,000 work items and times out after 55 seconds ([Enhanced Search Migration to Forge](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/enhanced-search-migration-to-forge)).
