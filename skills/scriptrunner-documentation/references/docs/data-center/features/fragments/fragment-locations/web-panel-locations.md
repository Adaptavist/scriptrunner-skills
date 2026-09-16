# Web Panel Locations

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Fragments > Fragment Locations
- Doc ID: doc-sr4js-46f8ce58-1f98-4020-90e2-455a9317c016-d4b814730ca364b6
- Source: https://docs.adaptavist.com/sr4js/latest/features#fragments--en#fragment-locations--en#web-panel-locations--en

Panel locations are places where you can add a custom banner. Banners could be used to display additional information on a particular build, a plan, or the system navigation. For more information, read up on [web panels](https://developer.atlassian.com/server/framework/atlassian-sdk/web-panel-plugin-module/) in the Atlassian documentation.

## Main Jira panel

The following screenshot displays the panel location you can use to display a banner on the top of every Jira page

-   jira-banner

## Projects page

The following screenshot displays the panel location you can use to display a banner on the top of every Project page.

-   com.atlassian.jira.jira-projects-plugin:sidebar-panel

## Issues page

The following screenshot displays the panel locations you can use to display banners on Issue pages.

Tip: The position of the following panels, in comparison to the other sections on the page, depends on the Weight you give to the UI Fragment (weights are defined in the [Atlassian documentation](https://developer.atlassian.com/server/jira/platform/web-panel/#attributes)). For example, the fragment on the left has been given a weight of 400 to sit under the Attachments section. If we want it to sit above Attachments we would give it a weight of 300.

The following locations are referenced in the image above:

1.  atl.jira.view.issue.left.context
2.  atl.jira.view.issue.right.context

## Service desk portal

The following screenshot displays the panel locations you can use to display banners in the Service Desk portal.

The following locations are referenced in the image above:

1.  servicedesk.portal.header
2.  servicedesk.portal.subheader
3.  servicedesk.portal.footer

## Administration page

The following screenshot displays the panel location you can use to display a banner on the Administration page.

-   system.admin.decorator.header

## Related content

-   [Web Panel Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)
-   [Web Item Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)
-   [Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments)
