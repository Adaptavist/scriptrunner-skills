# Script Jobs

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-107989528
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-jobs

Jobs are a way to perform some automated tasks on regular intervals. Jobs are useful for tidying instances up and preventing content from getting lost. When you have jobs set up to shorten or automate tasks, you have more time for other non-maintenance work. 

Jobs are queued and executed in no predefined order, which means that the execution time of the task cannot be guaranteed to be the same every hour. For example, if you configure a job to be run every hour, it might run at 1:02, then 2:24. then 3:00 depending on how busy the systems are. 

CQL Script Jobs

Jobs can do administrative tasks like adding a label from scratch. [CQL Jobs](https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs) are different because they use CQL queries, so they can change every piece of content that is returned from a CQL query.

Similarities between jobs and CQL jobs: 

-   Both use a scheduler and code to perform actions at a specific time.
-   Both have a minimum interval of an hour between code executions.
-   Both schedulers are triggered every hour and gather all the tasks to be executed within that hour.
-   Both tasks are queued and executed in no predefined order

## Use cases

You can use jobs to flag old content with a _needs review_ label, purge the trash once a month, or archive spaces with no active contributors. 

For example you could use Script Jobs to archive pages after a certain amount of time has passed and no edits have occurred, keeping your content fresh.

## Use jobs

1.  Navigate to _ScriptRunner_ and select **Script Jobs**.  
    ![](/sr4cc/files/latest/107989528/588874138/1/1769187647000/script-jobs.png)
    
2.  Provide a **Name** for your script job.
    
3.  Choose if you want it **Enabled** (or turned on).
    
4.  For **On This Schedule**, select the schedule that you want this script to run. 
    
    The schedule editor lets you choose between running your script on several days during the week (like Monday, Wednesday, Friday) or running your script on particular days of the month (like the last day of the month or the second Tuesday of the month). 
    
    You can also select an hour interval where your script runs. 
    
5.  For **Code To Run**, enter what you want the job to do.
    
6.  You can select **Run Now** to see the script run or **Save**. 
    
    A _History_ section appears after the job runs once and logs each run.  
    ![](/sr4cc/files/latest/107989528/114204602/1/1623112401000/history.png)
    

Example scripts

ScriptRunner has a number of [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) for you to use. To access them, select this button in the **Script** field: 

![](/sr4cc/files/latest/107989528/288523544/1/1726000945000/click-example-scripts.png)

### Preview of included Script Job examples:

-   Delete Old Comments
    -   Use _Delete Old Comments_ to delete comments that are older than a certain amount of time. This script is useful because it makes comments easier to view and content more manageable.
-   Add a Comment to Old Pages
    -   Use _Add a Comment to Old Pages_ to add a comment to old pages to say that they should be reviewed. This script is useful because it allows for users to easily see if content is fresh. It can also act as a notice for when a piece of content is in its lifecycle.
-   Delete Old Page Versions
    -   Use _Delete Old Page Versions_ to delete versions that are older than a certain amount of time. This script is useful because it makes content more manageable.
