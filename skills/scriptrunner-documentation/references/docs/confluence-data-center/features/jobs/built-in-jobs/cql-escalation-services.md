# CQL Escalation Services

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-2be10575-9daa-416b-a374-9ae0894cabab-06641160244a9bbc
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#cql-escalation-services--en

Using the _CQL Escalation Services_ built-in job, you can pass the results of a CQL query to the code you provide.

This saves you from writing the code to execute the query and setting the impersonation context.

Tip: For help with CQL, visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

## Components of the job

### Script binding

In the script, the binding variable `hits` is available, which is an `Iterable<ContentEntityObject>`. Therefore, you can do something with each piece of content returned using:

```
hits.each { content ->
    // do something with content
}
```

### Confluence content type information

Depending on your query, the type of `content` in the above example will be either a `Page`, an `Attachment`, a `BlogPost`, a `Comment`, or another type of Confluence content. However, it will always be a `ContentEntityObject`.

If you only want to do something with pages, then use a query that only selects pages like `space = "ds" and type = page`. Alternatively, you can use `instanceof` in your script to do different things depending on the type of content. An example is `title in spaceAttachments("ds")`.

### Restrictions

Specify a user who has permission to see the content that you want.

### Service code

Your service code is automatically wrapped into a transaction template. Make sure that your service doesn't run for a long time, unless it is a quiet time (like the weekend).

## To create the job

Follow these steps to create a job where the CQL query passes results to the script, determining where the job's action occurs.

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select CQL Escalation Service.
4.  Add a Name to identify the script.
5.  Select a User to run the script as.
6.  Enter an Interval/Cron Expression to determine when to run the script.
7.  Add your Inline Script to determine what the job does with the results from the CQL Query.
8.  Add the CQL Query to pull results to pass to the code in Inline Script.
    
    Tip:
    
    -   CQL autocomplete is available for this field. Start typing to see possible CQL statements.
    -   Determine the type of content you want to pull here.
    -   CQL does not support searching on months or years, so multiply the weeks value appropriately.
    
9.  Select Add to add the job.
    
    You can also select Run Now to run the script immediately.
    

## Examples

### Add Label to outdated pages

As a worked example, we'll add a label to pages that haven't been modified for one month in a particular space. You may do this if you need to ensure that content is kept current, although this solution is deliberately over-simplistic.

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select CQL Escalation Service.
4.  Enter the Name Add label to outdated pages.
5.  Select admin to run the job as in User.
6.  Enter 0 30 0 ? \* \* to run the job at 12:30 AM every day.
7.  Enter the following code for Inline Script:
    
    ```
    import com.atlassian.confluence.labels.Label
    import com.atlassian.confluence.labels.LabelManager
    import com.atlassian.confluence.labels.Namespace
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.scheduler.JobRunnerResponse
    
    def labelManager = ComponentLocator.getComponent(LabelManager)
    hits.each { page -> // <1>
    
        def labelName = "requires-review"
    
        def label = labelManager.getLabel(labelName)
        if (!label) {
            label = labelManager.createLabel(new Label(labelName, Namespace.GLOBAL))
        }
    
        if (!page.labels*.name.contains(labelName)) {
            log.info("Add label to page: ${page.title}")
            labelManager.addLabel(page, label) // <2>
        }
    }
    
    JobRunnerResponse.success()
    ```
    
    Line 8: Iterate over the items returned from the CQL
    
    Line 19: Add label to the page
    
8.  Enter `space = "ds" AND type = page AND lastModified < now(-4w")` for CQL Query.
    
    This returns pages from the Demonstration Space that have not been modified for over four weeks.
    
9.  Select Add.
    
    You can also select Run Now to immediately run the job.
    

Now, the job will run at 12:30 AM every day and add a label to pages that have not been modified for over four weeks.

### Add comment to outdated pages

You can also add a comment to any page that has not been modified for over three months and has had no comments in over three months. To set up this script, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select CQL Escalation Service.
4.  Enter the Name Add comment to outdated pages.
5.  Select admin to run the job as in User.
6.  Enter 0 0 22 ? \* SUN to run the job every Sunday night.
7.  Enter the following code for Inline Script:
    
    ```
    import com.atlassian.confluence.pages.CommentManager
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.scheduler.JobRunnerResponse
    
    def commentManager = ComponentLocator.getComponent(CommentManager)
    
    hits.each { page ->
    
        if (!commentManager.getPageComments(page.id, new Date() - 98)) { // <1>
            log.debug("Adding 'old page' comment to page: ${page.title}")
            commentManager.addCommentToObject(page, null, "Old page! Please review")
        }
    }
    
    JobRunnerResponse.success()
    ```
    
    Line 9: check we don't have a comment added within the last three months (in days)
    
8.  Enter `space = "ds" AND type = page AND lastModified < now("-14w")` for CQL Query.
    
    This selects pages in the the Demonstration Space that has not been modified for over 14 weeks.
    
9.  Select Add.
    
    You can also choose to Run Now to run the job immediately.
    

Now, the job will run every Sunday night to add comments to page that have not been modified for over 14 weeks.
