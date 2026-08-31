# Execution History

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > logging
- Doc ID: doc-sr4js-442885064
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging/execution-history

Understanding the effects of ScriptRunner scripts on your Jira instance is critical for successful platform management. Use _Execution History_ to view execution times and failure rates of ScriptRunner scripts in your instance, providing in-depth data and logs for script executions.

Using the _Performance_ column, observe if a script is getting slower over time, or if slow performance correlates with specific events (such as Jira or app upgrades). _Execution History_ and _Performance_ provide long-term analytics, up to two years, allowing you to develop scripts and change execution timings, to keep your instance performing at an optimal level. 

You can view the execution history and performance of the following:

-   Scripted listeners
-   Scheduled jobs
-   Escalation services
-   Post functions
-   JQL functions

## Viewing the execution history of your ScriptRunner script

1.  Navigate to the script location in ScriptRunner. For example, to view the execution history of a job, navigate to **Jobs**.
    
2.  Select the text under the **History** column, and the _Execution Information_ window appears.
    
    ![Image of history column](/sr4js/files/latest/442885064/442885073/1/1758746450000/Execution_history_update.png)
3.  Select the success (green checkmark) or failure (red X) symbol to view each execution. The _Execution History_ window shows in-depth data and logs for each script execution.
    
    ![Image of execution history pop-up](/sr4js/files/latest/442885064/442885074/1/1758746450000/Execution_history_2.png)  
    
    _Execution Information_ has four sections:
    
    -   **Time** - Time the task was executed.
    -   **Logs** \- Displays log information for the specific execution.
        
    -   **Payload** \- Data sent when the script executed.
        
    -   **Timing** \- Time taken for the script to execute, including _Elapsed_ and _CPU Time_.
        

## Viewing performance history

An execution history graph for the script shows _Duration_ and _Node_ data. To see this information, proceed as follows:

1.  Navigate to the script location. For example, to view the performance history of a job, navigate to **Jobs**.
2.  Select the **Performance** icon.  
    ![Image of performance option being selected](/sr4js/files/latest/442885064/442885075/1/1758746450000/Performance_2.png)
3.  Select the **Duration** options to change the scale of the x-axis. 
    
    You have the option of selecting **2 days**, **2 weeks**, **2 months** or **two years**.
    
    If you have ScriptRunner for Jira Data Center, you can select the **Node** option to switch between nodes.
    
    ![Image of performance pop-up](/sr4js/files/latest/442885064/442885072/1/1758746450000/Performance.png)
