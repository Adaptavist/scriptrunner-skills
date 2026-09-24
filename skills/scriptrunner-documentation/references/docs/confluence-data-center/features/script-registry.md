# Script Registry

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-c404153c-e5a8-444c-b7e8-60933d50df58-8a254c688a26e624
- Source: https://docs.adaptavist.com/sr4c/latest/features#script-registry--en

The Script Registry allows you to search your ScriptRunner custom scripts, view type-checking errors or deprecation warnings, and export all scripts and configurations on your instance.

Warning: Type-checking errors do not necessarily mean your code will not run, as we compile it statically, and Groovy is a dynamic language, which may result in false positives.

The Script Registry lists scripts, their type, content, and location. Each script undergoes [Static Type Checking](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/static-type-checking) to ensure it is written correctly.

## Access the Script Registry

To access the Script Registry:

1.  Select Browse from the _ScriptRunner_ menu options.
2.  Select Script Registry from the tabbed menu options
3.  Click Run to bring up the items in the registry.
    
    All Groovy scripts on the instance are listed.
    
4.  Scripts are sorted into category tabs, showing the number of scripts in each category.
    
    Click on a tab to display all scripts of that kind.
    

Note: Additional path

You can also navigate to the Script Registry by selecting Built-in Scripts from the _ScriptRunner_ menu and then searching for `Script Registry` at the top of the page.

## Export

From the Script Registry, you can export all ScriptRunner scripts and configurations from your instance.

Note: Defining Scripts

In this context, "scripts" encompass a broader range of elements than typical custom script files. Specifically, we include:

-   All scripts within your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).
-   All configured custom and built-in Jobs, Listeners, UI Fragments, REST Endpoints, Resources, and Macros.
-   Custom fields.

It's important to note that even configuration-only elements are considered "scripts" for this export.

### Export all scripts

When you select Export all scripts from the Script Registry, the following will be exported as a .zip file:

-   All of your scripts from your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) (as .groovy files).
-   All of your configurations (as .json files).
-   A .csv file containing all configured scripts in your instance (excluding script roots). This .csv file includes the following columns:
    -   ID: Unique identifier of the configured script.
    -   Type: Feature type of the script (for example, Listener, Job, Behaviour, etc).
    -   Name: User-defined name of the script.
    -   Associated Scripts: Number of custom scripts linked to this configuration.
    -   Last Run: Most recent execution date and time (if applicable).

Warning: Troubleshooting

If the export doesn't start automatically, please check your browser settings and try again.

### Export active scripts only

You can select Export active scripts Only to make sure only active scripts are exported from your instance.

Any _Disabled_ scripts will be filtered out from this export. This does not include scripts in your script roots; these will always be included in the export file.
