# Change Dashboard, Filter, or Board Ownership

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442887188
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/change-dashboard-filter-or-board-ownership

Use the _Change Dashboard, Filter, or Board Ownership_ built-in script to change the owner of the selected [dashboards](https://confluence.atlassian.com/adminjiraserver100/managing-dashboards-1442846260.html), [filters](https://confluence.atlassian.com/adminjiraserver100/managing-filters-1442846255.html), and [board](https://confluence.atlassian.com/jirasoftwareserver/what-is-a-board-938845235.html)s from one user to another.

For example, if a team member has left your company, you could use this built-in script to transfer all dashboard and filter ownerships at once before deactivating the user.

Depending on the configuration and share settings, a user might still have access to a dashboard, filter, or board after ownership has changed.

## Dashboard ownership transfer rules

Dashboards comprise gadgets or portlets that use filters. When dashboard ownership changes, any filters within the dashboard will error; therefore the filter ownership needs to be changed as well. This built-in script changes ownership of any filters contained within the affected dashboard using the following rules:

-   If the dashboard being modified includes filters with the same owner, the filter owner is also modified.
    
-   If a different user owns the filter and the target user has permission to view the filter, no change is made.
    
-   If a different user owns the filter and the target user does not have permission to view the filter, the filter is shared globally.
    

## Using this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts > Change dashboard, filter, or board ownership**.
2.  For **From user**, select username of the person you wish to transfer ownership away from.
    
3.  For **To user**, select username of the person you wish to transfer ownership away to.
    
    In the **Dashboards**, **Filters**, and **Boards** fields, all dashboards, filters or boards by the user specified in **From User** are listed.
    
4.  Select the name of the dashboard/s you want to transfer to the new owner.
    
5.  Select the name of the filter/s you want to transfer to the new owner.
6.  Select the name of the board/s you want to transfer to the new owner.
    
    To select multiple dashboards, filters, and boards, hold Ctrl (Command on macOS) while selecting options.
    
    ![Image of the Change Dashboard, Filter, or Board Ownership built-in script](/sr4js/files/latest/442887188/442887192/1/1758746784000/Change_dashboard_filter_board_ownership.png)
    
7.  Select **Preview** to see an overview before committing changes. Select **Run** to change ownership.
