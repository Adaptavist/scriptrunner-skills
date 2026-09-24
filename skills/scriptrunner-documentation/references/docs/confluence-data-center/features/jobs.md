# Jobs

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-bfce13fb-de29-4613-ad5b-f11b6967485b-f5b17123728c5cde
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en

ScriptRunner jobs allow you to run your own code at regular intervals, giving you flexibility to create them according to your own specific needs and processes.

Using jobs, you can save time by automating time-consuming or repetitive actions.

There's two types of jobs you can use:

-   [Custom Scheduled Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs/custom-scheduled-jobs)
-   [Built-In Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs)

Some custom examples are:

-   Flag old content with a `requires-review` label
-   Automatically purge all trash on the first day of the month
-   Archive spaces with no active contributors

Additionally, there is a built-in job type, [CQL Escalation Services](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services), that allows you to iterate over content defined by a [CQL](https://developer.atlassian.com/confdev/confluence-rest-api/advanced-searching-using-cql) query, and do something with each hit.

## Manage Jobs

As with other jobs, you can Edit, Disable, Enable, and Delete the jobs you create from the main _Jobs_ screen. If you choose to edit them, you can change spaces, users, groups, and schedules.
