# Breaking Changes

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-443373504
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes

This page details any breaking changes that could cause parts of your ScriptRunner instance to fail when upgrading.

## Version 10.0.0+ 

### Jira was updated to version 11

See the Atlassian [Jira 11 release notes](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-release-notes-1587939582.html) for details. See the [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for more information on compatibility and how to upgrade.

### API changes

Atlassian have made a number of key API changes that may impact your scripts. To ensure uninterrupted functionality, it's crucial to review and update your scripts before upgrading. Please carefully consider the changes described in this section.

#### Search API upgrade

Atlassian introduced a new search API in Jira Data Center [version 10.4](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html). Some methods in the current API have been [removed in Jira 11](https://confluence.atlassian.com/adminjiraserver/search-api-deprecations-and-upgrade-guide-for-jira-11-1573486929.html); therefore, some of your scripts may break when upgrading. See our [Jira 11 Search API Upgrade Guide](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide) for more details

#### TrustedRequestFactory removal

The `com.atlassian.sal.api.net.TrustedRequestFactory` class has been [removed in Jira 11](https://confluence.atlassian.com/adminjiraserver/preparing-for-jira-11-0-1557069833.html#PreparingforJira11.0-removal-of-trusted-apps:~:text=new%20data%20structure.-,Removal%20of%20Trusted%20apps,-Status%3A). This class is commonly used to enable scripts to make REST calls to endpoints within the same Jira instance, allowing them to impersonate the currently logged-in user. Any scripts that use this class will no longer work. 

##### What to do instead

Use the HAPI class `com.adaptavist.hapi.platform.oauth.OAuthRequestSigner` to construct HTTP requests. This class generates the authorization header and signed request URI required for OAuth requests. See our [Work with OAuthRequestSigner](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-oauthrequestsigner) HAPI documentation for examples. 

##### Updated example scripts

We have several [example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5Bquery%5D=TrustedRequestFactory) that use this API. You'll find a list of ScriptRunner for Jira scripts below, accompanied by their updated counterparts:

-   [Use TrustedRequestFactory to make an HTTP GET request without the user password](https://www.scriptrunnerhq.com/help/example-scripts/get-request-using-trusted-request-factory-onPrem "https://www.scriptrunnerhq.com/help/example-scripts/get-request-using-trusted-request-factory-onPrem")  
    **Updated script (ScriptRunner 10.x.x and above):**
    
    ```
import com.atlassian.oauth.Request
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import groovy.json.JsonSlurper

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

@PluginModule
ApplicationProperties applicationProperties

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/myself'

def request = HttpRequest.newBuilder()
    .uri(OAuthRequestSigner.createOAuthUri(url))
    .header("Content-Type", "application/json")
    .header("Authorization", OAuthRequestSigner.createAuthorizationHeader(url, Request.HttpMethod.GET))
    .GET()
    .build()

def response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())

if (response.statusCode() >= 400) {
    throw new Exception("Status code: ${response.statusCode()}. Response body: ${response.body()}")
}

def currentUser = new JsonSlurper().parseText(response.body()) as Map

currentUser

/*
   responseBody is a JSON string that looks like:

  {
    "self": "http://localhost:8080/jira/rest/api/2/user?username=admin",
    "key": "admin",
    "name": "admin",
    "emailAddress": "admin@admin.com",
    "avatarUrls": {
      "48x48": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=48",
      "24x24": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=24",
      "16x16": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=16",
      "32x32": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=32"
    },
    "displayName": "Mr Admin",
    "active": true,
    "timeZone": "Europe/London",
    "locale": "en_GB",
    "groups": {
      "size": 4,
      "items": [
      ]
    },
    "applicationRoles": {
      "size": 2,
      "items": [
      ]
    },
    "expand": "groups,applicationRoles"
  }
*/
```
    
-   [Use TrustedRequestFactory to make an HTTP POST request without the user password](https://www.scriptrunnerhq.com/help/example-scripts/post-request-using-trusted-request-factory-onPrem "https://www.scriptrunnerhq.com/help/example-scripts/post-request-using-trusted-request-factory-onPrem")  
    **Updated script (ScriptRunner 10.x.x and above):**
    
    ```
import com.atlassian.jira.config.IssueTypeManager
import com.atlassian.jira.project.ProjectManager
import com.atlassian.oauth.Request
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import groovy.json.JsonOutput
import groovy.json.JsonSlurper

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.nio.charset.StandardCharsets

@PluginModule
ApplicationProperties applicationProperties

@PluginModule
ProjectManager projectManager

@PluginModule
IssueTypeManager issueTypeManager

def project = projectManager.getProjectByCurrentKey('JRA')
def issueType = issueTypeManager.issueTypes.find { it.name == 'Bug' }

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/issue'

def requestBody = JsonOutput.toJson([
    fields: [
        project: [
            id: project.id
        ],
        issuetype: [
            id: issueType.id
        ],
        summary: 'build me a rocket',
    ]
])

def request = HttpRequest.newBuilder()
    .uri(OAuthRequestSigner.createOAuthUri(url))
    .header("Content-Type", "application/json")
    .header("Authorization", OAuthRequestSigner.createAuthorizationHeader(url, Request.HttpMethod.POST))
    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
    .build()

def response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())

if (response.statusCode() >= 400) {
    throw new Exception("Status code: ${response.statusCode()}. Response body: ${response.body()}")
}

def issueAsMap = new JsonSlurper().parseText(response.body()) as Map

issueAsMap

/*
   responseBody is a JSON string that looks like:

  {
    "id": "10030",
    "key": "JRA-8",
    "self": "http://localhost:8080/jira/rest/api/2/issue/10030"
  }

 */
```
    
-   [Create a Tempo Plan when an Issue is Assigned to a User](https://www.scriptrunnerhq.com/help/example-scripts/create-tempo-planning-information-when-issue-is-assigned-onPrem "https://www.scriptrunnerhq.com/help/example-scripts/create-tempo-planning-information-when-issue-is-assigned-onPrem")  
    **Updated script (ScriptRunner 10.x.x and above):**
    
    ```
import com.atlassian.oauth.Request
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

import groovy.json.JsonOutput

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.nio.charset.StandardCharsets
import java.time.LocalDate
import java.time.format.DateTimeFormatter

@WithPlugin('com.tempoplugin.tempo-plan-core')

@PluginModule
ApplicationProperties applicationProperties

// Default start time
final startTime = '09:00'

// Weekends and holidays are not included by default. If a plan needs to be created on weekends and holidays, set this to "true"
final includeNonWorkingDays = false

final today = LocalDate.now()

def issue = event.issue
def endDate = issue.dueDate?.toLocalDateTime()?.toLocalDate()

// Do nothing if the issue has been unassigned
if (!issue.assignee) {
    return
}

if (!(issue.estimate && endDate)) {
    log.error('Issue requires both an estimate and a due date. Plan not created')
    return
}

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/tempo-planning/1/plan'

def requestBody = JsonOutput.toJson([
    assigneeKey          : 'JIRAUSER10000',
    assigneeType         : 'USER',
    day                  : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
    end                  : DateTimeFormatter.ISO_LOCAL_DATE.format(endDate),
    includeNonWorkingDays: includeNonWorkingDays,
    planItemId           : issue.id,
    planItemType         : 'ISSUE',
    secondsPerDay        : issue.estimate,
    start                : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
    startTime            : startTime
])

HttpRequest request = HttpRequest.newBuilder()
    .uri(OAuthRequestSigner.createOAuthUri(url))
    .header("Content-Type", "application/json")
    .header("Authorization", OAuthRequestSigner.createAuthorizationHeader(url, Request.HttpMethod.POST))
    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
    .build()

HttpResponse<String> response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())

if (response.statusCode() >= 400) {
    throw new Exception("Status code: ${response.statusCode()}. Response body: ${response.body()}")
}

response.body()
```
    

#### Spring and Jakarta upgrade

Jira has upgraded to Spring 6.x and Jakarta EE 10, which introduces changes to core Java EE technologies. This upgrade affects various components including servlets, REST APIs, dependency injection, and annotations. See [Atlassian's documentation](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-upgrade-notes-1587941263.html#JiraSoftware11.0.xupgradenotes-spring-and-jakarta) for more details.

If any of your scripts, such as [web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item), [REST endpoint](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints), and [mail handler](https://docs.adaptavist.com/sr4js/latest/features/mail-handler/mail-handler-examples) scripts, refer to old package names (for example servlet, REST, dependency injection), or depend on libraries that assume older versions, they may fail. It's important to review and update these references. See below for examples of packages that have migrated from javax to jakarta:  

In some cases it may be as simple as replacing `javax` with `jakarta` in your imports. 

##### JavaX xml

```
import javax.xml.bind.JAXBContext
import javax.xml.bind.Marshaller
import javax.xml.bind.annotation.XmlRootElement

@XmlRootElement
class Person {
    String name
}
```

##### New Jakarta xml

```
import jakarta.xml.bind.JAXBContext
import jakarta.xml.bind.Marshaller
import jakarta.xml.bind.annotation.XmlRootElement

@XmlRootElement
class Person {
    String name
}
```

##### Java X Java Mail

```
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMultipart
import javax.mail.internet.MimeMessage
import javax.mail.Session
import javax.mail.Transport
import javax.mail.internet.InternetAddress

def session = Session.getDefaultInstance(new Properties(), null)
def message = new MimeMessage(session)
message.setFrom(new InternetAddress("no-reply@example.com"))
message.addRecipient(Message.RecipientType.TO, new InternetAddress("user@example.com"))
message.setSubject("Attachment test")

def bodyPart = new MimeBodyPart()
bodyPart.setText("Please see attached")

def attachment = new MimeBodyPart()
attachment.attachFile(new File("/tmp/test.txt"))

def multipart = new MimeMultipart()
multipart.addBodyPart(bodyPart)
multipart.addBodyPart(attachment)

message.setContent(multipart)
Transport.send(message)
```

##### New Jakarta Java Mail

```
import jakarta.mail.internet.MimeBodyPart
import jakarta.mail.internet.MimeMultipart
import jakarta.mail.internet.MimeMessage
import jakarta.mail.Session
import jakarta.mail.Transport
import jakarta.mail.internet.InternetAddress

def session = Session.getDefaultInstance(new Properties(), null)
def message = new MimeMessage(session)
message.setFrom(new InternetAddress("no-reply@example.com"))
message.addRecipient(Message.RecipientType.TO, new InternetAddress("user@example.com"))
message.setSubject("Attachment test")

def bodyPart = new MimeBodyPart()
bodyPart.setText("Please see attached")

def attachment = new MimeBodyPart()
attachment.attachFile(new File("/tmp/test.txt"))

def multipart = new MimeMultipart()
multipart.addBodyPart(bodyPart)
multipart.addBodyPart(attachment)

message.setContent(multipart)
Transport.send(message)
```

#### jQuery 3 upgrade

Jira upgraded to jQuery3 from version 2. If any of your scripts refer to old package names, or depend on libraries that assume older versions, they may fail. It's important to review and update these references. See [Atlassian's documentation](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-upgrade-notes-1587941263.html#JiraSoftware11.0.xupgradenotes-jquery3) for more details.

## Version 9.0.0+ 

### Jira was updated to version 10

See the Atlassian [Jira 10 release notes](https://confluence.atlassian.com/jirasoftware/jira-software-10-0-x-release-notes-1416825224.html) for details. See the [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for more information on compatibility and how to upgrade. 

### Fragments updates

Please check out these pages to see what's changed with our [UI Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments): 

-   [Raw XML Module Breaking Change for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-jira-10)
    -   The formats for `condition class` and `provider class` have changed.
-   [Web Resource Breaking Change for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-resource-breaking-change-for-jira-10)
    -   If you have files in `plugin.resource.directories` you will have to move them to `web-resources/com.onresolve.stash.groovy.groovyrunner`.
-   [Web Panel Breaking Change/Deprecation for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-jira-10)
    -   The `writeHtml` method will now be ignored.
    -   Atlassian's `WebPanel` interface has moved to a new location.
-   [Web Item Provider Built-In Script](https://docs.adaptavist.com/sr4js/latest/features/fragments/built-in-fragments/web-item-provider-built-in-script): Major changes include:
    
    -   The feature will only function once Jira releases the new fragment API updates (Estimated to be available from Jira 10.1.0/10.0.2). See the [ticket](https://assist.adaptavist.com/browse/SRPLAT-2596) for updates.
    -   The `com.atlassian.plugin.web.api.model.WebFragmentBuilder` API has moved to `com.atlassian.plugin.web.model.WebFragmentBuilder`. Any scripts using the old API import will need to be updated to the new location. (Once updated, your scripts will no longer show a red line under the old import; however, you cannot verify the fix fully until Atlassian releases the API mentioned in the [ticket](https://assist.adaptavist.com/browse/SRPLAT-2596).)

### Third-party library/API removal

Atlassian has removed access to several third-party libraries. This means app vendors can no longer access these libraries from Jira. We will now ship, as part of ScriptRunner, the third-party libraries that our plugin requires to function. However, if you have written scripts that use any of the APIs Atlassian has removed, you may find your scripts have broken. Your scripts will only break if they use APIs from removed dependencies that ScriptRunner does not include. You can review the list of removed APIs in the [Atlassian documentation](https://developer.atlassian.com/platform/marketplace/dc-apps-platform-7/#removed-dependencies).

### JDK Upgrade

The minimum supported version of the JDK is now JDK 17. 

## Version 8.0.0+

### Groovy was updated to 4.0.7

See [Groovy 4 Update section](https://docs.adaptavist.com/sr4js/latest/release-notes/release-8-x#groovy4) for details. 

### Important notice for Java 17 users

There is a current omission in the Jira archive that may cause compatibility issues with Java 17. You need to manually add the following JVM flag to avoid these issues:

```
--add-opens=java.base/java.lang.reflect=ALL-UNNAMED
```

See Atlassian’s knowledge base guide on [setting system properties](https://confluence.atlassian.com/adminjiraserver/setting-properties-and-options-on-startup-938847831.html#Settingpropertiesandoptionsonstartup-startup_params) for information on how to configure system properties and therefore add the JVM flag.

These flags are required to address module encapsulation introduced in Java 9 and later, which can cause issues when using reflection or accessing certain internal APIs. We are working closely with Atlassian to address this issue in future releases.

### Deprecated SrSpecification class removed

Authors of [Script Plugins](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin) may be used to writing tests which extend the deprecated `com.onresolve.scriptrunner.canned.common.admin.SrSpecification` class. This class has been removed. Authors of tests for their scripts should extend the `spock.lang.Specification` class directly. The [Test Runner Built-in Script](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests#running-tests) should still pick up tests as normal.

## Version 7.0.0+

### Groovy was updated to 3.0.12

See [Groovy 3 Update section](https://docs.adaptavist.com/sr4js/latest/release-notes/release-7-x#groovy3) for details. 

### Spock was updated to 2.0

As part of upgrading to Groovy 3 we had to update Spock, because there is no Groovy 3 compatible version of Spock 1.3, which was used in ScriptRunner 6. 

Spock can be used to [write and run unit tests](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests) within ScriptRunner. It is unlikely that tests written by ScriptRunner users would use parts of Spock 2.0 that contain breaking changes. However, if you maintain tests for your scripts you should explore the breaking changes listed in the [release notes](https://spockframework.org/spock/docs/2.0/release_notes.html#_2_0_2021_05_17) for Spock 2.0.

### JUnit 4 removal

Although it wasn't advertised in the documentation, it was possible to [write and run unit tests](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests) using JUnit 4 in ScriptRunner 6. Spock 2.0 is based on JUnit Platform, not JUnit 4, so JUnit 4 tests will no longer work inside ScriptRunner.

If you wrote any tests using JUnit 4, then you will need to rewrite them using Spock.

## Version 6.17.0+

### IE11

The last ScriptRunner for Jira version compatible with IE11 is 6.17.0. **Do not update ScriptRunner past this version if using IE11.**

## Version 6.11.0+

If using the _Database Picker_, from version 6.11.0, any row results will be automatically HTML-encoded. Currently, they are sanitised, meaning any malicious javascript is stripped from them.

This can lead to problems when the database result is something like `<foo` \- in this case nothing will be shown. When this is fixed the row result will be returned as `<foo`.

The reason this is not done automatically is because some users are creating HTML with their SQL query, e.g. `select '<b>' || name || '</b>' from foo`.

This means we can’t automatically protect against XSS attacks whilst guaranteeing that all data will be displayable. (Currently, we are protecting against XSS attacks at the cost that some strings may not be displayed).

Any users formatting results in this way should switch to using groovy to [customise the displayed value](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations#id-.DatabasePickerCustomizationsv9.x-customizedisplayvalue) as soon as possible.

When this is fixed, in ScriptRunner 6.11.0, customisations that use SQL to format the result will not continue to work as expected.

## Version 6.0.0+

### Version Searcher JSON Schema

Previously, when using a script field with the `Version Searcher`, the JSON representation for an issue incorrectly represented the schema as a single version, and therefore only returned the first entry of a list. It now returns all list entries; however, the JSON schema has changed from a list to an array. This change might affect you if you were parsing the JSON response for an issue containing a script field with this indexer.

### Constant Removal and Replacement

The following constant has been removed in ScriptRunner 6.0:

* * *

```
com.onresolve.scriptrunner.runner.ScriptRunnerImpl.PLUGIN_KEY
```

* * *

It has been replaced with:

* * *

```
com.onresolve.scriptrunner.runner.PluginBuildInfo.PLUGIN_KEY
```

* * *

Please ensure any usages of the `ScriptRunnerImpl` constant are removed and replaced before upgrading ScriptRunner to versions 6.0+.

## Unavailable Classes in Jira 8.8.0

The following classes are no longer accessible from Velocity in Jira 8.8.0; this change only affects ScriptRunner users using these classes in custom templates within script fields:

-   java.lang.Class,
    
-   java.lang.ClassLoader,
    
-   java.lang.Compiler,
    
-   java.lang.InheritableThreadLocal,
    
-   java.lang.Package,
    
-   java.lang.Process,
    
-   java.lang.Runtime,
    
-   java.lang.RuntimePermission,
    
-   java.lang.SecurityManager,
    
-   java.lang.System,
    
-   java.lang.Thread,
    
-   java.lang.ThreadGroup,
    
-   java.lang.ThreadLocal,
    
-   com.atlassian.applinks.api.ApplicationLinkRequestFactory,
    
-   com.atlassian.core.util.ClassLoaderUtils,
    
-   com.atlassian.core.util.ClassHelper.
    

## Hidden Fields Removal

_Hidden Fields_ custom fields were removed from ScriptRunner for Jira Server/Data Center in 5.6.10. Hidden fields will no longer be available in your instance. However, all the hidden fields configuration and data will still exist in the database.

### Migration

There are two options for dealing with hidden fields:

-   You would have been using these fields because you didn’t want the contents visible to all users all of the time. Now, the contents will no longer be hidden by the behaviours applied to them in the _View Issue_ screen (these behaviours will hide fields in the _Edit Issue_ screen). We recommend you investigate the [Atlassian Marketplace](https://marketplace.atlassian.com/) for other apps that provide the ability to hide fields in the _View Issue_ screen.
    
-   The recommended approach is to convert them to regular _short text_ or _long text_ fields. To convert hidden fields to regular fields, go to ScriptRunner→Script Console, and execute the following script:
    

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.fields.layout.field.FieldLayoutManager
import org.ofbiz.core.entity.DelegatorInterface
import org.ofbiz.core.entity.EntityExpr
import org.ofbiz.core.entity.EntityOperator

def delegatorInterface = ComponentAccessor.getComponent(DelegatorInterface)
def customFieldManager = ComponentAccessor.customFieldManager
def fieldLayoutManager = ComponentAccessor.getComponent(FieldLayoutManager)

def replacementFieldTypes = [
    'com.onresolve.jira.groovy.groovyrunner:hideable-textfield': 'com.atlassian.jira.plugin.system.customfieldtypes:textfield',
    'com.onresolve.jira.groovy.groovyrunner:hideable-textarea' : 'com.atlassian.jira.plugin.system.customfieldtypes:textarea',
]

delegatorInterface.findByOr('CustomField', replacementFieldTypes.keySet().collect {
    new EntityExpr('customfieldtypekey', EntityOperator.EQUALS, it)
}).each {
    def replacementType = replacementFieldTypes[it.getString('customfieldtypekey')]
    log.warn("Converting '${it.getString('name')}' to $replacementType.")
    it.put('customfieldtypekey', replacementType)
    delegatorInterface.store(it, true)
}

fieldLayoutManager.refresh()
customFieldManager.clear()

"Fields converted"
```

This is safe to re-run if you are not sure it’s been done before, and is the recommended approach to convert these fields to regular fields.

We recommend users change the custom field type of all hidden fields before upgrading to ScriptRunner for Jira 6.0 and above.

If you use these fields on Jira Service Desk, there is the possibility that the fields of these types will be removed from the screen. There is a bug in Jira Service Desk such that if a user opens a request type which contains fields that are currently not present in the system, they will be permanently removed fron the database table that details which fields are part of this request type. If this happens you will need to add them back to the relevant request types.

This problem can be avoided by following this migration procedure before updating.

#### Alternative Method

Alternatively, you can follow [Atlassian guidelines](https://confluence.atlassian.com/jirakb/change-custom-field-types-in-jira-server-158357.html) for changing a field type. However this requires database access, and a Jira restart. If changing custom field type via the database, use the following type keys for what to search for and its replacement:

Old Key

Replacement Key

com.onresolve.jira.groovy.groovyrunner:hideable-textfield???

com.atlassian.jira.plugin.system.customfieldtypes:textfield

com.onresolve.jira.groovy.groovyrunner:hideable-textarea???

com.atlassian.jira.plugin.system.customfieldtypes:textarea

### Rationale

We are sorry for the inconvenience this will cause you if you use these fields, as we almost never remove features.

These fields were removed as there is no maintainable way to truly hide the contents of a field which covers all the various ways that a user might see it. Not just in the view issue screen, but also: in the issue navigator, in the history tab, in the REST API, when exporting to CSV, Word, PDF.

Rather than handle most of these cases but not all, at least not in a maintainable way across all Jira versions, we took the decision that it was more honest to not support these anymore, rather than risk a customer accidentally exposing data to a user that they thought was not possible.

## Version 5.6.7 and Above

### Some Groovy Classes Backwards-incompatible

To lay the groundwork for new features, sometimes we need to refactor our existing code. When doing this, Adaptavist focuses on backwards compatibility, to ensure features continue to work as they did before upgrading.

A few users may have created groovy classes that overrode either `com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CloneIssue` or `com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CreateSubTask`. We have had to change these in a way that is backwards-incompatible, therefore these will no longer work. We are currently working on better ways to allow users to make these kinds of customizations.

There is no simple fix to make the overriding scripts compatible. Rather than overriding them, there are several options available:

1.  Use the **Additional Issue Actions** code section to add code that executes after `Clone Issue` is completed.
    
2.  Add a Custom Script Function/Listener to perform additional actions after the _Clone/Create_ function.
    
3.  Call the function programmatically, dynamically setting the inputs as required.
    

```
import com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CloneIssue
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl

def inputs = [
    'FIELD_TARGET_PROJECT' : 'FOO',
    'FIELD_SELECTED_FIELDS': null, //clone all the fields
] as Map<String, Object>

def executionContext = [
    issue: issue,
]

def cloneIssueBean = ScriptRunnerImpl.scriptRunner.createBean(CloneIssue)
cloneIssueBean.execute(inputs, executionContext)
```

  

The best way to find the keys and values of the inputs is to view the network request in your browser when you configure the function. For example:

![A code example.](/sr4js/files/latest/443373504/443373503/1/1758798251000/network-capture.png)

If these options don’t meet your needs, please contact [Adaptavist Support](https://productsupport.adaptavist.com/servicedesk/customer/portal/2) for help.

## Downgrading

Due to changes and improvements to our API, downgrading is not guaranteed to work so it is only recommended when confirmed by [Adaptavist Support](https://productsupport.adaptavist.com/servicedesk/customer/portal/2).
