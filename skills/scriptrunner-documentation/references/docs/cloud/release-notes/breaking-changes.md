# Breaking Changes

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes
- Doc ID: doc-sr4jc-101629021
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes

## Behaviours planned maintenance

Update: Behaviours app now disabled

We have now disabled the Behaviours companion app. All migrations and upgrades are complete, and any of your existing Behaviours have now been moved to the main ScriptRunner for Jira Cloud app.

Date of change: **August 18th 2026**

### Behaviours will no longer be a companion app from August 3, 2026

The companion app will be disabled as its functionality moves into ScriptRunner.

During this transition, you can expect:

-   existing Behaviours to run as normal.
-   a maintenance screen to display on your instance during a short period of downtime lasting no longer than 30 minutes.
-   Behaviours admin pages to be inaccessible.
-   migrations to occur outside normal working hours, where possible. 
-   a message informing you that _multiple UI modification apps are trying to change the same field property._

Your data will be safely and seamlessly migrated, and no data will be lost. 

Date of change: **from August 3rd 2026**

## Deprecation notice

### Atlassian response body links format change

Atlassian is changing the format of URLs returned in REST API response bodies. The following links will no longer use your site's base URL ([https://your-site.atlassian.net/rest/api/...](https://your-site.atlassian.net/rest/api/...)), and instead use the Atlassian API gateway format ([https://api.atlassian.com/ex/jira/cloud-id/rest/api/...](https://api.atlassian.com/ex/jira/cloud-id/rest/api/...)).

Scripts that read these URLs from a response and use them in subsequent requests within the script environment are not affected.

Scripts may be affected if they:

-   manipulate these URLs directly, or
-   pass these URLs outside the script environment.

If relevant, review any scripts that depend on the current URL format and update accordingly. 

For example:

