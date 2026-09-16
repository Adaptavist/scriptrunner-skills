# Web Item Locations

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Fragments > Fragment Locations
- Doc ID: doc-sr4js-923bf73f-5353-4715-857b-95e5f356eac4-a3fd46960fb4dcb0
- Source: https://docs.adaptavist.com/sr4js/latest/features#fragments--en#fragment-locations--en#web-item-locations--en

Web item locations are where you can put links or buttons. Web item fragment locations can typically be found in menus, so you can add more options within that menu. There are also web item fragment locations you can use to add buttons to pages. For more information, read up on [web items](https://developer.atlassian.com/server/framework/atlassian-sdk/web-item-plugin-module/) in the Atlassian documentation.

Note: We have provided the UI fragments below each image for you to copy and paste (if required).

## Main Jira menus

### Dashboad menu

The following locations are referenced in the image above:

1.  home\_link/dashboard\_link\_main
2.  home\_link/dashboard\_link\_manage

### Projects menu

The following locations are referenced in the image above:

1.  browse\_link/project\_current
2.  browse\_link/project\_history\_main
3.  browse\_link/project\_types\_main
4.  browse\_link/project\_view\_all
5.  browse\_link/project\_new

### Issues menu

The following locations are referenced in the image above:

1.  find\_link/issues\_new
2.  find\_link/archived\_issues
3.  find\_link/issues\_history\_main
4.  find\_link/bulk\_create\_section
5.  find\_link/issues\_filter\_main
6.  find\_link/issues\_manage\_filters

### Boards menu

The following locations are referenced in the image above:

1.  greenhopper\_menu/greenhopper\_menu\_dropdown
2.  greenhopper\_menu/greenhopper\_menu\_dropdown\_recent

### Plans menu

The following locations are referenced in the image above:

1.  plugins-jira-webitem-main/plugins-jira-websection-recentlyviewed
2.  plugins-jira-webitem-main/plugins-jira-websection-manage-plans
3.  plugins-jira-webitem-main/plugins-jira-websection-create
4.  plugins-jira-webitem-main/rm-roadmaps-websection-admindocs

### Insights/Assets menu

The following locations are referenced in the image above:

1.  rlabs\_insight\_topmenu\_link/rlabs\_iam\_menu\_section
2.  rlabs\_insight\_topmenu\_link/rlabs\_insight\_recent\_object\_section
3.  rlabs\_insight\_topmenu\_link/rlabs\_insight\_recent\_objectschema\_section
4.  rlabs\_insight\_topmenu\_link/rlabs\_insight\_general\_section
5.  rlabs\_insight\_topmenu\_link/rlabs\_insight\_info\_section

### Help menu

The following locations are referenced in the image above:

1.  system.user.options/jira-help

### Profile menu

The following locations are referenced in the image above:

1.  system.user.options/personal
2.  system.user.options/system
3.  system.user.options/set\_my\_jira\_home

### Jira menu button

You can add an additional link/button to Jiras main menu using the following fragment location ( `system.top.navigation.bar`):

## Browse projects page

You can add a link/button to the _Browse projects_ page using the following fragment location ( `system.browse.projects.operations`):

## Project navigation bar

The following screenshot displays the web item locations you can find in the project navigation bar.

The following locations are referenced in the image above:

1.  jira.project.sidebar.navigation
2.  jira.project.sidebar.plugins.navigation
3.  servicedesk.project.sidebar.navigation.secondary (SERVICE DESK ONLY)
4.  jira.project.sidebar.settings.navigation

## Issue page

### More

The following locations are referenced in the image above:

1.  operations-work
2.  greenhopper\_issue\_dropdown
3.  operations-archive
4.  operations-attachments
5.  operations-voteswatchers
6.  operations-subtasks
7.  operations-operations
8.  operations-delete

Note: In addition to the fragments listed above the following fragment location is available to add web items to the top and bottom of the More menu:

-   Item:operations-top-level
-   Item:operations-manual-triggers

### Workflow

The following locations are referenced in the image above:

1.  transitions-all

### Admin

The following locations are referenced in the image above:

1.  operations-fields
2.  operations-admin-helper

### Issue page button

You can add an additional link/button to the Issues page using the following web item location ( `operations-restore`):

## System Dashboard page

The following screenshot displays the web item locations you can find on the System Dashboard page.

The following locations are referenced in the image above:

1.  gadgets.dashboard.menu
2.  gadgets.dashboard.tools.menu

## Related content

-   [Web Item Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)
-   [Web Panel Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-panel-locations)
-   [Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments)
