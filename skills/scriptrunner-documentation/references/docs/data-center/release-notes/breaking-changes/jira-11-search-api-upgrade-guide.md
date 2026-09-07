# Jira 11 Search API Upgrade Guide

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4js-441364872
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide

In Jira Data Center version 10.4, Atlassian has introduced a new Search API, marking a significant overhaul of the search functionality by transitioning from Lucene to OpenSearch. This update includes the deprecation of certain methods, reflecting a shift in the underlying search mechanism to enhance performance and scalability. Lucene will be removed from public APIs in Jira 11. [Atlassian documents](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html) Lucene-specific API and components that have been deprecated in favor of the platform-agnostic search API. 

## What does it mean?

Some of your scripts may break when Jira 11 is released. To avoid any downtime in your scripts, we recommend you review Atlassian's documentation on [Preparing for Jira 11](https://confluence.atlassian.com/adminjiraserver/preparing-for-jira-11-0-1557069833.html) before upgrading to Jira 11. This documentation offers crucial information on identifying and updating scripts that may be affected by the Jira 11 update.

See also our guides linked below to assist you in rewriting your affected scripts:

We will continue to update and expand this information as we learn more. Please check back regularly for the most current guidance.

-   [Identifying Deprecated Methods](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/identifying-deprecated-methods)
-   [Upgrade Custom JQL Functions](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/upgrade-custom-jql-functions)
-   [Writing to the Index](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/writing-to-the-index)

Remember to thoroughly test all updated scripts in a non-production environment before implementing them in your live Jira instance.

These guides are not complete and may not cover all scenarios. For the most up-to-date and comprehensive information, we strongly advise you to refer to the official Atlassian documentation.