-   Before: [https://your-site.atlassian.net/rest/api/issue/ABC-123](https://your-site.atlassian.net/rest/api/issue/ABC-123)
-   After: [https://api.atlassian.com/ex/jira/\[cloud-id\]/rest/api/issue/ABC-123](https://api.atlassian.com/ex/jira/[cloud-id]/rest/api/issue/ABC-123)

You can find your cloud ID using one of the methods in [this guide](https://support.atlassian.com/jira/kb/retrieve-my-atlassian-sites-cloud-id/).

Date of change: **14th July 2026**

## Advance notice: ScriptRunner Enhanced Search for Jira Cloud migration to Forge

ScriptRunner Enhanced Search for Jira Cloud is moving to Atlassian’s native Forge platform this year. As part of this transition:

-   Searches will be integrated into the native Jira search bar.
    
-   Forge custom JQL functions will be used.
    

Check out our [Enhanced Search Migration to Forge](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/enhanced-search-migration-to-forge) section for more information.

## Deprecation notice

### Atlassian's Transition to Forge Events and Missing Event Properties

Due to [Atlassian’s platform changes](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps) the transition to native Forge events is required, and the deprecation of the old event model. The new Forge events have a different structure and do not include all properties previously available resulting in missing properties that cannot be retrieved from the Atlassian API.

Check out our [Atlassian's Transition to Forge Events and Missing Event Properties](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties) section for more information.

Date of change: **31st January 2026**

## Deprecation notice

### Atlassian deprecation of Parent and Epic Link fields

Atlassian have announced that parent and child work item associations are being standardized, resulting in the deprecation of the `Epic Link` and `Parent Link` custom fields in the REST API and webhooks.

#### Parent Link deprecation

Date of change: **June 13th 2025**

#### Epic Link deprecation

Date of change: **September 13th 2025**

Check out our [Atlassian Epic and Parent Fields Jira REST API Deprecation](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation) section for more information.

## HAPI method removal notice

**Date of change: August 1st 2025**

The following [HAPI methods](https://adaptavist-api-docs-prod.s3.amazonaws.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/groups/Group.html#add\(java.lang.String\)) are scheduled to be removed on **August 1st, 2025** as they are only available in [HAPI for ScriptRunner DC.](https://docs.adaptavist.com/sr4c/latest/hapi)

-   `Groups.getByName("administrators").add(String accountId)`
-   `Groups.getByName("administrators").add(User accountId)`

## Date change for Atlassian REST API search endpoints deprecation

**Date of change: August 1st 2025**

In March, we announced the [Breaking Change](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation) that search endpoints would be deprecated after May 1st 2025. We're pleased to share an update: the deprecation date has now been extended to **August 1st 2025.**

## Deprecation notice

### Atlassian REST API search endpoints deprecation

**Date of change: May 1st 2025**

The following Jira Platform REST endpoints will be deprecated and no longer available for use after **May 1st 2025**:

-   `GET /rest/api/2|3|latest/search`
-   `POST /rest/api/2|3|latest/search`
-   `POST /rest/api/2|3|latest/search/id`
-   `POST /rest/api/2|3|latest/expression/eval`

Check out our [Atlassian REST API Search Endpoints Deprecation](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation) section for more information.

## Atlassian's new transition experience compatibility with Jira expressions

**Date of change: From April 2025**

Atlassian's [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira is being permanently rolled out from **April 2025**. As a consequence, how your Jira expressions ([Restrict transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [Validate details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)) work will change.

Check out our [Compatibility of Atlassian's New Transition Experience in Jira Workflows](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) section for more information.

## Java version upgrade

**Date of Change: September 2024**

We have upgraded the execution environment where your scripts run from Java 11 to Java 17.

Java 17 is a Long-Term Support (LTS) release, which means it will receive extended support and updates.

### Removed features:

Removal of RMI Activation: The RMI Activation mechanism has been removed in Java 17. If your application relies on this feature, you'll need to find an alternative solution.

Removal of Nashorn JavaScript Engine: The Nashorn JavaScript engine was deprecated in Java 11 and removed in Java 15.

## Groovy version upgrade

**Date of change: October 2023**

We have updated ScriptRunner for Jira Cloud to Groovy 4!

As outlined below, we have identified breaking changes that could affect your scripts. [Adaptavist ScriptRunner Support](https://www.scriptrunnerhq.com/help/support) is available to help you with these issues. 

### Groovy 4 breaking changes

#### Conflicting isser and getter methods

This change was discovered after the first Groovy 4 communication from ScriptRunner for Jira Cloud, so it may require your attention even if you followed our initial instructions. The fix for this must be implemented by **31 December 2023**.

We have created a temporary workaround for this issue. Your scripts will not break until we remove this workaround on 31 December 2023.

If you are using objects of classes that implement conflicting isser and getter methods and you are using the property syntax to get the getter value, your code can break with Groovy 4.

**FIX:** In Groovy 4, if you are using objects of classes that implement conflicting `isser` and `getter` methods, and using the property syntax to get the getter value, you must re-write the logic to use the getter method directly.

For example, in Groovy 2, the `get` call below returns the value of `JsonArray` object (contents of `array` ), and the `JsonNode` class has conflicting `isser` and `getter` methods:

```
def theArray = get("/rest/api/2/issuetype")
        .header('Accept', 'application/json')
        .asJson().body.array
 
theArray // In Groovy 2 this is used to return the value of getArray() method of JsonNode
```

In Groovy 4, `theArray` will be the return value of the method `isArray()` of `JsonNode`. So the above code should be written as:

```
def theArray = get("/rest/api/2/issuetype")
        .header('Accept', 'application/json')
        .asJson().body.getArray()
```

#### Node not found and issues related to getter functions in Groovy

This change was discovered after the first Groovy 4 communication from ScriptRunner for Jira Cloud, so it may require your attention even if you followed our initial instructions. The fix for this must be implemented by **31 December 2023**.

The Groovy 2 import statement `import groovy.util.slurpersupport` breaks with Groovy 4.

**FIX:** To fix your scripts that use that import statement, please replace the package name with `import groovy.xml.slurpersupport``.`

#### Unable to resolve class XmlSlurper

The Groovy 2 import statement `import groovy.util.XmlSlurper` breaks with Groovy 4.

**FIX:** To fix your scripts that use that import statement, please replace it with `import groovy.xml.XmlSlurper`.

#### Unexpected input for ,

The new Groovy 4 parser does not allow empty objects in an array list. Scripts with code like `"a","b",,"c","d"` breaks with Groovy 4. 

**FIX:** To fix your scripts that have empty arrays or lists, please remove the empty objects by adding quote marks (`""`), like `"a","b","","c","d"` . 

Groovy 4 warning

These are the changes in Groovy 4 that we have identified that are in use by our customers, but there is a potential for scripts to break from other changes. Please review the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) to understand the full changes.

#### New URLs for ScriptRunner

Date of change: after 12th April 2021

The URLs used for hosting ScriptRunner for Jira and Confluence Cloud are changing. Customers who use a cloud firewall may encounter problems due to this change.

We advise all customers with a cloud firewall to ensure that access to the following wildcard URL is permitted:

\*.[connect.product.adaptavist.com](http://connect.product.adaptavist.com)

For more information on this change, or if you are having ongoing issues, please contact [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27).

## Java version upgrade

Date of change: 14th October 2020

We have upgraded the execution environment where your scripts run from Java 8 to Java 11.

Java 11 has started removing some modules, therefore libraries relying on such modules may cause errors.

For more details see [Oracle’s upgrade guide](https://docs.oracle.com/en/java/javase/11/migrate/index.html#JSMIG-GUID-C25E2B1D-6C24-4403-8540-CFEA875B994A).

In case of any issues, we can switch the environment to run scripts from your Atlassian URL on Java 8 to allow time to make any script modifications, where necessary.

## Groovy version upgrade

Date of change: 17th June 2020

We will be upgrading the version of Groovy that your scripts run on from [2.4.17](http://groovy-lang.org/changelogs/changelog-2.4.17.html) to [2.5.12](http://groovy-lang.org/changelogs/changelog-2.5.12.html).

We do not anticipate any significant changes in behavior to your scripts.

Release notes are available on the [Groovy website](http://groovy-lang.org/changelogs.html) and some specific breaking changes are described in the [version 5 release notes](http://groovy-lang.org/releasenotes/groovy-2.5.html#Groovy2.5releasenotes-Breakingchanges).

## New URL for frontend assets

Date of change: 24th March 2020

To align with [Atlassian Cloud app security requirements](https://developer.atlassian.com/platform/marketplace/security-requirements-more-info/), the frontend URL for assets (JS, CSS, and images) will be updated imminently. Cloud instances using a cloud firewall may encounter problems due to this change.

We advise all users with a cloud firewall to ensure the following URL is whitelisted:

-   `[assets.sr-cloud.connect.adaptavistlabs.com](http://assets.sr-cloud.connect.adaptavistlabs.com)`
    

For more information on this change, or if you are having ongoing issues, please contact [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27).
