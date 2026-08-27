# Instance Audit

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-448135347
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit

Instance Audit Compatibility

This built-in script is currently compatible with ScriptRunner 8.54+, 9.25+ and 10.1+.

Use Instance Audit to get an overview of your Jira Instance's health. Instance Audit provides you with a numerical summary of key components, including:

-   Users
-   Projects
-   Issues
-   Custom fields
-   Workflows
-   Workflow Functions
-   Attachments
-   Installed apps

This feature enables you to quickly assess the current state of your Jira environment for easy cleanup, instance optimization, and migration preparation. For a more comprehensive analysis, use **Export report** to download CSV files containing more information on users, projects, custom fields, and workflow functions.

## Dashboard summary

The following categories are summarized in the dashboard:

Name

Description

Users

Monitor user statistics with a breakdown of total, active, and disabled users in your instance. 

A disabled user refers to an account that has been deactivated through one of the following methods:

-   Manually deactivated by a Jira administrator. For detailed instructions on user deactivation, please consult [Atlassian's documentation](https://confluence.atlassian.com/adminjiraserver/create-edit-or-remove-a-user-938847025.html#Create,edit,orremoveauser-Deactivateauser).
-    Automatically disabled due to changes in the External Directory:
    
    -   The user was disabled or removed in the synced directory (e.g., LDAP, Crowd, or Active Directory).
    -   The entire external directory was deactivated, affecting all associated user accounts.

Projects

Get a clear snapshot of project metrics, including the total number of projects, active projects, and archived projects within your instance.

Issues

Track issue statistics with an overview of total issues, active issues, and inactive issues in your instance.

Issue activity status is determined by a 30-day window. Issues that have been updated or interacted with within this period are classified as active, while those that haven't are considered inactive.

Custom Fields

Monitor custom field usage across your instance with a breakdown of total custom fields, distinguishing between Jira-native custom fields and those created by apps.

Workflows

Access workflow statistics, including the total number of workflows, active workflows, and inactive workflows. A workflow is active when it is associated with at least one project.

Workflow Functions (from Plugins)

Analyze the distribution of workflow functions created by plugins. This feature provides insights into the number of plugin-generated functions associated with both active and inactive workflows

Attachments

Monitor attachment usage by viewing the total number of attachments and their cumulative size.

User-installed Apps

Track app utilization by viewing the number of user-installed apps, categorized as enabled or disabled.

## View your instance audit dashboard

1.  From ScriptRunner, navigate to **Built-in Scripts > Instance Audit**.
2.  Select **Run**. The instance audit dashboard displays below.   
    ![Image of instance dashboard](/sr4js/files/latest/448135347/448135351/1/1758730956000/Instance_audit.png)

## Download a report

You can export a comprehensive zip report containing multiple CSV files. These files provide detailed information on users, projects, custom fields, and workflow functions (from plugins) within your instance.

1.  From ScriptRunner, navigate to **Built-in Scripts > Instance Audit**.
2.  Select **Export report**.  
    ![Image showing export report button highlighted](/sr4js/files/latest/448135347/448135350/1/1758731154000/Export_report.png)

## Understand report data

The exported zip report contains several CSV files with detailed information about your instance. The following tables explain what each column in these CSV files represents, helping you interpret and analyze the exported data effectively.

### Projects report data

The _Projects_ report provides the following analyses:

Column

Description

Key

Unique identifier of your project.

Name

Name of the project.

Lead

User assigned as the lead of the project.

Category 

Category assigned to the project (if specified).  

Type

Jira project type (for example, software).

Archived

Details of whether the project is archived or active.

Number of issues

Total number of issues in a project.

Date of first issue creation

The date the first issue was created in the project.

Issues recently created (last 30d)

Number of issues created in the project in the last 30 days.

Issues recently updated (last 30d)

Number of issues updated in the project in the last 30 days.

### Users report data

The _Users_ report provides the following analyses:

Column

Description

User Key

Key which distinguishes the user as unique.

User Name

The username (login).

Display Name

User displayed name (full name).

Email Address

User email address.

Directory

The name of the directory from which the user comes. For example, Jira Internal Directory.

Status

If the user is currently Active or Inactive.

Group Names

The names of the groups in which the user is included (for example, Admin group).

Number of Logins

The number of times the user has logged in.

Last Login Time

The time of the last successful login.

### Workflow function report data

The _Workflow functions_ report provides the following analyses of workflow functions created by plugins:

Column

Description

Workflow

The name of the workflow the workflow function is associated with. 

Workflow Status

If the workflow is currently active, inactive, or in draft. 

Transition

The transition on which the workflow function is configured.

Index

The position of the workflow function for the specific transition.

Module

The specific component within a plugin that provides the workflow function. For example, if ScriptRunner supplies a validator, this field will show the exact type, such as Custom script validator, Field(s) required validator, etc. This information helps identify the origin and purpose of each workflow function

Plugin

Name of the app providing the function. Plugins showing as _Missing Plugin_ includes disabled plugins as well as uninstalled plugins.

URL

URL pointing to the workflow function location in your instance. 

Type

The workflow function type, for example, validator, post function, or condition.

### Custom Fields report data

The _Custom fields_ report provides the following analyses:

Column

Description

Name

Name of the custom field.

Type

Custom field type (for example, Text Field).

Source

The app from which the custom field type originated, such as ScriptRunner. Or "JIRA" in the case of Jira's built-in custom field types.

## Auditing examples

The following tables detail some common use cases. Greater analysis is possible with the use of advanced statistical tools in spreadsheets such as the use of pivot tables.

### Workflow function audit examples

  

Migrating

Merging

Inheriting

Cost saving

Health checking

Step-by-step

Notes

Identify most/least used workflow functions by plugins

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
    
3.  Create a pivot table to analyze app usage.
4.  Set up the pivot table:
    
    -   Use **Module** as the row field.
    -   Add a count of entries as the value field.
5.  Sort the resulting pivot table by the count column in descending order to see which post functions are used most frequently.
    

You might choose to filter by workflow status or plugin. 

The number of uses won't be a perfect indicator of how much value these workflow functions bring to your business, this exercise will simply give you a broad view to get you started with assessing your usage and requirements.

Identify apps with crossover functionality

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  To keep your original data intact, copy the sheet, then delete the following columns: 
    
    -   **W****orkflow**
        
    -   **Transition**
        
    -   **Type**
        
    -   **URL**
        
4.  Filter on the **Workflow status** to remove any _Inactive_ workflows.
5.  Use your software's deduplicator function to get a list of all functions.
6.  Manually compare/explore this list further.

These apps may be delivering more than just workflow functionality, so be sure to look into each one fully before making your final decisions!

Identify totally unused workflow apps

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Use your software's deduplicator function to get a list of all apps currently used in workflows by looking at the **Plugin** column.
4.  Manually compare this list against the apps visible in your Jira instance to see if there are any workflow-specific apps which don't appear in the CSV. If these apps are not delivering some other functionality in the instance, you may be able to remove them.

These apps may be delivering more than just workflow functionality, so be sure to look into each one fully before making your final decisions!

Identify missing workflow apps

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by **Plugin** column to reveal all those marked (Missing plugin).
4.  Click into the URL field for each to go directly to the edit screen for cleanup or further exploration.

  

Create list of must have workflow functions

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them. 
3.  Create a pivot table to analyze app usage.
4.  Set up the pivot table:
    
    -   Use **Module** as the row field.
    -   Add a count of entries as the value field.
5.  Sort the resulting pivot table by the count column in descending order to see which post functions are used most frequently.

You might choose to filter by workflow status so that you only look at _Active_ workflows.

The number of uses won't be a perfect indicator of how much value these workflows bring to your business, this exercise will simply give you a broad view to get you started with assessing your usage and requirements.

Identify most cost inefficient apps

  

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them. 
3.  Create a pivot table to analyze app usage.
4.  Set up the pivot table:
    
    -   Use **Module** as the row field.
    -   Add a count of entries as the value field.
5.  Sort the resulting pivot table by the count column in descending order to see which post functions are used most frequently.
6.  Optional: Filter by workflow status so that you only look at _Active_ workflows.
7.  Capture the cost for each app for further examination.

Remember these apps may be delivering much more than just workflow functionality and the number of uses may not be a reflection of the value that is provided to your business in terms of time saved or processes protected. Be sure to look into each fully before making your final decisions!

### Project audit examples

  

Migrating

Merging

Inheriting

Cost saving

Health checking

Step-by-step

Notes

Identify most/least used projects

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Sort your data first by **Number of issues**, then by **Issues recently created (last 30d)**.

You might choose to filter by **Archived** so that you only look at active projects.

The number of issues won't be a perfect indicator of how valuable the project is as it may leave out new relevant projects, this exercise will simply give you a broad view to get you started with assessing your usage and requirements.

To get a better view of the usage in recent days you can add an extra column that calculates the value of _Issues Created in the Past 30 days/Number of Issues._ This will identify recently created projects compared to old established projects.

Identify totally unused projects

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter your data to show projects with a value of **0** in **Issues created in the past 30 days**.

You may also want to filter further to also only show projects with a value of **0** in **Issues updated in the past 30 days.** 

You might choose to filter by **Archived** so that you only look at active projects.

These projects might still be required, so be sure to look into each one fully before making your final decisions!

Identify archived projects

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by the **Archived** column to reveal all projects in the _Archived_ status.

  

Identify projects nearing their end-of-life

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by **Archived** so that you only look at _Active_ projects.
4.  Sort your data smallest to largest by **Issues created in the past 30 days**.

You may also want to sort by two columns including the **Issues updated in the past 30 days.**

Run this scan periodically and compare the number for a project to see which are winding down towards end-of-life. You can use your spreadsheet to combine the created/edited entries to see the least active projects.

### User audit examples

  

Migrating

Merging

Inheriting

Cost saving

Health checking

Step-by-step

Notes

Identify users whose email addresses are not unique within your instance

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Sort your data first by **Email Address**.
4.  Use your spreadsheet application to highlight duplicates. This may be a useful visual guide as you work through.
5.  Use the **User Key** column to identify whether these are true duplicates or individuals sharing email addresses

On Jira Cloud, it is _**not possible**_ to have an email address shared between two users. There is a one-to-one relationship between Users and Email Addresses.

Identify user groups

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by the **User Groups** column.

  

Identify the directories with the most users

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by the **Directory** column.
4.  Use your spreadsheet's COUNT functionality to identify the largest directories.

  

Identify users that have not accessed the application for a long period

  

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Sort by the Last Login Time column to order from most recent to least recent or vice versa.
4.  If you have a specific cut-off date in mind that you would like to filter by, use your spreadsheet software's filter function.

  

Identify users that have never logged in

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by the **Number of logins** column to show those with **0** logins.

  

### Custom field audit examples

  

Migrating

Merging

Inheriting

Cost saving

Health checking

Step-by-step

Notes

Identify the most common custom field types

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Sort your data by **Type**.
4.  Manually explore this list further.

  

Identify most/least used apps for custom fields

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Sort your data by **Source**.
4.  Manually explore this list further.

This can help you identify dispensable apps.

Identify which custom fields have been created with a particular app

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Filter by the name (**Source**) of the app of your choice.
4.  Manually explore this list further.

If you are thinking about uninstalling an app, this will allow you to quickly identify which custom fields are dependent on it.

Identify duplicated custom fields

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

1.  Import your CSV file into a spreadsheet application (e.g., Microsoft Excel, Google Sheets).
2.  Optional: If filters are not automatically visible, enable them.
3.  Use your spreadsheet application to highlight duplicates. This may be a useful visual guide as you work through.
4.  Manually explore this list further.

 

  

* * *

## Related content

-   [Migration Checklist](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/migration-checklist)
-   [Migrating to Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud)
-   [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry)
