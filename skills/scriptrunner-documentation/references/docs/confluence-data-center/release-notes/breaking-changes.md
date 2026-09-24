# Breaking changes

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-1a3e8c97-d70b-44d2-931a-601907491f0a-55a1116bc8bb778b
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes

Find information about upcoming and latest changes to ScriptRunner for Confluence Data Center here.

## Version 10.0.0+

### Confluence was updated to 10.0.0

See the Atlassian [Confluence 10.0.0 release notes](https://confluence.atlassian.com/doc/confluence-10-0-release-notes-1612579091.html) for details.

### API changes

Atlassian have made a number of key API changes that may impact your scripts. To ensure uninterrupted functionality, it's crucial to review and update your scripts before upgrading. Please carefully consider the changes described in this section.

#### TrustedRequestFactory removed in Confluence 10

The `com.atlassian.sal.api.net.TrustedRequestFactory` class has been removed in Confluence 10.

Any scripts that use this class will no longer work. This includes several example scripts on our site, which have now been updated.

#### What to do instead

Use the HAPI class `com.adaptavist.hapi.platform.oauth.OAuthRequestSigner` to construct HTTP requests. This class generates the authorization header and signed request URI required for OAuth requests. See our [Work with OAuthRequestSigner](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-oauthrequestsigner) HAPI documentation for examples.

#### Updated example scripts

We have several [example scripts](https://www.scriptrunnerhq.com/help/example-scripts) that use this API. These are listed below, along with updated versions of these scripts:

#### Display Spaces View Report

[Updated script](https://www.scriptrunnerhq.com/help/example-scripts/spaces-view-report-onPrem) (ScriptRunner 10.x.x and above):

```
import com.atlassian.oauth.Request
import org.joda.time.DateTime
import groovy.json.JsonSlurper
import groovy.xml.MarkupBuilder
import org.joda.time.DateTimeZone
import groovyx.net.http.URIBuilder
import com.atlassian.sal.api.UrlMode
import com.atlassian.sal.api.ApplicationProperties
import com.onresolve.scriptrunner.parameters.annotation.Select
import com.onresolve.scriptrunner.parameters.annotation.meta.Option
import com.onresolve.scriptrunner.runner.customisers.PluginModule

import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

@PluginModule
ApplicationProperties applicationProperties

@Select(
    label = "Space Type",
    description = "Select the <b>'Space Type'</b> you wish to include in your result",
    options = [
        @Option(label = "Global", value = "global"),
        @Option(label = "Personal", value = "personal"),
        @Option(label = "Global & Personal", value = "global,personal"),
    ]
)
String spaceType

@Select(
    label = "Content",
    description = "Select the <b>'Content'</b> you wish to include in your result ",
    options = [
        @Option(label = "Page", value = "page"),
        @Option(label = "Blog", value = "blog"),
        @Option(label = "Page & Blog", value = "page,blog"),
    ]
)
String content

@Select(
    label = "Sort Field",
    description = "This is to set which column you want to sort as <b>'Last Viewed'</b> or <b>'Total Views'</b> in the result.",
    options = [
        @Option(label = "Last Viewed", value = "VIEWED_LAST_DATE"),
        @Option(label = "Total Views", value = "VIEWED_COUNT"),
    ]
)
String sortField

@Select(
    label = "Sort Order",
    description = "This is to set which column you want to sort the <b>'Sort Field'</b> above to either ASC or DESC.",
    options = [
        @Option(label = "Ascending", value = "ASC"),
        @Option(label = "Descending", value = "DESC"),
    ]
)
String sortOrder

// Number of days you want to minus from current date. This is one of parameter (Date Ranges) needed in the rest request.
def days = 100
def toDate = new DateTime( new DateTime() , DateTimeZone.UTC )
def fromDate = toDate.minusDays(days)

// Rest request to get the activityBySpace
def rest = '/rest/confanalytics/1.0/instance/paginated/activityBySpace'
def host = applicationProperties.getBaseUrl(UrlMode.CANONICAL)

def url = new URIBuilder( host )
    .setPath(host + rest)
    .addQueryParam("fromDate", fromDate)
    .addQueryParam("toDate", toDate)
    .addQueryParam("period", "week")
    .addQueryParam("spaceType", spaceType)
    .addQueryParam("content", content)
    .addQueryParam("timezone", "GMT+00:00")
    .addQueryParam("type", "total")
    .addQueryParam("limit", "100")
    .addQueryParam("sortField", sortField)
    .addQueryParam("sortOrder", sortOrder) as String

try {
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

    def result = new JsonSlurper().parseText(response.body()) as Map
    def activityBySpace = result.activityBySpace as List<Map>

    def stringWriter = new StringWriter()
    def build = new MarkupBuilder(stringWriter)

    // build the output into a table
    build.table(class: "aui") {
        tbody {
            tr {
                th { p("Space Key") }
                th { p("Space Name") }
                th { p("Last Viewed") }
                th { p("Total Views") }
            }
        }

        activityBySpace.each { space ->
            def spaceLink = "<a href='${space?.link}'>${space?.name}</a>"

            tr {
                td { p(space?.key) }
                td { mkp.yieldUnescaped(spaceLink) }
                td { p(space?.lastViewedAt[0..9]) }
                td { p(space?.views) }
            }
        }
    }

    stringWriter.toString()
} catch ( Exception e ) {
    log.warn "Exception >>> ${e.message}"
    return e.message
}
```

#### Spring and Jakarta upgrade

Jira has upgraded to Spring 6.x and Jakarta EE 10, which changes to core Java EE technologies. This upgrade affects various components including servlets, REST APIs, dependency injection, and annotations. See [Atlassian's documentation](https://confluence.atlassian.com/doc/preparing-for-confluence-10-0-1509720080.html) for more details.

If any of your scripts, such as [web item](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) scripts, refer to old package names (for example servlet, REST, dependency injection), or depend on libraries that assume older versions, they may fail. It's important to review and update these references. See below for examples of packages that have migrated from javax to jakarta:

Tip: In some cases it may be as simple as replacing `javax` with `jakarta` in your imports.

JavaX xml

```
import javax.xml.bind.JAXBContext
import javax.xml.bind.Marshaller
import javax.xml.bind.annotation.XmlRootElement

@XmlRootElement
class Person {
    String name
}
```

New Jakarta xml

```
import jakarta.xml.bind.JAXBContext
import jakarta.xml.bind.Marshaller
import jakarta.xml.bind.annotation.XmlRootElement

@XmlRootElement
class Person {
    String name
}
```

Java X Java Mail

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

New Jakarta Java Mail

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

### API Deprecations

Atlassian introduced a new search API in Jira Data Center version 10.4. Some methods in the current API are now deprecated, so some of your scripts may break when Jira 11 is released.

## Version 9.0.0+

### Confluence was updated to 9.0.0

See the Atlassian [Confluence 9.0.0 release notes](https://confluence.atlassian.com/doc/confluence-9-0-release-notes-1387867170.html) for details.

### Fragment changes

Please check out these pages to see what's changed with our [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments):

-   [Raw XML Module Breaking Change for Confluence 9](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9)
    -   The formats for `condition class` and `provider class` has changed.
-   [Web Panel Breaking Change/Deprecation for Confluence 9.0.0](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-confluence-9)
    -   The `writeHtml` method will now be ignored.
    -   Atlassians `WebPanel` interface has moved to a new location.
-   [Web Resource Breaking Change for Confluence 9.0.0](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/web-resource-breaking-change-for-confluence-9)
    -   All web resources should now be kept in `web-resources/com.onresolve.confluence.groovy.groovyrunner.`

### Third-party library/API removal

Atlassian has removed access to several third-party libraries. This means app vendors can no longer access these libraries from Confluence. We will now ship, as part of ScriptRunner, the third-party libraries that our plugin requires to function. However, if you have written scripts that use any of the APIs Atlassian has removed, you may find your scripts have broken. Your scripts will only break if they use APIs from removed dependencies that ScriptRunner does not include. You can review the list of removed APIs in the [Atlassian documentation](https://developer.atlassian.com/platform/marketplace/dc-apps-platform-7/#removed-dependencies).

### APIs removed

The following APIs have been removed for Confluence 9. If you use any of the removed APIs in your script, the scripts will break if they are not replaced. We have recommended replacements for you in the second column:

| API removed | Recommened replacement |
| --- | --- |
| `com.atlassian.confluence.plugins.index.api.mapping.FieldMapping.IndexFieldMappingConflictException` | Removed |
| `com.atlassian.confluence.impl.search.v2.DefaultContentPermissionCalculator#getEncodedContentPermissionSets​` `(Collection<ContentPermissionSet> contentPermissionSets)` | `com.atlassian.confluence.impl.search.v2.DefaultContentPermissionCalculator#getEncodedPermissionsCollection​(ContentPermissionSet contentPermissionSet)` |
| `com.atlassian.confluence.search.v2.score.ScoreFunctionFactory#createContentTypeScoreFunction()` | `com.atlassian.confluence.search.v2.score.FunctionScoreQueryFactory.applyFunctionScoring​(SearchQuery searchQuery)` |
| `com.atlassian.confluence.search.v2.SearchFieldNames` | `com.atlassian.confluence.search.v2.SearchFieldMappings` |
| `com.atlassian.confluence.search.v2.score.DecayParameters#getOrigin()` | Changed to `return string` in Confluence 9 |
| `com.atlassian.confluence.search.v2.score.ScoreFunctionFactory#createRecencyOfModificationScoreFunction` | `com.atlassian.confluence.search.v2.score.FunctionScoreQueryFactory.applyFunctionScoring​(SearchQuery searchQuery)` |
| `com.atlassian.confluence.search.v2.score.StaircaseFunction` | Not supported by OpenSearch |
| `com.atlassian.confluence.plugins.index.api.AnalyzerDescriptor` | Not supported by OpenSearch |
| `com.atlassian.confluence.search.v2.query.BoostByDateMilestoneRules` | Removed |
| `com.atlassian.confluence.util.QuickPageRenderBean` | Removed |

### Gadgets removed

The following gadgets have been removed for Confluence 9. If the gadgets are used in any of your scripts, scripts will break.

-   `com.atlassian.gadgets.*`
-   `<gadget> module`
-   Gadget macro
-   Streams gadget
-   Confluence page gadget
-   Confluence news gadget
-   Confluence search gadget

### JDK Upgrade

The minimum supported version of the JDK is now JDK 17.

## Version 8.0.0+

### Groovy was updated to 4.0.7

See [Groovy 4 Update section](https://docs.adaptavist.com/sr4c/latest/release-notes/release-8.x#groovy-4-update--en) for details.

### Deprecated SrSpecification class removed

Authors of [script plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins) may be used to writing tests which extend the deprecated `com.onresolve.scriptrunner.canned.common.admin.SrSpecification` class. This class has been removed. Authors of tests for their scripts should extend the `spock.lang.Specification` class directly. Tests should still be picked up by [Test Runner built-in script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/test-runner) as normal.

## Version 7.0.0+

### Custom Search Fields was updated in 7.7.0

The Search Extractors feature was removed and replaced with Custom Search Fields in ScriptRunner for Confluence [release 7.7.0](release-7-x.md). Please refer to the [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields) documentation for more information.

### Groovy was updated to 3.0.12

See the Groovy 3 Update section in the 7.0.0 Release Notes for details.

### Spock was updated to 2.0

As part of upgrading to Groovy 3, we had to update Spock because there is no Groovy 3-compatible version of Spock 1.3, which was used in ScriptRunner 6.

You can use Spock to [write and run unit tests](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/test-your-code) within ScriptRunner. It is unlikely that tests written by ScriptRunner users would use parts of Spock 2.0 that contain breaking changes. However, if you maintain tests for your scripts, you should explore the breaking changes listed in the [release notes](https://spockframework.org/spock/docs/2.0/release_notes.html#_2_0_2021_05_17) for Spock 2.0.

### JUnit 4 removal

Although it wasn't advertised in the documentation, it was possible to [write and run unit tests](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/test-your-code) using JUnit 4 in ScriptRunner 6. Spock 2.0 is based on JUnit Platform, not JUnit 4, so JUnit 4 tests will no longer work inside ScriptRunner.

If you wrote any tests using JUnit 4, you will need to rewrite them using Spock 2.0.

## Version 6.17.0+

### IE

The last ScriptRunner version compatible with IE11 is 6.17.0. Do not update ScriptRunner past this version if using IE11.
