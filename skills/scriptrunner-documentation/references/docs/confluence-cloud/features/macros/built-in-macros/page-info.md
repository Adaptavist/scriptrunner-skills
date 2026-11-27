# Page Info

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-aa45744a-b51f-4102-9565-677b0593a1da-e3cde59ece242da8
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/page-info

Instructions for the Page Info macro.

Tip: View [Macro Migration Tips](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips) for more information about this macro from Confluence Server or Data Center.

The _Page Info_ macro makes it easy to display information about the page it is used on. This could include information such as page versions, version differences, or modification details.

When you are editing or creating a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to add page info.

1.  Select Insert, and then search Page.
2.  Select the Page Info macro from the provided list.
3.  Complete the Information Type field:
    
    Tip: See the _Supported values_ section below for information on what can be added to this field.
    
4.  Click Save.
    
    Note: Page Info macros can be added multiple times to a single page.
    
    The placeholder macro appears on the page.
    
5.  Publish (or Update) the page to see your changes.

## Supported values

Supported values for the Information Type field follow:

<table class="table" id="page-info-supported-values--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="page-info-supported-values--en__generated-table-id-1__entry__1">Information Type</th><th class="entry" id="page-info-supported-values--en__generated-table-id-1__entry__2">Description</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1"><em class="ph i">Commenters</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1">A comma-separated list of the users who have commented on the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Created By</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">The user who created the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Create Date</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">The date the page was created.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Current Version</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">The most recent version number of the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Diffs</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">A comma-separated list of version number links. These are clickable to view the differences between versions.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Labels</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">A comma-separated list of labels. These are clickable to view other pages that possess the same label.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Modified By</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">The user who last modified the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Modified Date</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">The date the page was last modified.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 "><em class="ph i">Modified Users</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 ">A comma-separated list of all the users who have modified the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1"><em class="ph i">Page id</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1">The ID of the current page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1"><em class="ph i">Participants</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1">A comma-separated list of the users who have modified or commented on the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1"><em class="ph i">Title</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1">The title of the page.</td></tr><tr class="row"><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1"><em class="ph i">Versions</em></td><td class="entry" headers="page-info-supported-values--en__generated-table-id-1__entry__1 page-info-supported-values--en__generated-table-id-1__entry__2 " colspan="1">A comma-separated list of version numbers. These are clickable to view the selected version.</td></tr></tbody></table>

### Example

The following image shows the output when _Create Date, Modified Users,_ and _Modified By_ are selected for the Information Type field. In this example, the three types of information were put into a table with clear titles.

## Tips for the Page Info Macro

-   Displaying Versions and Diffs: The versions and differences (diffs) are clickable to view a particular version and difference.
