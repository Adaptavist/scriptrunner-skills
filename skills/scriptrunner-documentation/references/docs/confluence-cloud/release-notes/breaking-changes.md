# Breaking Changes

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: release-notes
- Doc ID: doc-sr4cc-107986852
- Source: https://docs.adaptavist.com/sr4cc/latest/release-notes/breaking-changes

## Groovy Version Upgrade

**Date of Change: 4 October 2023**

We updated ScriptRunner for Confluence Cloud to Groovy 4!

We have identified breaking changes that could affect your scripts. [Adaptavist ScriptRunner Support](https://www.scriptrunnerhq.com/help/support) is available to you for these issues. 

### Groovy 4 breaking changes

#### Conflicting isser and getter methods

This change was discovered after the first Groovy 4 communication from ScriptRunner for Confluence Cloud, so it may require your attention even if you followed our initial instructions.

If you are using objects of classes that implement conflicting isser and getter methods and you are using the property syntax to get the getter value, your code can break with Groovy 4.

Temporary workaround

We have created a temporary workaround for this issue. Your scripts will not break until we remove this workaround. Please work on updating the affected scripts. When we have determined when this workaround will be removed, we will update the documentation.

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

This change was discovered after the first Groovy 4 communication from ScriptRunner for Confluence Cloud, so it may require your attention even if you followed our initial instructions.

The Groovy 2 import statement `import groovy.util.slurpersupport` breaks with Groovy 4.

**FIX:** To fix your scripts that use that import statement, please replace the package name with `import groovy.xml.slurpersupport``.`

#### Unable to resolve class XmlSlurper

The Groovy 2 import statement `import groovy.util.XmlSlurper` breaks with Groovy 4.

**FIX:** To fix your scripts that use that import statement, please replace it with `import groovy.xml.XmlSlurper`.

#### Unexpected input for ,

The new Groovy 4 parser does not allow empty objects in an array list. Scripts with code like `"a","b",,"c","d"` breaks with Groovy 4. 

**FIX:** To fix your scripts that have empty arrays or lists, please remove the empty objects by adding quote marks (`""`), like `"a","b","","c","d"` . 

Groovy 4 warning

These are the four changes in Groovy 4 that we have identified that are in use by our customers, but there is a potential for scripts to break from other changes. Please review the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) to understand the full changes.

## New URLs for ScriptRunner

**Date of Change: after 12th April 2021**

The URLs used for hosting ScriptRunner for Jira and Confluence Cloud are changing. Cloud instances using a cloud firewall may encounter problems due to this change.

We advise all users with a cloud firewall to ensure that access to the following wildcard URL is permitted:

-   `[connect.product.adaptavist.com](http://connect.product.adaptavist.com/)`

For more information on this change, or if you are having ongoing issues, please contact [Adaptavist Support](https://productsupport.adaptavist.com/servicedesk/customer/portal/23).

## Groovy Version Upgrade

**Date of Change: 17th June 2020**

We upgraded the version of Groovy that your scripts run on from [2.4.17](http://groovy-lang.org/changelogs/changelog-2.4.17.html) to [2.5.12](http://groovy-lang.org/changelogs/changelog-2.5.12.html).

We do not anticipate any significant changes in behaviour to your scripts.

Release notes are available on the [Groovy website](http://groovy-lang.org/changelogs.html) and some specific breaking changes are described in the [version 5 release notes](http://groovy-lang.org/releasenotes/groovy-2.5.html#Groovy2.5releasenotes-Breakingchanges).

## New URL for Frontend Assets

**Date of Change: 24th March 2020**

To align with [Atlassian Cloud app security requirements](https://developer.atlassian.com/platform/marketplace/security-requirements-more-info/), the frontend URL for assets (JS, CSS, and images) were updated. Cloud instances using a cloud firewall may encounter problems due to this change.

We advise all users with a cloud firewall to ensure the following URL is allowlisted:

-   `[assets.sr-cloud.connect.adaptavistlabs.com](http://assets.sr-cloud.connect.adaptavistlabs.com)`
    

For more information on this change, or if you are having ongoing issues, please contact [Adaptavist Support](https://productsupport.adaptavist.com/servicedesk/customer/portal/40).
