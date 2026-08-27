# Deprecation Notices Overview

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes
- Doc ID: doc-sr4jc-371033527
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview

Use this page to view a summary of Atlassian endpoint deprecation notices. We have summarized the details so you can use it as a quick reference when checking for specific deprecations, with links to both Atlassian's and ScriptRunner for Jira Cloud's notices.

Deprecation Reports

ScriptRunner for Jira Cloud provides you with [Deprecation Reports](https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview/deprecation-reports) that highlight the usage of Atlassian's deprecated endpoints, fields, and event types in your instance.

  

Release Note Date/Link

Deprecation Date

What's being deprecated?

Notes

**[July 2026](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes)**

July 14th 2026

Atlassian is changing the format of URLs returned in REST API response bodies.

The following links will no longer use your site's base URL ([https://your-site.atlassian.net/rest/api/...](https://your-site.atlassian.net/rest/api/...)), and instead use the Atlassian API gateway format ([https://api.atlassian.com/ex/jira/cloud-id/rest/api/...](https://api.atlassian.com/ex/jira/cloud-id/rest/api/...)).

Scripts may be affected if they:

-   manipulate these URLs directly, or
-   pass these URLs outside the script environment.

**Please review any relevant scripts that depend on the current URL format and update them accordingly.** 

  

**[October 2025](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties)**

January 31st 2026

The transition to native Forge events is required due to [Atlassian’s platform changes](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps) and the deprecation of the old event model. These new Forge events have a different structure and do not include all properties previously available. Some event properties are now missing and cannot be retrieved from the Atlassian API.

**Please review and update any [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) that depend on the missing properties, as there is no workaround.**

  

**[May 2025](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation)**

June 13th 2025

As per [Atlassian's changelog notification](https://developer.atlassian.com/cloud/jira/platform/changelog/#CHANGE-509), the `Parent Link` field will be deprecated from some endpoint responses and webhook events and no longer available for use after **June 13th 2025.**

This deprecation affects how the `Parent Link` field is referenced in REST APIs. You can replace this field with the `Parent` field.

**Please ensure your custom scripts or Marketplace apps no longer reference this field.** 

The original deprecation date was announced as May 31st 2025, but has been extended to June 13th 2025.

Relates to company-managed and team-managed projects.

**[May 2025](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation)**

September 13th 2025

As per [Atlassian's changelog notification](https://developer.atlassian.com/cloud/jira/platform/changelog/#CHANGE-509), the `Epic Link` field will be deprecated from some endpoint responses and webhook events and no longer available for use after **September 13th 2025.**

This deprecation affects how the `Epic Link` field is referenced in REST APIs. You can replace this field with the `Parent` field.

**Please ensure your custom scripts or Marketplace apps no longer reference this field.** 

The original deprecation date was announced as May 31st 2025, but has been extended to September 13th 2025.

Relates to company-managed and team-managed projects.

**[March 2025](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation)**

August 1st 2025

As per [Atlassian's changelog notification](https://developer.atlassian.com/changelog/#CHANGE-2046), the following Jira Platform REST endpoints will be deprecated and no longer available for use after **August 1st 2025**:

Endpoints 

Atlassian link

`[GET /rest/api/2|3|latest/search](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#id-.AtlassianRESTAPISearchEndpointsDeprecationvCurrent-GETsearch)`

[Search for issues using JQL (GET)](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-search/#api-rest-api-3-search-get)

`[POST /rest/api/2|3|latest/search](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#id-.AtlassianRESTAPISearchEndpointsDeprecationvCurrent-POSTsearch)`

[Search for issues using JQL (POST)](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-search/#api-rest-api-3-search-post)

`[POST /rest/api/2|3|latest/search/id](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#id-.AtlassianRESTAPISearchEndpointsDeprecationvCurrent-POSTid)`

[Search issue IDs using JQL](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-search/#api-rest-api-3-search-id-post)

`[POST /rest/api/2|3|latest/expression/eval](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#id-.AtlassianRESTAPISearchEndpointsDeprecationvCurrent-POSTeval)`

[Evaluate Jira expression](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-jira-expressions/#api-rest-api-3-expression-eval-post)

  

The original deprecation date was announced as May 1st 2025. However, an extension has been granted for ScriptRunner users until August 1st 2025.
