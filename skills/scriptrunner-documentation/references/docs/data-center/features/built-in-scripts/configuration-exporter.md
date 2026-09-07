# Configuration Exporter

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-101624063
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/configuration-exporter

Use _Configuration Exporter_ to export extension configuration information to a descriptor YAML file. The YAML file contains the information required to configure built-in extension points like:

-   Listeners
    
-   Hooks
    
-   Macros
    
-   UI fragments
    

## Run the script

Using the YAML file within script plugins when migrating from one instance to another allows scripts to be automatically configured. Automatic configuration of scripts saves time and ensures consistency across instances.

Follow these steps to run the built-in script:

1.  Navigate to **Built-in Scripts** > **Configuration Exporter** within ScriptRunner.
    
2.  Select the items you want to generate the YAML for in **Export What**.
    
    Items with configurations automatically appear here. Multiple items can be exported to one YAML file.
    
    ![The Configuration Exporter, on the Built-in Scripts screen.](/files/101638486/107984067/3/1738057826000/configuration-exporter.png)
    
    Make sure each thing you are exporting has a note. For example, if you are importing a REST Endpoint, navigate to **Built-In Scripts** > **REST Endpoint** to add a Note if there is one missing.  
    ![Screenshot of custom endpoint page](/files/101638486/179605214/1/1687956286000/endpoint_note.png) 
    
3.  Select **Run**.
    
    You can select **Preview** instead of **Run** to view changes before implementing them.
    
    Once you select **Run**, a code snippet appears.
    
4.  Copy this code snippet and paste it into your `scriptrunner.yaml` file.
    

You can manually edit the code yourself to add more items, though it’s generally easier to re-generate the YAML file using the _Configuration Exporter_ script.

For more information on using YAML files to create script plugins see [Create a Script Plugin](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin).
