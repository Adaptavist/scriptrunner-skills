# Clear Groovy Class Loader

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-d18c2edc-cefa-49d1-aaec-d137cc843bd6-065266822170e060
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#clear-groovy-class-loader--en

You can run the Clear Groovy Class Loader built-in script to clear caches if automated clearing fails.

Classes should be reloaded whenever a script is modified, but dependent classes can fail to reload. For example, if you have a custom class file (ClassA) in your script roots and then another Groovy script imports that file. Modification to ClassA may only appear after you've modified the script that imported the file or cleared the Groovy cache using the built-in script.

## Run the script

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts
2.  Select Clear Groovy Class Loader.
3.  There are no fields for this script, so you only need to select Run.
