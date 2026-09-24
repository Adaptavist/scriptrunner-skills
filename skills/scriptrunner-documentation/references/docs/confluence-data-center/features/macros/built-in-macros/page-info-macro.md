# Page Info Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4c-e7b5afef-c3c4-42e4-a6c5-1a6e4d348c93-c9b922f13ad1b59a
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#page-info-macro--en

The Page Info macro makes it easy to display information about the page it is used on.

This could include information such as page versions, differences in versions, contributors and many other options listed below.

## Usage

1.  Click Insert > Other Macros.
    
2.  Select the Page Info macro from the provided list.
    
3.  Complete the desired fields:
    
    | Parameter | Description | Type | Default | Required |
    | --- | --- | --- | --- | --- |
    | Information Type | See the supported _Information Types_ table below. | enum | _Commenters_ | Yes |
    | Page | The name of the page whose information you want displayed. If no name is given, then the current page is assumed.Options _$self_ and _$parent_ can be used to refer to the current page and the parent page respectively. | string | _$self_ | No |
    | Date Format | Set the display format for the date and time displayed. When no date is to be displayed this parameter has no effect.This uses Confluence's DateFormatter API, which in turn uses a [java.text.SimpleDateFormatter](https://docs.oracle.com/javase/8/docs/api/java/text/SimpleDateFormat.html) . See the Oracle documentation on how to create your own custom date format string. | string | _MMM dd, yyyy - hh:mm_ | No |
    | Type a | Show list information in different formats.Options are _Flat_ to display a comma separated list or _List_ to display a bullet list. | enum | _Flat_ | Yes |
    | Prefix | Inserts a prefix before the version number. This field has no effect on display types without a version number. | string | _None_ | No |
    | Reverse Order | Reverse the list item when the option is selected. | Checkbox | Unchecked | No |
    | Count | Limit the number of items shown in a list (eg. versions and diffs). | int | None | No |
    | Show Comments | Display the comments that accompany an update.<br>Note: If you select this option, the comments refer to the page version comments (entered in the What Did You Change? field) which can be added before saving the page. | Checkbox | Unchecked | No |
    | Show Versions | Display the version numbers. | Checkbox | Checked | No |
    
    Supported values for the _Information Type_ field follow:
    
    | _Information Type_ | Description |
    | --- | --- |
    | Created By | The user who created the page. |
    | Commenters | A comma-separated list of the users who have commented on the page. |
    | Create Date | The date the page was created. |
    | Current Version | The most recent version number of the page. |
    | Diffs | A comma-separated list of version number links. These are clickable to view the differences between versions. |
    | Labels | A comma-separated list of labels. These are clickable to view other pages that possess the same label. |
    | Modified By | The user who last modified the page. |
    | Modified Date | The date the page was last modified. |
    | Modified Users | A comma-separated list of all the users who have modified the page. |
    | Page ID | The ID of the current page. |
    | Participants | A comma-separated list of the users who have modified or commented on the page. |
    | Title | The title of the page. |
    | Tiny URL | The name of the page displayed as a Tiny URL link to the specified page. |
    | Versions | A comma separated list of version numbers. These are clickable to view the selected version. |
    
    The following image is an example of a selected field:
    
    The following image shows the output when Created By is selected for the Information Type field. In this example, the page was created by the admin.
    

## Example

The following two images show how the Page Info macro can be used to populate information.

The input:

The output:

## Tips for the Page Info Macro

-   Formatting Dates: The Page Info macro supports standard date formats which allows the user to format the date with various combinations. For example the following screenshot shows how to use "dd-MMM-yyyy" as the date format.
    
    Examples of formatted dates follow:
    
    | Page Edit Mode | Page Output |
    | --- | --- |
    |  |  |
    
-   Displaying Versions and Diffs: The versions and differences ("Diffs") are clickable to view a particular version and difference.
    
-   View Page Information for a Different Page: Provide the name of the page for which information will be displayed. The following example shows the page creator for page P2. It is also possible to use "$parent" \[without double quote\] to refer to the parent page of the page that contains the macro.
