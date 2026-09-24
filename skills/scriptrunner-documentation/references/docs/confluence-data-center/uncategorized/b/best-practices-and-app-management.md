# Best Practices and App Management

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: n/a
- Doc ID: doc-sr4c-345c7ce5-1654-4255-96d7-bc98879dcc7e-86c67a08421e492c
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management

Find our reccomendations for best practices and managment within the app.

## Best practices for Confluence using ScriptRunner

ScriptRunner helps you automate processes you often use to manage your Confluence instance including data, users, and spaces, which reduces manual effort and potential errors.

The following sections outline automation best practices for Confluence using ScriptRunner:

-   [Managing data](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#managing-data--en)
-   [Managing users](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#managing-users--en)
-   [Managing spaces](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#managing-spaces--en)

The content links you to ScriptRunner for Confluence documentation, Atlassian documentation, and the ScriptRunner for Confluence Example Scripts to give you more resources to automate your instance.

### Managing data

-   [Data access and security](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#data-access-and-security--en)
-   [Content engagement](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#content-engagement--en)
-   [Data Center and performance](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#data-center-and-performance--en)
-   [Search and indexing](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#search-and-indexing--en)
-   [Migration](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#migration--en)
-   [Integrations](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#integrations--en)
-   [Cleanup and consolidation](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#cleanup-and-consolidation--en)

#### Cleanup and consolidation

ScriptRunner for Confluence has created ways to automate clearing out old content so that your instance performance doesn't slow down and your users can find the information they're looking for.

##### Be alerted of old content

We have created two scripts to help you identify old content so you can decide if it needs to be archived/deleted or updated.

[Add Label to Outdated Pages](https://www.scriptrunnerhq.com/help/example-scripts/add-label-to-outdated-pages-onPrem)

1.  Use this Example Script to add a label to pages older than a particular timespan using the Script Console or a [CQL Escalation Service Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services).
2.  Search for that label using [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search).
3.  Review the old pages returned by the search and act, if necessary.

[Old Content Notifier Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/old-content-notifier-job)

1.  Use this job to check pages and their descendants using a CQL clause to determine if there are any inactive pages.
2.  Review the old content and act, if necessary.

##### Bulk delete pages

If you've created pages in your Confluence instance that are no longer needed, use the [Delete Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/delete-pages) built-in script.

Note: This is both a [Confluence Administration Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts) and a [Space Administration Built-In Scripts](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts).

You can use the Example Script [Remove Archived Space](https://www.scriptrunnerhq.com/help/example-scripts/remove-archived-space-onPrem) to remove any archived spaces that have not been updated for over a year.

##### Bulk update macros

Use the [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro) built-in script to update macro parameters in bulk within your Confluence instance.

CAUTION: This is a powerful script. We recommend "spot testing" this script on a sample page

##### Bulk update pages in a space

The following Example Scripts are available to work with multiple pages in your space all at one time:

-   [Add Labels to Spaces In Bulk](https://www.scriptrunnerhq.com/help/example-scripts/add-labels-to-spaces-in-bulk-onPrem)
-   [Add Macro to the Bottom of Pages within Space](https://www.scriptrunnerhq.com/help/example-scripts/add-macro-to-the-bottom-of-pages-within-space-onPrem)

##### Delete old content

Use the [Automate the Removal of Old or Inactive Content](https://www.scriptrunnerhq.com/help/example-scripts/delete-old-pages-cql-escalation-service-onPrem) Example Scripts to regularly sweep your instance for pages that haven't been updated in a specified period of time and trash them.

To delete outdated Confluence content other than pages, use the following scripts:

Delete old attachments

-   [Bulk Delete Attachments Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachments)
-   [Bulk Delete Attachments Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/bulk-delete-attachments-job)

Delete old comments

-   [Bulk Delete Comments Script Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-comments)

Delete old versions

-   [Prune Old Versions Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/prune-old-versions-job)
-   [Bulk Delete Attachment Versions Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions)

Tip: Use Jobs to remove content based on a schedule. Use the built-in scripts to run a script to remove content based on what's in the script.

##### Delete trash

There are two ways to bulk purge trash:

-   [Bulk Purge Trash Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/bulk-purge-trash-job): Use this job to automate a trash purge on a schedule.
-   [Bulk Purge Trash Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-purge-trash): Run this built-in script to delete all trash in specified spaces or all spaces in your Confluence instance.

##### Fix links

Use these scripts to fix links in your Confluence instance:

-   [Identify Pages with Broken Image Links](https://www.scriptrunnerhq.com/help/example-scripts/identify-pages-with-broken-image-links-onPrem): Use this Example Script to generate a report of all broken links in a space to help you identify and fix them.
-   [Convert Absolute Links to Confluence Links](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/convert-absolute-links-to-confluence-links): Use this built-in script to convert links to the correct internal storage format. Links could be the wrong format depending on how they were created, which leads to broken links.
-   [Get Outgoing Links CQL function](https://www.scriptrunnerhq.com/help/example-scripts/linked-pages-cql-function-onPrem): Use this Example Script to get a list of all outgoing links.

##### Manage user content

Use the [Change Content Author Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/change-content-author) to change the original _Created By_ author of Confluence content, like pages, blog posts, comments, and attachments. You can use this script if someone is leaving your organization, and they need to hand over pages they created and managed to another user. Or if labels are used by creator for searching and indexing.

##### Synchronize content

If you have one page set up that needs to be mimicked across different pages, ScriptRunner has four Example Scripts to help you synchronize different content between pages:

-   [Synchronize Two Pages](https://www.scriptrunnerhq.com/help/example-scripts/synchronise-two-confluence-pages-onPrem)
-   [Synchronize Labels Between Two Pages](https://www.scriptrunnerhq.com/help/example-scripts/synchronise-page-labels-between-two-confluence-pages-onPrem)
-   [Synchronize Content Between Two Pages](https://www.scriptrunnerhq.com/help/example-scripts/synchronise-page-content-between-two-confluence-pages-onPrem)
-   [Synchronize Attachments Between Two Pages](https://www.scriptrunnerhq.com/help/example-scripts/synchronise-page-attachments-between-two-confluence-pages-onPrem)

#### Content engagement

ScriptRunner for Confluence can visualize how users engage with content and help you identify popular topics.

##### Manage watchers

As an administrator, you can make sure your users are watching/getting alerted to certain updated content by adding them as watchers.

-   [Add Remove Watchers Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/add-or-remove-watchers): Run this script to manage watchers based on what's in the script.
-   [Add/Remove Watchers Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/add-or-remove-watchers-listener): Use this listener to manage watchers based on a Confluence event.

##### Review statistics

Use the [Space Statistics Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/space-statistics) to get an overview of your Confluence spaces and view the:

-   Number of attachments
-   Number of pages
-   Number of blogs
-   Number of comments
-   Number of labels
-   Number of likes
-   Number of trashed items
-   Creation date

The _Space Statistics Report_:

Tip: You can also use this to [Cleanup and Consolidate](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#cleanup-and-consolidation--en) your Confluence instance because the report gives you a view of:

-   Pages older than 1 year
-   Comments older than 1 year
-   Attachments older than one year

Use the [Display Spaces View Report](https://www.scriptrunnerhq.com/help/example-scripts/spaces-view-report-onPrem) Example Script to view the _Spaces View Report_ in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console).

Warning: You can access the _Spaces View Report_ from the [Analytics](https://confluence.atlassian.com/doc/analytics-1044780333.html) page in Confluence.

#### Data access and security

For information about security vulnerabilities, visit [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security). ScriptRunner uses a number of open-source libraries, similar to most apps on the Marketplace. This page covers how we scan for vulnerabilities and common security concerns.

##### Permissions and restrictions 🔒

The [Manage access and permissions](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#manage-access-and-permissions--en) section on this page contains a lot of information about managing user, page, and user permissions and restrictions. Maintaining updated and accurate permissions and restrictions helps your Confluence instance remain secure.

#### Data Center and performance

Maintaining a healthy system reduces system downtime and leads to a good user experience with Confluence running smoothly. Using ScriptRunner for Confluence, you can review what's in your instance to determine next steps. Check out the [Cleanup and consolidation](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#cleanup-and-consolidation--en) section to start cleaning up your instance!

##### Get notifications for automations

You can use [Send Custom Email for Confluence](https://www.scriptrunnerhq.com/help/example-scripts/send-custom-email-for-confluence-onPrem) Example Script to get an email when an automation has finished running.

Similarly, you can send an email based on a Confluence event using the [Send Custom Email Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/send-custom-email). For a list of Confluence events, visit [Confluence Events and Descriptions](https://docs.adaptavist.com/sr4c/latest/get-help/confluence-events-and-descriptions).

##### Review Confluence content

There are a number of reports you can view using ScriptRunner for Confluence that give you a full picture of what your Confluence instance is running. Check these out:

-   [List Scheduled Jobs Built-In Scripts](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/list-scheduled-jobs): Run this script to view details of all jobs on the current instance.
-   [View Server Log Files Built-In Scripts](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/view-server-log-files): Run this script to show the last lines of your instance's application log files.
-   [Space Statistics Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/space-statistics): Review the report generated by this script to get an overview of your Confluence spaces.
-   [Display Spaces View Report](https://www.scriptrunnerhq.com/help/example-scripts/spaces-view-report-onPrem): Use this Example Script to view the _Spaces View Report_ in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console).
-   [Export Page as PDF Job Example Script](https://www.scriptrunnerhq.com/help/example-scripts/export-page-to-pdf-onPrem): Use this Example Script to export one or more pages as PDF on a schedule to retain a snapshot of page content over time.

#### Integrations

Seamless integrations create a better user experience, make you more efficient, and limit context switching. ScriptRunner for Confluence integrates with other apps through databases and various scripts to help you automate your process.

##### Connect with databases

Connect with relevant databases to make your Confluence instance more useful to your organization. There are two types of database connection:

-   [External Database Connection](https://docs.adaptavist.com/sr4c/latest/features/resources/external-database-connection): Connect to any database, such as your sales or contacts database.
-   [Local Database Connection](https://docs.adaptavist.com/sr4c/latest/features/resources/local-database-connection): Connects to the current database your Atlassian application is using.

Adding an [LDAP Resource](https://docs.adaptavist.com/sr4c/latest/features/resources/ldap-connection) allows you to query your LDAP servers in a similar way to database connections.

##### Interact with Jira

We've created a number of Example Scripts to integrate your Confluence instance with your Jira instance:

-   [Comment on Jira Issue for Linked Confluence Pages](https://www.scriptrunnerhq.com/help/example-scripts/comment-on-jira-issue-for-linked-confluence-page-onPrem): Automatically comment on a Jira issue whenever the linked Confluence page gets updated.
-   [Confluence Macro to Show User Installed Jira Apps](https://www.scriptrunnerhq.com/help/example-scripts/confluence-macro-installed-apps-jira-onPrem): Show a list of apps a user has installed on their Jira instance and the gadgets and functionality they provide.
-   [Create a Confluence Page for Each Subtask of an Issue](https://library.adaptavist.com/entity/create-confluence-page-for-issues): Create a corresponding page, with hierarchy in place, for each sub-task of an issue in a Confluence space linked via application links.
-   [Create Jira issue From Forms for Confluence Submission](https://www.scriptrunnerhq.com/help/example-scripts/create-confluence-page-for-issues-onPrem): Connect your forms embedded in Confluence pages so new issue is created in an associated Jira instance on every form submission.
-   [Create a Jira Issue When a Page or Blog Post Is Approved - Comala Document Management Integration](https://www.scriptrunnerhq.com/help/example-scripts/comala-create-issue-when-page-is-approved-in-confluence-onPrem): Create a Jira issue once a page is approved in a Confluence workflow.
-   [Create a Jira Project When a Confluence Space is Created](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5Bquery%5D=%22create-project-when-space-created%22): Create a project in Jira when a Confluence space is created.

##### Interact with other apps

Here are the different ways ScriptRunner for Confluence has made it easy to integrate your Confluence instance with other apps:

_All Confluence apps_

Use the [Show User Installed Confluence Apps Example Script](https://www.scriptrunnerhq.com/help/example-scripts/confluence-macro-installed-apps-confluence-onPrem) to provide a macro to show a list of apps a user has installed on their instance and which macros they provide.

_Comala Document Management_

Use the [Create a Task for Each Page Reviewer Example Script](https://www.scriptrunnerhq.com/help/example-scripts/comala-create-task-for-reviewers-onPrem) to create tasks within Comala Document Management for each reviewer. Edit the script to specify the tasks you wish to assign and set optional due dates.

_Forms for Confluence_

Use the scripts outlined on [this listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/listeners-with-product-integrations) page to automatically create a new page when a form is submitted. For example, you could want a page created when a user submits an internal feature request or events proposal using Forms for Confluence.

_Slack_

Use the [Slack Connection](https://docs.adaptavist.com/sr4c/latest/features/resources/slack-connection) documentation to set up a connection between your Slack domain and Confluence instance. Once you have this set up, you can use Slack blocks, attachments, and files in your Confluence instance.

##### HAPI script

[Work with application links](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-application-links) with one simple script using HAPI!

#### Migration

To keep a good experience for your users, limit downtime, and reduce admin and maintenance costs, use ScriptRunner for Confluence to automate your migration process.

Visit the [Migrate from ScriptRunner for Confluence Server to Cloud](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/migrate-from-scriptrunner-for-confluence-server-to-cloud) section of the ScriptRunner for Confluence Data Center documentation to get started.

A few more links you might find important are:

-   [Platform Differences](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/platform-differences)
-   [Feature Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/feature-parity)
-   [Contact Support](https://docs.adaptavist.com/sr4c/latest/get-help#contact-support--en)

#### Search and indexing

ScriptRunner for Confluence enables users to quickly find relevant Confluence content through our different search features. You can use these same search features within other features to automate different processes based on those search results (for example, there's CQL search in many of our [listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners)).

##### Add indexing

Add indexing methods to your Confluence content is a great way to yield good search results using [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) search:

-   [Page Info Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/page-info-macro): Add various meta data (like Modified By, Created Date, Page IDs, and many others) to your Confluence content. Example CQL to search for meta data: title `= "Company Values"`
-   [Versions History Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/versions-history-macro): Add version data about version history to your Confluence content. Example CQL to search for version data: `author = admin`
-   [Work with Labels](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels): Visit the _Create and Manage Content Hierarchy_ section on this page to see the different ways to manage labels to your Confluence content. Example CQL to search for meta data: `label = 2024`

##### Search your Confluence instance

Use [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search) to search your entire Confluence instance (or just parts of it) for anything you want using [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide)!

##### Use CQL

Use Confluence Query Language ( [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide)) to [perform advanced searches](https://developer.atlassian.com/server/confluence/advanced-searching-using-cql/). Advanced searches allow you to use structured queries to search for content in Confluence.

There are two features that allow you to save custom CQL components to use in your instance frequently:

1.  [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields): Create custom search fields to add useful indexes to Confluence's search to find content that meets specific criteria to expand CQL capabilities.
    
    Tip: This is customization for the first component of the CQL Query. For example, in the `lastUser = admin` query, this is the `lastUser` part.
    
2.  [CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions): Create custom CQL functions to create and share custom CQL functions (values) with your users in order to empower their search.
    
    Tip: This is customization for the third component of the CQL Query. For example, in the `space = allAttachments` query, this is the `allAttachments` part.
    

CQL can be run anywhere there is a search option in Confluence. You can also run CQL searches in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console) by using the [Perform a CQL Search in SR4C](https://www.scriptrunnerhq.com/help/example-scripts/perform-a-cql-search-in-scriptrunner-for-confluence-onPrem) Example Script.

We've also created a macro, [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro), that enables you to place it on a page where it executes the search and returns the results as links to pages.

##### Use SQL to search external databases

If you want to see SQL results from an external database, you can use the [Display SQL Results from an External Database Macro](https://www.scriptrunnerhq.com/help/example-scripts/display-sql-macro-onPrem) Example Script. This sets up a table using a custom macro on the page where it is used.

##### Search a page's source

Use the [XPath Search in Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/xpath-search-in-pages) to search a page's source. This can help you identify hidden structural problems in your Confluence content.

Warning: This is an advanced built-in script, and it's more powerful than using a typical Confluence search; however, it takes a long time to run and we recommend only using it on a single space.

##### HAPI script

[Search for Pages](https://docs.adaptavist.com/sr4c/latest/hapi/search-for-pages) with one simple script using HAPI!

### Managing users

-   [User license management](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#user-license-management--en)
-   [Manage access and permissions](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#manage-access-and-permissions--en)

#### Manage access and permissions

As a Confluence administrator, you might need to manage other users permissions and restrictions based on regulatory standards, confidential information, or to allow for external collaboration. ScriptRunner for Confluence has created several scripts to help you automate permission and restriction management.

For information about permissions required to use each ScriptRunner feature, please visit [Permissions](https://docs.adaptavist.com/sr4c/latest/get-started/permissions).

##### Copy permissions

There are two Example Scripts that automate processes for copying permissions for different Confluence content:

-   [Copy Individual Users Space Permissions from one Space to Another](https://www.scriptrunnerhq.com/help/example-scripts/copy-individual-users-space-permissions-from-one-space-to-another-onPrem): Copy all space permissions for individual users from one space to another within your Confluence instance.
-   [Copy Users from Space Permissions to a Local Group](https://www.scriptrunnerhq.com/help/example-scripts/copy-user-space-permissions-to-group-onPrem): Create a group and assign permissions to that group for users within a space that have already been assigned permissions individually.

##### Display user groups on a Confluence page

Use the [Mugshot Gallery Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/mugshot-gallery-macro) to add names and user pictures to a page in Confluence to see everyone in a group. This can be helpful if you want a visual representation of everyone in a group that has access to a space on a page.

##### Impersonate users

The [Switch to a Different User Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/switch-to-a-different-user) allows administrator users to temporarily assume the identity of another user. _Switch User_ has a variety of uses, such as:

-   Reproducing and troubleshooting problems specific to a user to diagnose permissions issues.
-   Updating content on behalf of another user if they are unavailable.

##### Manage restrictions

There are several scripts we created to help you automate management of page restrictions:

-   [Update Page Restrictions Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/update-page-restrictions): Replace the editing restrictions to all of the child pages when you select a parent page. You can select multiple pages and page trees to edit restrictions in bulk.
-   [Update Page Restriction Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/update-page-restrictions-job): Schedule and manage restrictions to parent and child pages. You can automatically add or remove restrictions to entire spaces or pages and manage access for newly created spaces.
-   [Update Page Restrictions Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/update-page-restrictions-listener): Add and remove restrictions to parent and child pages. You can automatically add or remove restrictions to blogs or pages based on a Confluence event.

Use the [Inherit Restrictions for Pages Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/inherit-parent-permissions-for-new-pages-listener) to create pages that inherit the parent page restrictions. This script offers administrators the option to specify which spaces should inherit parent page view and edit restrictions automatically.

##### Remove permissions

There are several Example Scripts that automate processes for removing permissions for different Confluence content:

-   [Remove Space Permissions for a User](https://www.scriptrunnerhq.com/help/example-scripts/remove-space-permissions-for-a-single-user-onPrem): Remove the space permissions of a single user from a specified space within your Confluence instance.
-   [Restrict Page by User Group](https://www.scriptrunnerhq.com/help/example-scripts/restrict-page-based-on-user-group-onPrem): Limit view and edit privileges on a page only to members of a specified group.
-   [Remove Space Permissions for a Group on All Spaces](https://www.scriptrunnerhq.com/help/example-scripts/remove-space-permissions-for-a-specified-group-on-all-spaces-onPrem): Remove the space permissions of a single group from every space within your Confluence instance.
-   [Roll Back Anonymous Space Permissions via Listener](https://www.scriptrunnerhq.com/help/example-scripts/remove-anonymous-permissions-listener-onPrem): Prevent anonymous permissions from being enabled in spaces using this listener script.

##### HAPI script

[Run Scripts as Other Users](https://docs.adaptavist.com/sr4c/latest/hapi/run-scripts-as-other-users) with one simple script using HAPI!

#### User license management

ScriptRunner for Confluence has created a few automations to help you manage your user licenses. For general information and help, visit [Licensing FAQ](https://docs.adaptavist.com/sr4c/latest/get-help/licensing-faq).

##### Deactivate users

We know there can be limitations with number of users, so we have created a script to help you manage old users. The [Check Active User Count and Disable Oldest User](https://www.scriptrunnerhq.com/help/example-scripts/check-active-user-count-remove-oldest-listener-onPrem) Example Script monitors the amount of users on your instance and disable the oldest user once a certain number is reached.

You can use the [Deactivate Inactive Users in Confluence](https://www.scriptrunnerhq.com/help/example-scripts/deactivate-users-confluence-onPrem) Example Script to deactivate users based on the time since they last logged in.

##### Give permissions

With just a username, you can easily re-activate user accounts that have been disabled using the [Enable Disabled Users](https://www.scriptrunnerhq.com/help/example-scripts/enable-disabled-users-onPrem) Example Script.

##### Update user credentials

If you have a company event that requires many or all of your user email licenses to be updated, we've created the [Update User Emails in Bulk](https://www.scriptrunnerhq.com/help/example-scripts/update-user-emails-in-bulk-onPrem) Example Script to automate the process.

##### HAPI script

[Work with Users](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-users) with one simple script using HAPI!

### Managing spaces

-   [Create and manage spaces](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#create-and-manage-spaces--en)
-   [Create and manage content hierarchy](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#create-and-manage-content-hierarchy--en)

#### Create and manage content hierarchy

A clear structure of content enables findability within your space, and ScriptRunner for Confluence has several features and scripts to help you automate hierarchy processes.

##### Create templates for complex Confluence instances 🌳

The [Automate the Creation of Complex Page Structures within Confluence](https://www.scriptrunnerhq.com/help/example-scripts/project-creator-for-confluence-onPrem) Example Script uses a REST endpoint to create complex page structures automatically. You can use this script every time you need the same page tree structure in your instance.

##### Move a page

Use the [Move a Page When Created](https://www.scriptrunnerhq.com/help/example-scripts/move-page-on-page-create-onPrem) Example Script as a [Custom Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/custom-event-listener) to move a page once it has been created. Using this script will keep the structure, and you can make sure any pages that were created stay together.

##### Work with labels

Labels are an easy and effective way to categorize your Confluence content. ScriptRunner for Confluence has several ways to automate label creation and maintenance.

-   _Built-in scripts:_ [Manage Labels](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels), a Confluence Administration built-in script, is a one-stop script to add, rename, and remove labels from one or more pages.
-   _Jobs_: Use the [Manage Labels Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/manage-labels-job) to schedule routine label management. You can manage labels on new pages and spaces to help your users find relevant content.
-   _Listener:_ To automate label maintenance based on a Confluence event, check out [Manage Labels Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/manage-labels-listener).
-   _Macros:_ To create a macro that automatically adds labels to pages where the macro is placed, follow the steps on [Add Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/add-label-macro) or watch this video:
    
    To create a macro that adds labels and generates suggested labels on a page if they are not present, check out [Choose Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/choose-label-macro) or watch this video:
    
-   _Example Scripts_: To add labels to attachments, use the instructions from the [Add a Label to an Attachment on a Page](https://www.scriptrunnerhq.com/help/example-scripts/add-label-inside-specific-attachment-in-a-page-onPrem) Example Script.

##### HAPI script

[Work with Labels](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels) with one simple script using HAPI!

#### Create and manage spaces

When your spaces are created and maintained well, it increases discovery within your space. Use ScriptRunner for Confluence features and scripts to customize, create, and maintain your spaces.

##### Customize pages in your space

Use the [Create Page Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/create-page-macro) to create a custom page in your space. Watch our video to see the Create Page macro in action:

Or, you can use the [Markdown Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown) to customize the format of the pages.

##### Create spaces based on a template space

If you're managing a large Confluence instance and create a lot of different spaces with the same general format, ScriptRunner can help you automate that process.

1.  [Create a space in Confluence](https://www.atlassian.com/software/confluence/resources/guides/get-started/set-up) that you want to model the other spaces after.
    
    Tip: Name it something like _Template Space_ to easily identify it as a template.
    
2.  Customize the _Template Space_ however you want.
3.  Use the ScriptRunner built-in script, [Copy Space](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/copy-space), to use the _Template Space_ to create new spaces.

##### Delete spaces

The [Remove Archived Space](https://www.scriptrunnerhq.com/help/example-scripts/remove-archived-space-onPrem) Example Script helps you remove unused spaces in your Confluence instance.

##### Maintain spaces by working with pages

Use these built-in scripts to automate simple page tasks within a space:

-   [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages)
-   [Rename Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/rename-pages)

##### HAPI script

[Create a Page](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/rewrite-scripts-for-cloud/adapt-scripts-for-confluence-cloud#create-a-page--en) with one simple script using HAPI!

### Other documentation

The following links take you to other ScriptRunner documentation that walks you through other best practices, app management, and scripting resources.

#### Further best practices reading

-   [Audit Logging](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/audit-logging)
-   [Set Up a Dev Environment](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/set-up-a-dev-environment)
-   [Store all Environment Specific Variables](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/store-all-environment-specific-variables)
-   [Test Your Code](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/test-your-code)
-   [Update Staging Environment](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/update-staging-environment)
-   [Version Control](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/version-control)

#### App management

-   [Update](https://docs.adaptavist.com/sr4c/latest/get-started/update)
-   [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security)

#### Scripting resources

-   [Advanced Logging](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/advanced-logging)
-   [Code Editor](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor)
-   [Script Plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins)
-   [Dynamic Forms](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/dynamic-forms)
-   [Introduction to Groovy](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/introduction-to-groovy)
-   [Script Roots](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-roots)
-   [Scripting Resources](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#scripting-resources--en)
-   [Static Type Checking](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/static-type-checking)
-   [Using GString Templates](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/using-gstring-templates)
-   [Clear Groovy Class Loader Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/clear-groovy-class-loader)
-   [Test Runner Built-In Scripts](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/test-runner)
-   [Configuration Exporter Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/configuration-exporter)
