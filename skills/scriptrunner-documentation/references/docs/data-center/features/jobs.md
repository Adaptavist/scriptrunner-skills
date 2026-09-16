# Jobs

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-cfe67759-88f3-487c-bfc3-cbd06a60210d-3c49b4852d379aee
- Source: https://docs.adaptavist.com/sr4js/latest/features#jobs--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature has partial parity in Cloud.<br>[Cloud Feature Parity documentation](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#jobs--en) |

## What are Jobs?

ScriptRunner Jobs allow you to automate the running of scripts at regular intervals saving your administrators time, and reducing the risk of human error. You can specify how often a job should run with either an integer (in minutes) or as a cron.

## How to use Jobs

You may want to use a job to:

-   Create an issue once per month.
-   Email a report to users, on a schedule.
-   Delete inactive users on a monthly basis.
-   Change the status of an issue depending on the time it has been open.
-   Automatically escalate an issue based on the elapsed time using [Escalation Services](https://docs.adaptavist.com/sr4js/latest/features/jobs/built-in-jobs/escalation-services).

### Examples of Jobs

I have a team of consultants who need to fill out expenses at the end of every month. I can create a ScriptRunner job to automatically create a task for each user at the end of every month to remind them to complete their expenses.

As a Jira administrator it's key to keep my instance healthy and reduce costs by removing inactive users. I can set up a job to run a script which deletes inactive users on a monthly basis.

Note: Jobs require you to specify an application user the code will run as. Jira services have been migrated to Jobs; therefore, they now require an application user. Migrated services run as expected, however; when editing a service, you must specify an application user in the User field. For this reason, code that sets an authentication context to a particular user is now unnecessary; instead, configure the service to run as this user.

## Before you start

|  |  |
| --- | --- |
|  | Most Jobs use cron expressions. If you're unfamiliar with cron expressions we recommend you use this Cron Maker resource to help you build your own.<br>[Cron Maker](http://www.cronmaker.com/) |
