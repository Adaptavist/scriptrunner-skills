# Script Registry

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442887704
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-registry

The Script Registry allows you to search your ScriptRunner custom scripts, view type-checking errors or deprecation warnings, and export all scripts and configurations on your instance.

Type-checking errors do not mean your code will not run - as we compile it statically and Groovy is a dynamic language, there may be false positives.

Script Registry lists scripts, their type, content, and location. Each script undergoes [Static Type Checking](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/static-type-checking) to ensure it is written correctly.

We recommend that the Script Registry be used on staging instances after upgrading Jira to validate that all necessary APIs are available.

## Using the Script Registry

1.  From ScriptRunner, navigate to **Built-in Scripts > Script Registry**. Alternatively, you can select the **Ellipsis Menu > Script Registry.**  
    ![Image of script registry location](/sr4js/files/latest/442887704/442887705/1/1758746874000/Script_registry.png)
    
2.  Click **Run** to view all configured scripts. All Groovy scripts on the Jira instance are listed.
    
3.  Scripts are sorted into category tabs, showing the number of scripts in each category. Click on a tab to display all scripts of that kind.  
    ![Image example of the results](/sr4js/files/latest/442887704/442887710/1/1758746874000/Script_registry_results.png)
    

## Exporting your scripts

Script export compatibility

This feature is available with ScriptRunner 8.54+, 9.19+, and 10.0+.

From the Script Registry, you can export all ScriptRunner scripts, configurations, saved JQL filters with ScriptRunner JQL functions, and custom fields from your instance.

![Image of the export scripts button](/sr4js/files/latest/442887704/441364887/1/1750354001000/Script_export.png)

What do we mean by "scripts"?

In this context, "scripts" encompass a broader range of elements than typical custom script files. Specifically, we include:

-   All scripts within your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).
-   All configured custom and built-in Jobs, Listeners, Fields, Behaviours, UI Fragments, REST Endpoints, Resources, and Workflow functions.
-   All saved JQL filters that include ScriptRunner JQL functions.
-   Custom fields.

It's important to note that even configuration-only elements are considered "scripts" for the purpose of this export. For example, if you have a Behaviour or Script Field configured without requiring a custom script, it will still be included in the export as a "script".

### Exporting all scripts

When you select **Export all scripts** from the Script Registry the following will be exported as a .zip file:

-   All of your scripts from your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) (as .groovy files).
-   All of your configured Jobs, Listeners, Fields, Behaviours, UI Fragments, REST Endpoints, Resources, and Workflow functions (as .json files).
-   All saved JQL filters that include ScriptRunner JQL functions. Filters that do not contain ScriptRunner JQL functions are excluded from the export.
-   All of your Custom fields (as a .json file). Located within a dedicated **Instance Information** folder, this file lists all custom fields on your instance, providing details such as the custom field name, type, and ID.
-   A .csv file containing all configured scripts, and saved JQL filters with ScriptRunner JQL functions, in your instance (excluding script roots). This .csv file includes the following columns:
    -   **ID**: Unique identifier of the configured script.
    -   **Type**: Feature type of the script (for example Listener, Job, Behaviour, etc).
    -   **Name**: User-defined name of the script.
    -   **Associated Scripts**: Number of custom scripts linked to this configuration.
    -   **Project Mappings**: List of projects the script is mapped to.
    -   **Last Run**: Most recent execution date and time (if applicable).

If the export doesn't start automatically, please check your browser settings and try again.

Auditing your scripts

The exported .csv file is particularly useful for auditing your scripts before migration. Use it to identify unused scripts (check the **Last Run** column), duplicates, and scripts associated with inactive projects. See our [Audit your Jira instance](https://docs.adaptavist.com/sr4js/latest/best-practices/audit-your-jira-instance-using-scriptrunner#-audit-your-scripts) page for more details.

### Exporting active scripts only

You can select **Export active scripts Only** to make sure only active scripts are exported from your instance. Any **Disabled** scripts will be filtered out from this export. This does not include scripts in your script roots, or saved JQL filters that include ScriptRunner JQL functions; these will always be included in the export file.   
![Image of Export active scripts only button](/sr4js/files/latest/442887704/441364888/1/1750352594000/Active_only.png)
