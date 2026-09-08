# Web Panel Locations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments > fragment-locations
- Doc ID: doc-sr4js-442886493
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-panel-locations

Panel locations are places where you can add a custom banner. Banners could be used to display additional information on a particular build, a plan, or the system navigation. For more information, read up on [web panels](https://developer.atlassian.com/server/framework/atlassian-sdk/web-panel-plugin-module/) in the Atlassian documentation.

### Main Jira panel 

The following screenshot displays the panel location you can use to display a banner on the top of every Jira page.

**Hover over the banner** to see the panel location (`jira-banner`):

Panel: location:jira-banner

### Projects page 

The following screenshot displays the panel location you can use to display a banner on the top of every _Project_ page.

**Hover over the banner** to see the panel location (`com.atlassian.jira.jira-projects-plugin:sidebar-panel`):

Panel: location:com.atlassian.jira.jira-projects-plugin:sidebar-panel

### Issues page

The following screenshot displays the panel locations you can use to display banners on _Issue_ pages.

**Hover over the banners** to see the panel locations:

The position of the following panels, in comparison to the other sections on the page, depends on the **Weight** you give to the _UI Fragment_ (weights are defined in the [Atlassian documentation](https://developer.atlassian.com/server/jira/platform/web-panel/#attributes)). For example, the fragment on the left has been given a weight of `400` to sit under the **Attachments** section. If we want it to sit above **Attachments** we would give it a weight of 300.

Panel: location:atl.jira.view.issue.left.context Panel: location:atl.jira.view.issue.right.context

The following locations are referenced in the image above:

-   `atl.jira.view.issue.left.context`
-   `atl.jira.view.issue.right.context`

### Service desk portal

The following screenshot displays the panel locations you can use to display banners in the _Service Desk_ portal.

**Hover over the banners** to see the panel locations:

Panel: location:servicedesk.portal.header location:servicedesk.portal.subheader location:servicedesk.portal.footer

The following locations are referenced in the image above:

-   `servicedesk.portal.header`
-   `servicedesk.portal.subheader`
-   `servicedesk.portal.footer`

### Administration page

The following screenshot displays the panel location you can use to display a banner on the _Administration_ page.

**Hover over the banner** to see the panel location (`system.admin.decorator.header`):

Panel: location:system.admin.decorator.header

  

* * *

## Related content

-   [Web Panel Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)
-   [Web Item Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-item-locations)
-   [Fragments](https://docs.adaptavist.com/display/_PK/SR4JS/script-fragments)
