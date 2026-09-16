# Clear Groovy Class Loader

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-7954a3e7-91b0-497a-bee0-c98dcd319d2b-e776de0bbff30884
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#clear-groovy-class-loader--en

Note: It is unsafe to clear Jira caches in Data Center. If you wish to clear Jira caches in a Server instance, check out this [Example Script](https://www.scriptrunnerhq.com/help/example-scripts/clear-jira-caches-onPrem).

You can run the _Clear Groovy Class Loader_ built-in script to clear caches if automated clearing fails.

Classes should be reloaded whenever a script is modified. However, sometimes dependent classes can fail to reload. For example, if you have a custom class file (ClassA) in your script roots and another Groovy script imports that file. Modifications to ClassA may only appear after you've modified the script that imported the file, or cleared the Groovy cache using this built-in script.

1.  Navigate to ScriptRunner.
2.  Navigate to Built-in Scripts > Clear Groovy Class Loader.
3.  Select Run to clear the Groovy cache.
    

Note: Classes are recompiled when clearing caches. Expect a delay in screen refresh.
