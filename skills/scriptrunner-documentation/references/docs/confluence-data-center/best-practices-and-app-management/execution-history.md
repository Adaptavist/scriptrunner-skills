# Execution History

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-8aea4b27-1a27-4e84-81b0-3d507dcffdd0-97d16923e98519a5
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#execution-history--en

Use _Execution History_ to view up to two years of execution times and failure rates of ScriptRunner scripts in your instance, allowing a long-term view of script performance.

Understanding the effects of ScriptRunner scripts on your Confluence instance is critical for successful platform management.

Using the extended history, observe if a script gets slower over time or if slow performance correlates with specific events (such as Confluence or app upgrades). _Execution History_ provides long-term analytics allowing you to develop scripts and change execution timings to keep your instance performing optimally. Viewable executions include scripted listeners, scheduled jobs, escalation services, and post functions.

To view the execution history of your ScriptRunner script:

1.  Navigate to the script location. For example, to view the execution history of a macro, navigate to Add Label.
2.  Click the text under the _History_ column, and the _Execution Information_ window appears.
    
3.  Click the success (green checkmark) or failure (red X) symbol to view each execution. The _Execution History_ window shows in-depth data and logs for each script execution.
    

_Execution Information_ has four sections:

-   Time - Time the task was executed.
-   Logs - Displays log information for the specific execution.
-   Payload - Data sent when the script executed.
-   Timing - Time taken for the script to execute, including _Elapsed_ and _CPU Time_.

## Performance

An execution history graph for the script shows _Duration_ and _Node_ data. To see this information, select the Performance icon.

You can select the Duration options to change the scale of the x-axis.

If you have ScriptRunner for Confluence Data Center, you can select the _Node_ option to switch between nodes.

Each graph segment represents a 30-minute block.
