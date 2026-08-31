# Custom Jobs

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jobs
- Doc ID: doc-sr4js-442885186
- Source: https://docs.adaptavist.com/sr4js/latest/features/jobs/custom-jobs

Create custom jobs to run a number of actions at set intervals.

1.  From ScriptRunner, navigate to the **Jobs** tab and select **Create Job > Custom scheduled job**.
    
2.  In **Name** enter a name for the job, for example, _Create issue_.
    
3.  Under **User**, enter the user the job will run as. If the job is set to leave a comment, send an email, or transition an issue, it does so as this user.
    
    This user must have the correct permissions to execute the action (for example, create the issue). Results of the JQL may differ depending on the permissions of the selected user.
    
    Create a user called _Automation_ (or similar) and give it administrator rights in every project. Then set _Automation_ as the **User** when setting up a custom job.
    
4.  In the **Interval/Cron expression** field, enter how often the job should run. The interval can be in minutes, entered as an integer, or a cron expression. The example shown runs every day at 6 am.
    
    ![Example image of an interval cron expression](/sr4js/files/latest/442885186/442885188/1/1758746462000/escalation_service_CRON+%281%29.png)
    
    Jobs set to run at intervals run automatically upon start-up of Jira. To avoid this, use non-interval cron expressions specifying the time the job should run (as seen in the example above).
    
    For more information on cron expressions, see [Constructing Cron Expressions for a Filter Subscription](https://confluence.atlassian.com/jirasoftwareserver/constructing-cron-expressions-for-a-filter-subscription-939938814.html).
    
5.  Add the job script to the **Inline script** field (see example below).
    
6.  Select **Add** to save the job; the script will run on the interval specified. Optionally, click **Run now** to run the script and view which issues were affected.
    
    Selecting **Run now** does not save the job. Select **Add** to save.
    

## Examples

### Create an issue once a month

Configure a job to create an issue once every month. For example, as a project manager, I want to create an issue every month, reminding me to groom the backlog.

1.  Add a **Name**, such as _Create an issue once per month_.
    
2.  Select a user to run the script as.
    
3.  Enter an interval to run as in the **Interval/Cron expression** field. In this example, we want the code to run on the first Monday of every month so we would enter `0 0 0 ? 1/1 MON#1 *`
    
4.  Add the following script to the **Inline script** field to create an issue in the _JRA_ project, with _Issue created from script_ in the **Summary** field:  
    
    **An error occured**
    
    There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)
    
5.  Select **Add** to save the job; the script runs on the interval specified.
    

### Marking an issue as inactive

You can configure a job to mark issues as inactive when they've been awaiting customer response for a specified duration. For example:

**An error occured**

There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)
