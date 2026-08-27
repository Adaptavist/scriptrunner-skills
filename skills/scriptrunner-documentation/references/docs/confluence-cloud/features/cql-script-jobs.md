# CQL Script Jobs

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-107989560
- Source: https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs

A CQL (Confluence Query Language) script job (or escalation service) runs a CQL query on a specified schedule. Each time it is run, the query returns a number of pages, and then the job is performed to those returned pages based on the code written. For instance, a CQL script job could change the returned pages by adding comments or deleting attachments, but you could also use the results to fetch a list of child pages.

For help with CQL, visit the [CQL Guide](https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs/cql-guide). 

Jobs are useful for tidying instances up and preventing content from getting lost. When you have jobs set up to shorten or automate tasks, you have more time for other non-maintenance work. 

CQL Script Jobs

Jobs can do administrative tasks like adding a label from scratch. CQL Jobs are different because they use CQL queries, so they can change every piece of content that is returned from a CQL query.

Similarities between jobs and CQL jobs: 

-   Both use a scheduler and code to perform actions at a specific time.
-   Both have a minimum interval of an hour between code executions.
-   Both schedulers are triggered every hour and gather all the tasks to be executed within that hour.
-   Both tasks are queued and executed in no predefined order

Each defined job must have a CQL query that will be run in order to find the content that you want to modify. The code you provide as part of the job configuration will be run against each piece of content individually, and in parallel. Each content will be injected into your code as part of the script context.

## Use case

You could fix content that was mislabeled with _CQL Script Jobs_. A CQL query like `space = development and label = requirements` would find the _requirements_ label in the _development_ space. You could then write a script that transforms all of those found labels to _product requirements._

## Use CQL script jobs

1.  Select **Confluence Administration** on the right side of the screen.
2.  Select **CQL Script Jobs**, under _ScriptRunner_ on the left side of the screen.
    
3.  Select **Create CQL Script Job**.
    
4.  Provide a name for your CQL job in **The CQL Script Job Called**.
    
5.  Choose if you want it **Enabled** (or turned on).
    
6.  Enter your CQL query in ****For the First 50 Results Returned By This Query.****
    
    The maximum amount of content you can modify in any CQL script job is 50. 
    
7.  For **On This Schedule**, select the schedule that you want this script to run. 
    
    The schedule editor lets you choose between running your script on several days during the week (like Monday, Wednesday, Friday) or running your script on particular days of the month (like the last day of the month or the second Tuesday of the month). 
    
    You can also select an hour interval where your script runs. 
    
    The minimum interval between code executions is 1 hour. The scheduler is triggered every hour and gathers all the tasks to be executed within that hour. The task executions are queued and workers will consume them in no predefined order. That means that the execution time of the task can not be guaranteed to be the same every hour. As an example: if you configure a job to be run every hour, it might be run at 01:02 and then 02:24 and then 03:00 and then at 04:46 etc depending on how busy our systems are.
    
8.  For **As This User**, select if you want to run this task as yourself or another user
    
    For example, you run this task as a user named _Confluence Admin_, so that that changes can be easily tracked.
9.  For **Code To Run**, enter what you want the job to do.
10.  You can select **Run Now** to see the script run or **Save**. 
     
     A _History_ section appears after the job runs once and logs each run.  
     ![](/sr4cc/files/latest/107989560/114204623/1/1623116056000/history.png)
     

## Example

The following image shows a CQL script query set up to delete pages with a specific label.   
![](/sr4cc/files/latest/107989560/288523584/1/1725043109000/cql-script-job-example.png)
