# Configuration Exporter

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-143957ea-9f98-4b67-82d8-21d96d796dfa-4af51a2e97b5e30f
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#configuration-exporter--en

Use _Configuration Exporter_ to export extension configuration information to a descriptor YAML file. The YAML file contains the information required to configure built-in extension points like:

-   Listeners
-   Hooks
-   Macros
-   UI fragments

## Run the script

Using the YAML file within script plugins when migrating from one instance to another allows scripts to be automatically configured. Automatic configuration of scripts saves time and ensures consistency across instances.

Follow these steps to run the built-in script:

1.  Navigate to Built-in Scripts > Configuration Exporter within ScriptRunner.
2.  Select the items you want to generate the YAML for in Export What.
    
    Items with configurations automatically appear here. Multiple items can be exported to one YAML file.
    
    Tip: Make sure each thing you are exporting has a note. For example, if you are importing a REST Endpoint, navigate to Built-In Scripts > REST Endpoint to add a Note if there is one missing.
    
3.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, a code snippet appears.
    
4.  Copy this code snippet and paste it into your `scriptrunner.yaml` file.

Note: You can manually edit the code yourself to add more items, though it's generally easier to re-generate the YAML file using the _Configuration Exporter_ script.

For more information on using YAML files to create script plugins see [Create a Script Plugin](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin).
