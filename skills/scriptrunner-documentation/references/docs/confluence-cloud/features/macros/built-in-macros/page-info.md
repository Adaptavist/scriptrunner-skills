# Page Info

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > built-in-macros
- Doc ID: doc-sr4cc-114204716
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/page-info

View [Macro Migration Tips](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips) for more information about this macro from Confluence Server or Data Center. 

The _Page Info_ macro makes it easy to display information about the page it is used on. This could include information such as page versions, differences in versions, or modification information.

When you are editing or creating a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to add page info.

1.  Select **Insert**, and then search _Page_.
    
2.  Select the **Page Info** macro from the provided list.  
    ![](/sr4cc/files/latest/114204716/563708398/1/1782316166000/add_page_info_macro.png)
3.  Complete the **Information Type** field.
    
    See the _Supported values_ section below for information on what can be added to this field.
    
    ![](/sr4cc/files/latest/114204716/563708397/1/1782316223000/page_info_type_field.png)
    
      
    
4.  Click **Save**. The macro appears on the page.  
    
    Page Info macros can be added multiple times to a single page.
    
5.  **Publish** (or **Update**) the page to save changes.

### Supported values

Supported values for the **Information Type** field follow:

_Information Type_

Description

**_Commenters_**

A comma-separated list of the users who have commented on the page.

**_Created By_**

The user who created the page.

**_Create Date_**

The date the page was created.

**_Current Version_**

The most recent version number of the page.

**_Diffs_**

A comma-separated list of version number links. These are clickable to view the differences between versions.

**_Labels_**

A comma-separated list of labels. These are clickable to view other pages that possess the same label.

**_Modified By_**

The user who last modified the page.

**_Modified Date_**

The date the page was last modified.

**_Modified Users_**

A comma-separated list of all the users who have modified the page.

_**Page id**_

The id of the current page.

_**Participants**_

A comma-separated list of the users who have modified or commented on the page.

_**Title**_

The title of the page.

_**Versions**_

A comma-separated list of version numbers. These are clickable to view the selected version.

The following image shows the output when _Create Date, Modified Users, and Modified By_ are selected for the **Information Type** field. In this example, the three information types were put into a table with readable titles.

![](/sr4cc/files/latest/114204716/123736540/1/1634077713000/image2021-10-12_11-11-12.png)

## Tips for the Page Info Macro

-   **Displaying Versions and Diffs**: The versions and differences ("Diffs") are clickable to view a particular version and difference.
    
    ![](/sr4cc/files/latest/114204716/114204735/1/1624390051000/diffsOut.png)
