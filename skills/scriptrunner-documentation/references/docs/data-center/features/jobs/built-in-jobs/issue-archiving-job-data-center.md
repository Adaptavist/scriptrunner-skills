# Issue Archiving Job (Data Center)

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jobs > built-in-jobs
- Doc ID: doc-sr4js-442888780
- Source: https://docs.adaptavist.com/sr4js/latest/features/jobs/built-in-jobs/issue-archiving-job-data-center

The _Issue Archiving Job_ is only available on Data Center 8.1 and above.

Automate the [archiving](https://confluence.atlassian.com/adminjiraserver/archiving-an-issue-968669980.html) of issues with a ScriptRunner _Issue Archiving Job_. Periodically archive issues based on a JQL query. For example, you want to archive any closed issues that have not been updated in over two years. This will improve performance and reduce the risk of users viewing Jira issues that are no longer relevant.

After archiving, issues cannot be found by searching and become read-only.

1.  From ScriptRunner, navigate to the **Jobs** tab and click **Create Job > Issue Archiving Job**.
    
2.  Enter a **Name**, for example, _Archive old issues_.
    
3.  Under **User**, enter the user the job will run as.
    
    Create a user called _Automation_ (or similar) and give it administrator rights in every project. Then set _Automation_ as the **User** when setting up an issue archiving job.
    
4.  In the **Interval/Cron expression** field, enter how often the job should run. The interval can be in minutes, entered as an integer, or a cron expression. The example below runs on the first Monday of every month.
    
    ![Example of issue archiving job](/sr4js/files/latest/442888780/442888783/1/1758746969000/Issue_archiving_job_1.png)
    
    Jobs set to run at intervals run automatically upon start-up of Jira. To avoid this, use non-interval cron expressions specifying the time the job should run (as seen in the example above).
    
    For more information on cron expressions, see [Constructing Cron Expressions for a Filter Subscription.](https://confluence.atlassian.com/jirasoftwareserver/constructing-cron-expressions-for-a-filter-subscription-939938814.html)
    
5.  In **JQL Query**, enter a query to select the issues you wish to archive. For example, issues in a specific project that have the status _Closed_ and have not been updated for over two years.
    
    ![Example of JQL query](/sr4js/files/latest/442888780/442888784/1/1758746969000/JQL_query_issue_archiving_job.png)
    
    Test the query in the Issue Navigator first. The query runs as the configured user, and therefore, due to permissions, may see different results from the current user. For more information on JQL queries, see [Advanced Searching](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html).
    
6.  Click **Add** to save the job; the script will run on the interval specified. Optionally, click **Run now** to run the script and view which issues were affected.
    
    Clicking **Run now** does not save the job. Click **Add** to save.
    

See the [Atlassian documentation](https://confluence.atlassian.com/jirakb/how-to-restore-accidentally-deleted-issue-in-jira-applications-313466155.html) for details on how to restore issues.
