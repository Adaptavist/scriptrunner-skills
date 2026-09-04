# Identifying Deprecated Methods

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes > jira-11-search-api-upgrade-guide
- Doc ID: doc-sr4js-441364990
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/identifying-deprecated-methods

In Jira Data Center version 10.4, Atlassian introduced a [new Search API](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html), transitioning from Lucene to OpenSearch. Many methods related to JQL functions will be deprecated, and if you use them in your scripts, you'll need to update to their Search API equivalents. This page guides you to relevant sections of the Atlassian documentation to help you quickly identify the affected methods.

We will continue to update and expand this information as we learn more. Please check back regularly for the most current guidance.

## Key documentation

Atlassian has published tables comparing old Lucene methods with their direct replacements in the new Search API:

-   [Search API upgrade guide](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html)
-   [Search API deprecations and upgrade guide for Jira 11](https://confluence.atlassian.com/adminjiraserver/search-api-deprecations-and-upgrade-guide-for-jira-11-1573486929.html)

Depending on your browser and screen resolution, the entirety of the table may not be visible when landing on the page.

The above pages do not cover all deprecated methods. For a complete list of affected methods, consult the Atlassian Javadoc to get all the methods:  

In the Javadoc, entries for deprecated methods or classes often include notes with links to their replacement classes in the Search API.

-   [Javadoc - Atlassian Jira - 10.5.0 API](https://docs.atlassian.com/software/jira/docs/api/10.5.0/index.html)
