# Release Notes

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes
- Doc ID: doc-sr4jc-101629570
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/release-notes

ScriptRunner Migration Suite

Try our migration tools!

The ScriptRunner Migration Suite (SMS) is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access to SMS, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## August 2026

### Jira Expression Language (.jel) scripts now available in Script Manager

As part of our ongoing enhancements to [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager), you can now manage saved `.jel` scripts in addition to `.groovy` scripts. Meaning that _Script Manager_ makes it easier to organize and reuse scripts across both the Groovy and Jira Expression Language code editors in ScriptRunner for Jira Cloud.

`.jel` scripts saved in _Script Manager_ can be reused in:

-   [Script Listeners (conditions)](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)
-   [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions)
-   [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)

### Update: Behaviours companion app now disabled

As previously outlined in our [July](https://docs.adaptavist.com/sr4jc/current/release-notes/release-notes#behaviours-enhancements) release notes, the Behaviours companion app has now been disabled.

All migrations and upgrades are complete, and any of your existing Behaviours have been moved to the main ScriptRunner for Jira Cloud app.

Date of change: **August 18th 2026**

### Script Manager enhancement

A new script usage feature has been added to [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) that enables you to check where your saved scripts are used across your ScriptRunner for Jira Cloud instance. It allows you to review details on the location and number of configurations where your scripts are loaded.

The script usage feature is available for scripts used in the following features: [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs), [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service), and [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields).

### Behaviours functionality is moving into ScriptRunner for Jira Cloud

This transition is currently underway, which means that the separate Behaviours companion app will be switched off once the move is complete. 

No data will be lost. Your Behaviours configurations transfer automatically into the ScriptRunner for Jira Cloud app.

For more information about what to expect during the move, see [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#id-.BreakingChangesvDraft-Behavioursplannedmaintenance). 

Date of change: **August 3rd 2026**

## July 2026

### Behaviours enhancements

We’ve rolled out some significant updates to the Behaviours feature, outlined below:

#### The Behaviours feature is fully integrated into the ScriptRunner for Jira Cloud app

Previously, using Behaviours required installing a separate ScriptRunner Behaviours companion app. We've now fully merged Behaviours into the ScriptRunner for Jira Cloud app to simplify your instance management.

-   **The reason:** This update is part of our ongoing platform migration of ScriptRunner from the Atlassian Connect framework to Forge to provide a more native experience.
-   **What to do:** Uninstall the standalone ScriptRunner Behaviours companion app when prompted. No further action is required.
-   **Zero disruption:** Your existing Behaviours will continue working as normal with no reconfigurations required.

For more information about what to expect during the merge, see [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#id-.BreakingChangesvDraft-Behavioursplannedmaintenance). You can also learn more in [ScriptRunner HQ](https://www.scriptrunnerhq.com/latest/product-updates/behaviours-native-integration-sr4jc).

#### JSM is now available on Behaviours

We've introduced new functionality that allows you to create and edit behaviours on JSM. Some things to note about this release:

-   JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time but will be available soon.
-   The [Behaviours Bot](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-bot) does not support JSM behaviours; however, this functionality will be released soon.

Refer to [Create and Modify JSM Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/create-and-modify-jsm-behaviours) for more details.

### Version numbering clarification

Since ScriptRunner for Jira Cloud version 8.0, all releases to the app have been classified by Atlassian as major version updates. This is due to a limitation in Atlassian's app versioning system, as outlined in the [Atlassian developer changelog](https://developer.atlassian.com/changelog/#CHANGE-3141), that currently treats every app release as a major version update, regardless of the scope of changes.

However, Atlassian provides a manual upgrade process that allows us to move all paying customers to the latest version, provided the update does not require additional app permissions. To date, all changes we have deployed meet this requirement. Nevertheless, this manual process is often time-consuming, and may take several days to complete. As a result, you may see an upgrade prompt in the Universal Plugin Manager (UPM) as we work through the manual process. No action is required from you, as we intend to upgrade all paying customers via this manual process. 

Atlassian is working on improvements to how Marketplace app updates are classified and rolled out. These changes are being introduced gradually and should reduce cases where routine ScriptRunner releases are incorrectly marked as major updates.

#### Changes between v8.0 and v28.0.0

The changes introduced across these versions are primarily focused on:

-   Forge events — Updates related to the ongoing migration from Atlassian Connect to the Forge platform, in line with Atlassian's platform direction.
-   General stability and performance improvements.
    

There are **no customer-facing breaking changes** between v8.0 and v28.0.0.

For details of functional or breaking changes in each ScriptRunner release, continue to refer to the relevant release notes and breaking changes documentation.

### Deprecation notice for Atlassian response body links format change

Atlassian is changing the format of URLs returned in REST API response bodies. Links such as self, \_links, and pagination URLs will no longer use your site base URL (for example, https://your-site.atlassian.net/rest/api/...) and will instead use the Atlassian API gateway format (https://api.atlassian.com/...).

Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/current/release-notes/breaking-changes#atlassian-response-body-links-format-change) section for more information.

## April 2026

### Update: Script Manager

As mentioned during the launch of the [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) feature in December 2025, we’re pleased to announce the following enhancements:

-   Moving and renaming folders and individual scripts
-   Duplicating individual scripts

These updates help you to restructure your folder hierarchy and better organise saved scripts.

### Advance notice: the Behaviours feature is being merged into the ScriptRunner for Jira Cloud app

Currently, using Behaviours requires installing a separate ScriptRunner Behaviours companion app. By the end of July 2026, this will no longer be necessary as the Behaviours feature will be fully integrated into the main ScriptRunner for Jira Cloud app. 

This change is part of the ongoing migration of ScriptRunner from the Atlassian Connect framework to Forge.

Once the update goes live, you'll be prompted to uninstall the ScriptRunner Behaviours companion app. Your existing Behaviours will continue to work as normal, and no reconfigurations will be required.

## March 2026

### Jira Cloud terminology documentation updates

As noted in our earlier March 2026 release note, ScriptRunner for Jira Cloud is aligning with Jira's updated terminology across the app UI and product documentation.

ScriptRunner for Jira Cloud documentation, including the in-app help, has now been updated. However, please note the following:  

-   Although the ScriptRunner for Jira Cloud UI now reflects Atlassian’s new terminology, the Jira Cloud API has not been updated. Therefore, ScriptRunner for Jira Cloud features that interact with the API, including [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search), still use the old terminology.
-   Some Atlassian documentation - particularly the [Jira UI modifications](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-ui-modifications/?tabId=3&tab=jira+global+issue+create#view-specific-requirements-and-limitations) guide - still uses the previous terminology. As a result, some of the [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) documentation currently reflects that older terminology with only minimal updates, and will be revised in due course. 
-   Training videos will be updated at a later date.

### Jira Cloud terminology changes

Atlassian has introduced updated terminology across its Jira Cloud products. You can read more about these changes in the following announcements:

-   [August 2025](https://community.atlassian.com/forums/Jira-articles/Evolving-Jira-terminology-Projects-will-soon-be-Spaces/ba-p/3034977#:~:text=Last%20year%2C%20we%20began%20our,or%20tracking%20company%2Dwide%20initiatives.)
-   [July 2025](https://community.atlassian.com/forums/Jira-articles/Out-with-the-old-workflow-editor-and-in-with-the-new-workflow/ba-p/3073415)
-   [May 2025](https://community.atlassian.com/forums/Jira-articles/It-s-here-Work-is-the-new-collective-term-for-all-items-you/ba-p/2954892)

To align with these updates, terminology in ScriptRunner for Jira Cloud is changing across the app UI, example scripts, demo videos, and the [ScriptRunner HQ](https://www.scriptrunnerhq.com/) website. Over the coming weeks, our product documentation will also reflect these changes. 

From March 2026, the following terminology updates will appear throughout ScriptRunner for Jira Cloud:

**Old term**  
 

**New term**  
 

Project 

**Space**

Issue (collective) 

**Work**

Issue (single) 

**Work item**

Conditions 

**Restrict transition**

Validators 

**Validate details**

Post-functions 

**Perform actions**

### Behaviours view types terminology changes

Also being introduced in March 2026 are updates to terminology within ScriptRunner's Behaviours feature.

Previously, when choosing where to apply a behaviour you selected from the _Create view_, _Issue view_, or _Transition view_ options. These have now been simplified to _Create_, _View/Edit_, and _Transition_.

You can select these options from **View type**, which replaces the previous **View** category, as shown below:

![](/sr4jc/files/latest/101629570/516719694/1/1772557141000/behaviour+view+types.png)

## January 2026

### Update: Script Manager

Following the launch of the [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) feature in December 2025, we’re pleased to share a helpful update that your saved folders can now be renamed.

## December 2025

### Additional supported field for Behaviours

Check out all the latest [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) for Behaviours, as we now support the _Project Picker_ field on the [Issue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvDraft-issueviewfields)**,** [Create](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvDraft-createviewfields), and [Transition](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#transition-view-supported-fields) views.

### New feature: Script Manager

We've introduced the new [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) feature to ScriptRunner for Jira Cloud! It allows you to create and manage saved `.groovy` scripts and folders directly from the ScriptRunner front-end, without relying on FTP services or server administrators. 

Script Manager helps you reuse and organize scripts in any of the Groovy code editors across your instance, making script management more efficient and accessible.

Check out our video demo below:

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

  

Coming soon...

Currently, we are working on creating further Script Manager enhancements, including:

-   Moving scripts
-   Renaming and moving folders 
-   Data residency support:
    -   Support for realm-to-realm migrations - we recommend **not** using Script Manager if you are planning a realm-to-realm migration before our next iteration of this feature.

Migrating? Script Editor and Script Manager

If you are migrating from ScriptRunner for Jira Server/Data Center and are familiar with the Script Editor feature, you'll find the addition of similar functionality in Jira Cloud a welcome enhancement. For a detailed comparison of features between these two versions of ScriptRunner, refer to our [migration documentation](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives).

### New Behaviours feature: Behaviours Bot (Beta version)

We've made it easier for you to use scripts in Behaviours by fully integrating the [Behaviours Bot](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-bot), an AI-powered script generation assistant.

This built-in, free-to-use feature of the Behaviours app converts natural, everyday language instructions into ready-to-use Behaviours scripts, helping to configure Jira fields quickly and accurately.

Using the Behaviours Bot offers several advantages when creating and managing Behaviours scripts:

-   **Simplified script creation**  
    Supports both technical and non-technical users by generating Behaviours scripts from natural language input.
    
-   **Faster Jira Cloud customization**  
    Converts requirements into Behaviours scripts instantly, speeding up configuration work.
    
-   **Improved reliability**  
    Built-in error checking and testing allow you to validate Behaviours scripts before deployment, reducing the risk of issues.
    
-   **Script preview  
    **Generated Behaviours scripts can be executed and previewed directly in a preview window.
-   **Lower training and support demands**  
    Helps teams customize Behaviours without needing scripting knowledge, decreasing the need for training or support.
    
-   **Context-aware AI assistance**  
    Generates accurate results informed by deep ScriptRunner and Jira Cloud expertise.
    
-   **Fewer bugs and misconfigurations**  
    Early error detection and clear Behaviours script generation lead to smoother workflows and fewer support tickets.
    

## October 2025

### Deprecation reports

Following our notice earlier this month regarding Atlassian's transition to Forge events and missing event properties, we have introduced a new [Deprecation Report](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#deprecation-reports).

You can use this report to identify any deprecated event types currently in use within your instance. Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties) section for more information.

### Script Context UI enhancement

We’ve updated how you can view script context information in the code editor. The _Script Context_ highlights a set of parameters/code variables that are automatically available in your script.

Previously, this information appeared above the code editor. Now, you can click the **Script Context** button in the code editor to open a modal containing these details.

### Atlassian's transition to Forge events and missing event properties

Due to [Atlassian’s platform changes](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps), the transition to native Forge events is required, and the deprecation of the old event model, resulting in missing event properties that cannot be retrieved from the Atlassian API. This change means you need to review and update any [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) that depend on the missing properties.

Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties) section for more information.

## August 2025

### Workflow Test and Expression Builder API update

We have updated the Workflow Test and Expression Builder tools to use the latest `v3/evaluate` endpoint of the [Jira Cloud Platform REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-jira-expressions/#api-rest-api-3-expression-evaluate-post). Previously, these tools relied on the `v2/eval` endpoint.

While the new `v3/evaluate` API functions similarly to its predecessor, it includes minor improvements and changes that enhance overall consistency and alignment with current platform standards.

No action is required for users, but developers integrating directly with the test API should update their references to use the new `v3/evaluate` endpoint.

## July 2025

### Enhancement: Automatic syncing for filters containing only `linkedIssuesOf` after region migration

We have made enhancements to ensure that after a region migration, filters containing only the `linkedIssuesOf` function now sync automatically. Previously, following a region migration, any filters containing only the `linkedIssuesOf` function did not automatically sync. However, these filters could still be synced manually and displayed correct results when a search was performed in the UI. 

If any affected filters had their JQL or name updated, syncing resumed as usual. All other filters, including those using the `linkedIssuesOf` function alongside other [ScriptRunner Enhanced Search JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions), automatically synced after a region migration.  
  
For example, before the enhancement:

This filter containing **only** the `linkedIssuesOf` function was not automatically syncing after a region migration:

-   ``issueFunction in `linkedIssuesOf`("issue=ES1")``

However, this filter containing the `linkedIssuesOf` function **and another** Enhanced Search JQL function was automatically syncing after a region migration:

-   ``issueFunction in `linkedIssuesOf`("issue=ES1") and issueFunction in childrenOf("project=Enhanced-Search")``

## June 2025

### Behaviours: UI enhancements

We’ve rolled out a series of powerful updates to the [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) home screen, making it faster and easier to manage your configurations across projects and issue types. These include:

-   **Improved Search**: The new search feature, including search by behaviour name or UUID, makes it easier to locate specific behaviours quickly.
-   **Advanced Filtering**: You can filter behaviours by Project, Affected Fields, and Issue Type to narrow down results and focus on what matters.
    
-   **Enable/Disable Behaviours**: You can activate or deactivate behaviours directly from the home screen—there is no need to navigate to configuration settings.
    
-   **Copy UUID**: Instantly copy the UUID of any behaviour with a single click for quick referencing or script use.
    
-   **Sort by Behaviour Name**: Organize your behaviours alphabetically or by other criteria to improve visibility and control.
-   **Tags**: Easily view projects, issue types, and affected fields for your Behaviours with tags. Hover over the tags to see all configured fields for a Behaviour in a tooltip. 
-   **Select All Projects or Issue Types**: When configuring a behaviour, **you can now select all projects or all issue** types with one action.
    
-   **Easy Navigation:** Behaviour names are now links that take you directly to the _Edit Behaviours_ screen. The improved navigation also keeps track of the page state when using the browser’s forward and back buttons..

These updates are designed to streamline your workflows and reduce time spent on setup and navigation. Check out our video demo below:

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### Scripted field enhancement

We've improved how [Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) results are updated. Previously, results were updated only when viewing an issue. Now, with this update, _results are also refreshed when an issue that contains a Scripted Field is updated_. This ensures more accurate and timely data.

To maintain optimal performance, we still recommend keeping your scripts as simple as possible to reduce loading times.

### HAPI enhancement: autocompletions

We've made it easier for you to use HAPI scripts in the code editor by offering helpful autocompletion functionality that automatically suggests scripts as you type. You can refer to our [HAPI documentation](https://docs.adaptavist.com/sr4jc/latest/hapi#autocompletions) for more details, or take a look at our demo video below:

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

## May 2025

### Updated deprecation reports

In March, we announced the introduction of a new [Deprecation Report](https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview/deprecation-reports) following on from Atlassian's REST API search endpoints deprecation, as outlined in our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation). 

The report was initially provided to help identify any deprecated search endpoints currently in use within your instance. We've now expanded it to include Parent and Epic Link fields due to Atlassian's upcoming deprecations, details of which you can find in our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation) section. 

### Atlassian deprecation of Parent and Epic Link fields

Atlassian have announced that parent and child issue associations are being standardised, resulting in the deprecation of the `Epic Link` and `Parent Link` custom fields in the REST API and webhooks.

#### Parent Link deprecation

Date of change: **June 13th 2025**

#### Epic Link deprecation

Date of change: **September 13th 2025**

Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation) section for more information.

### Date change for Atlassian REST API search endpoints deprecation

In March, we announced the [Breaking Change](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation) that search endpoints would be deprecated after May 1st 2025. We're pleased to share an update: the deprecation date has now been extended to **August 1st 2025.**

### HAPI method removal notice

The following [HAPI methods](https://adaptavist-api-docs-prod.s3.amazonaws.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/groups/Group.html#add\(java.lang.String\)) are scheduled to be removed on **August 1st, 2025** as they are only available in [HAPI for ScriptRunner DC.](https://docs.adaptavist.com/sr4c/latest/hapi)

-   `Groups.getByName("administrators").add(String accountId)`
-   `Groups.getByName("administrators").add(User accountId)`

### Enhanced Search: New additional JQL parameter

We've introduced an optional second JQL query within the `[childrenOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships)``(Subquery)` function to further filter descendant issues. We _**strongly recommend**_ you use this new second parameter option as it provides an effective way to narrow down and speed up search results provided by `childrenOf`.

### Documentation enhancements

Our [ScriptRunner Migration to Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud) documentation has been updated. In particular, the [Rewrite Scripts for Cloud Hints and Tips](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips) page now contains additional content providing step-by-step instructions, best practice tips, and examples to help support your migration from ScriptRunner for Jira Server/Data Center to ScriptRunner for Jira Cloud.

## April 2025

### Deprecation reports

Following our notice last month regarding Atlassian's REST API search endpoints deprecation that will no longer be available after **May 1st 2025**, we have introduced a new [Deprecation Report](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation#deprecation-reports).

You can use this report to identify any deprecated search endpoints currently in use within your instance. Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation) section for more information.

## March 2025

### Atlassian's new transition experience compatibility with Jira expressions

Atlassian's [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira is being permanently rolled out from **April 2025**. As a consequence, how your Jira expressions ([conditions](https://docs.adaptavist.com/display/SR4JC/.Conditions+vDraft) and [validators](https://docs.adaptavist.com/display/SR4JC/.Validators+vDraft)) work will change.

Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) section for more information.

### Atlassian REST API search endpoints deprecation

The following Jira Platform REST endpoints will be deprecated and no longer available for use after **May 1st 2025**:

-   `GET /rest/api/2|3|latest/search`
-   `POST /rest/api/2|3|latest/search`
-   `POST /rest/api/2|3|latest/search/id`
-   `POST /rest/api/2|3|latest/expression/eval`

Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-rest-api-search-endpoints-deprecation) section for more information.

### Results page UI update

Currently, when your search results return several pages of information in the [ScriptRunner for Jira Cloud Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) app, you navigate through them using page numbers. 

![](/sr4jc/files/latest/101629570/339513241/1/1741881585000/ES+old+page+numbers.png)

We have updated our UI and now use **Previous** and **Next** options, along with an indication of the number of pages.

![](/sr4jc/files/latest/101629570/339513242/1/1741881585000/ES+new+numbers.png)

Gradual Roll-out

Not all ScriptRunner for Jira Cloud Enhanced Search users will see this change immediately as we gradually roll-out the functionality.

### HAPI enhancement

**EntityProperties**

You can now work with entity properties using HAPI. Check out the [Work with Entity Properties](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-entity-properties) page for more information. 

## January 2025

### Behaviours now available on team-managed projects

We have expanded the functionality of the Behaviours feature. Now, your behaviours can be applied to both company-managed projects _and_ team-managed projects.

Refer to [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) for more information.

### HAPI is live!

**HAPI gives you a simplified way to define your Jira automations in Groovy.**

Our major scripting innovation is now available to use in ScriptRunner for Jira Cloud. HAPI is an API optimized for Jira automations and integrated within the script editor. It enables you to create automations and customizations faster than ever.

Take a look at our [HAPI documentation](https://docs.adaptavist.com/sr4jc/latest/hapi) to find helpful examples, videos, and much more.

HAPI library scripts

We've updated a number of [Library scripts](https://library.adaptavist.com/search?library-content%5BrefinementList%5D%5Btag_names%5D%5B0%5D=hapi) to include HAPI methods. If you have used any of these Library scripts in the past, you'll notice that the release of HAPI means they're now shorter and easier to understand.

### New Behaviours on transition view

The ScriptRunner for Jira Cloud Behaviours feature has expanded from working only on the **Global Issue Create** and **Issue** views to now include the additional **Transition** view.

This means that Behaviours can be applied to this view to dynamically control how fields behave (e.g., making fields required, hidden, or pre-filled) during an issue transition. It's worth noting that not _all_ field types are supported for Transition view, as outlined in [Behaviours Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-transitionviewfields).

You can watch our video below to understand how this functionality can be used:

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

## December 2024

### Additional supported fields for Behaviours

Check out all the latest [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) for Behaviours, as we now support the _C__ascading Select_ field on **[Issue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-issueviewfields)** and [**Create**](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-createviewfields) views.

On **[Issue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-issueviewfields)** view we now also support the _Original Estimate_ field.

### Documentation enhancements

We have incorporated several new videos into our [ScriptRunner Enhanced Search section](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) and enhanced the content to improve usability and ease of reference. Specifically, we have added new demo videos to several parts of the [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) chapter and introduced a [Troubleshoot ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search) section. 

## November 2024

### New Behaviours on screen tabs

To improve clarity and usability, especially for issues with a large number of fields, we now support screen tabs in Behaviours on both **Create** and **Issue** views. These tabs help organize fields on issue screens into separate, easily navigable sections or tabs, effectively reducing clutter and making it easier to find specific fields.

You can refer to our [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-tabs) page for more information and view our helpful [example video demo](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour).

### Atlassian's Epic Link field

Customized Epic Link field

If you've renamed or customized the **Epic Link** default field in your Jira instance, you may notice issues with epic-related queries, such as:

-   Failures with getting automatic syncing and the most up-to-date results.
    
-   Epic-related JQL functions (e.g., `epicsOf, linkedIssuesOf`) not returning expected results.
    

Atlassian has deprecated the **Epic Link** field and now recommends using the **Parent** property to link to epics. Since the **Epic Link** field was customizable, any epic fields that you have renamed or customized are no longer supported in JQL queries.

### Search time limit improvement

Currently, if a JQL search takes more than 30 seconds to complete on the ScriptRunner Enhanced Search page, it times out and returns no results. This primarily affects Jira instances that contain large projects.

To help you obtain search results from long-running queries, we have increased the 30-second limit to 2 minutes for the search bar only. If you save this as a filter, automatic syncing won't work, and you will need to run the query in the search bar again to get the most up-to-date results.

The new time limit also includes UI improvements, such as a progress bar and an estimated run time for queries.

### Additional supported fields for Behaviours

We now support the following fields for Behaviours on the **Create** view:

-   due date field
-   target start custom field
-   target end custom field

Check out all the latest [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-issueviewfields) for Behaviours.

## October 2024

### New example scripts in-app

We've updated all code editors within ScripRunner for Jira Cloud to include a new **Example scripts** button, as shown in our Script Listener example below:

![](/sr4jc/files/latest/101629570/294139601/1/1729840695000/release+note.png)

You can now click the **Example scripts** button, which opens a modal screen containing a list of examples relevant to the feature you are using. Select your preferred example and the associated code displays automatically. Copy the code using the **Copy Code** button and paste it into the code editor to reuse.

This improvement means you no longer need to leave your current task to open a separate [Adaptavist Library](https://library.adaptavist.com/search?library-content%5BrefinementList%5D%5Bapp_pretty_names%5D%5B0%5D=ScriptRunner%20for%20Jira&library-content%5BrefinementList%5D%5Bplatforms%5D%5B0%5D=cloud) window, as the in-app examples are identical to those provided there. 

## September 2024

### Additional supported field for Behaviours

Check out all the latest [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products#id-.BehavioursSupportedFieldsandProductsvCurrent-issueviewfields) for Behaviours. We now support the Status system field on **Issue** view.

### Java version upgrade

We have upgraded the execution environment where your scripts run from Java 11 to Java 17. See [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes) for more details.

## May 2024

### Performance and reliability improvements

We are no longer updating the search results for [Enhanced Search saved filters](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries#id-.ScriptRunnerEnhancedSearchJQLQueriesvCurrent-SavedFilters) that have not been used in Jira for 2 months or more. Specifically, _using_ the saved filter refers to viewing it in a Jira search, a dashboard or an agile board powered by the filter, or other such instances, such as being part of a Confluence macro that uses the filter. Note that viewing the search results for those saved filters does not count as actually using them.

## April 2024

### Additional supported fields for Behaviours

Check out all the latest [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfields) for Behaviours, as we now support the Parent system field on the **Create** view and the Parent, Components, Reporter, User Picker and Multi User Picker on **Issue** view.

### Improved Behaviours mapping

You can now create a Behaviour on a field that is applied to **all issue types** or **all projects**. Being able to map to all projects or all issue types removes the need to select each project or each issue type individually, which can save time if you have an instance with hundreds or thousands of projects.

![](/sr4jc/files/latest/101629570/253362386/1/1713518987000/mapping.jpeg)

Behaviours mapping note

You should note that when the '_All projects'_ option is selected and a project is added or removed from your instance, it will still be mapped to all projects in that instance. However, if you select all current issue types to map to and a new issue type is created, you must manually add this to the mapping, as it is not automatically added.

## March 2024

### New code editor 

We've replaced our in-app editor component with a new [code editor](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud#id-.ScriptinginScriptRunnerforJiraCloudvCurrent-codeeditor).

Importantly, this gives us a platform for future improvements. However, there are immediate benefits to this release: you get inline documentation (press **Control+Space** when completions are open), hover over methods and classes to see documentation, see completions automatically as you type, find and replace, and more. 

This editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Custom ScriptRunner-defined script variables 

### New support portal

Our [Adaptavist Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27) has moved! Please update your bookmarks.

Visit [this page](https://docs.adaptavist.com/log-in-to-the-tag-support-portal) for help logging into the portal.

### Support for issue type events for Jira admin webhooks

We now support the following Jira admin webhook events: `issuetype_created,issuetype_updated` and `issuetype_deleted` whenever an issue type entity is created, updated or deleted.

### New Behaviours custom field

We have introduced the new [date time picker field](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#date-time-picker) for Behaviours [Create and Issue View](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfields).

## February 2024

### Additional supported fields for Behaviours on issue view

Check out all the latest [Supported Fields/Methods](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#issue-view-supported-fields) for Behaviours on the **Issue** view, as we now support the get/set description method.

### Scripted Fields now act like Jira custom fields

**We are currently rolling out the changes to the Scripted Fields feature, so you should see the update over the next couple of days.**

As we [previously announced](#id-.RecentReleaseNotesvCurrent-comingsoon), significant changes have been released for how [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) are configured in ScriptRunner for Jira Cloud and how they work. Now, every time a scripted field is created, a Jira custom field will also be generated on your Cloud instance.

You will add your script to the scripted field in ScriptRunner but configure the field anywhere you'd like within Jira's configuration screens, just like you would with any other custom fields.

If you have existing scripted fields, they will automatically update to the new way of working. 

This means you will see a new custom field for every existing scripted field you have saved.

**If your Scripted Field was:**

-   **Disabled** \- the corresponding custom field will not be configured on a screen and, therefore, not shown to any users.
-   **Enabled** \- we will take the current project/issue type mapping and match it to Jira's configurations using a combination of field context and adding it to the proper screen/s. 

Mapping

If you have scripted fields mapped to team-managed projects, the created custom fields cannot be configured with field context or to any screens. This will need to be done manually.

### New JQL function: childrenOf

Introducing the `[childrenOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions#id-.JQLFunctionsvCurrent-childrenof)` function, a powerful addition that enables you to find descendant issues of a given subquery, including children, grandchildren, and beyond. This function enhances your ability to drill down into the specifics of project elements, offering a more detailed view of issue relationships.

For example, you could use this new function to find children issues of a project, excluding subtasks: `issueFunction in childrenOf("project = DEMO") and issueType != "Subtask"`

Check out our video demo [here](https://youtu.be/oPNhah4ljf4?si=2dYlax2RPryg-LGy)!

### Updated JQL functionality: parentsOf

The `[parentsOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions#id-.JQLFunctionsvCurrent-parentsof)` function is now more robust, enabling you to find ancestor issues of a given subquery, including parents, grandparents, and beyond. This expanded capability allows for more comprehensive and hierarchical searches within your projects.

To utilise this feature, simply add a second argument with the string “`all`” to your query.

For example: `issueFunction in parentsOf("project = DEMO", "all")`

## January 2024

### Script Listener infinite loop restriction added

Previously, it was important to ensure that your scripts did not inadvertently trigger events your [script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) was listening for, as this risked causing an infinite loop. However, now, self-triggering scripts cannot execute after 1000 runs. This restriction means that if a script creates an event that results in the same script running again, ScriptRunner will count the number of times this occurs and reject the 1001st run. If this occurs, you will see a log message informing you that Scriptrunner has cut off a self-triggering script loop.

### Additional supported fields/functions for Behaviours

Check out all the latest [Supported Functions](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfunctions) and [Supported Fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfields) for Behaviours, as we now support the FixVersion/s system field on the **Issue** view and number custom field types on both the **Create** and **Issue** views.

### Increased script timeout limits

We have increased the duration of [timeouts](https://docs.adaptavist.com/sr4jc/latest/get-started/limitations) for script executions!

The previous limit was set at 120 seconds; now, we have increased this limit to 240 seconds for script executions.

## Coming soon!

### Scripted Fields are becoming Jira custom fields

#### What's happening?

Currently, [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) are entirely created and saved within ScriptRunner. This includes the mapping selection of the Scripted Field as well as giving it a search term in order to find it using JQL in Jira. Very soon, we'll be releasing an upgrade where every time a Scripted Field is created, a Jira custom field will also be generated on your Cloud instance. You will add your script to the Scripted Field in ScriptRunner but configure the field anywhere you'd like in Jira's configurations, just like you would with any other custom fields.

Some of the benefits of having a Scripted Field as a custom field include: 

-   Better display and user experience
-   Improved discoverability
-   Increased flexibility since you'll be able to move custom fields anywhere you'd like on a screen

#### What about my existing Scripted Fields?

If you have existing Scripted Fields, they will automatically update to the new way of working.

This means you will see a new custom field for every existing Scripted Field you have saved (without having to lift a finger!)

**If your existing Scripted Field is:**

-   **Disabled** \- it will become a custom field, but it will not be configured on a screen and, therefore, not shown to any users.
-   **Enabled** \- we will take the current project/issue type mapping and match it to Jira's configurations using a combination of field context and adding it to the proper screen/s. 

For example: 

-   Old Scripted Field mapping:

-   Project: TEAM / issuetype: Story

-   New Scripted Field mapping:

-   Field context limit to only project TEAM, and only issuetype Story; Added to the screen which is mapped to the project TEAM and issue type Story.  
    **Note:** Field context is necessary in the event that your issue type screen scheme has mappings to multiple projects and/or issue types that are not in your original mapping.

The new location of your Scripted Field will default to the bottom of the screen of the side panel. You may move this to anywhere you please by updating the screen and/or [configuring the issue layout](https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-layout/).

#### **What will happen to my saved filters that include a Search Term in the JQL?**

Your filters will be updated to use the Scripted Field's name.

## November 2023

### Additional supported fields for Behaviours on create view

Check out all the latest [Supported Fields/Methods](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#create-view-supported-fields) for Behaviours on the **Create** view, as we have added to those listed earlier in the month.

### New Behaviours on issue view

We have expanded the functionality of the ScriptRunner for Jira Cloud [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) feature, so it's now possible to use behaviours on the newly added **Issue** view along with the **Create** view. Watch our latest [video](https://youtu.be/1PHWxlflR2o?si=2lG3K3ktFvEKAclu) showing how to use this functionality. 

It's worth noting that not _all_ field types are supported for issue view. You can refer to the details outlined in [Supported Fields/Methods](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#issue-view-supported-fields).

## October 2023

### Groovy version upgrade

We updated ScriptRunner for Jira Cloud to Groovy 4 on October 4 2023! 

#### Other new features in Groovy 4: 

The following are the most significant new features that have been added in Groovy 4 :

-   [Switch expressions](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-switch-expressions) which, unlike switch statements, are optimized towards branches that handle one case and break out rather than fall through to the next case.
-   [Sealed types](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-sealed-types)
-   [Records](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-new-records)
-   [Ranges have been enhanced](https://groovy-lang.org/releasenotes/groovy-4.0.html#_enhanced_ranges) with support for ranges open on the left, for example, 3<..5, or both sides, for example, 0<..<3
-   [Support for annotating generic types](https://groovy-lang.org/releasenotes/groovy-4.0.html#_jsr308_improvements_incubating), for example List<@IntRange(min = 0, max = 10) Integer>

Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of new features.

Visit [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#BreakingChanges-groovy4) to learn how Groovy 4 could affect and break your scripts.

## September 2023

### New Behaviours Issue Type supported

We have added support for the [Issue Type](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfields) field to behaviours.

### New Behaviours Project Type supported

Behaviours now support [Company Managed Work Management](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-behaviourssupportedfunctions) projects.

### New Behaviours API method

The new `[getContext()](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-getContext)` method has been added to the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api).

## August 2023

### Rich Text Scripted Fields

We have added some new functionality to [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields), which means you can now use [rich text](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields#id-.ScriptedFieldsvCurrent-richtext). Check out our script example in the [Adaptavist Library](https://library.adaptavist.com/entity/rich-text-table). You can also watch our [demo video](https://www.youtube.com/watch?v=I0UD_MH2vg8) showing how to display tables within scripted fields using rich text.

### Notice of deprecated JQL keywords

We've identified a few [keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) that are either not functioning as expected or already have their use cases covered by Jira Search. As a result, the following keywords will be removed on **1 November 2023**:

-   `hasLinks`
-   `commentVisibleGroup`
    
-   `commentVisibleRole`
    
-   `worklogVisibleRole`
    
-   `worklogVisibleGroup`
    
-   `lastCommentVisibleRole`
    
-   `lastCommentVisibleGroup`
    
-   `issueLinkType`

You should review any queries related to these and change them accordingly. For example, you could use `issueLinkType` (which is provided by Atlassian [here](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Issue-link-type)) in queries where you currently use `hasLinks` to search for issues based on the type of issue links you have.

## July 2023

### New component and fixVersion fields

You can now use the component and fixVersion fields in your behaviours, as shown in the **[getValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-getValue)** and **[setValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-setValue)** methods of the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) page.

### New Behaviour API methods

The new `getOptionsVisibility` and `setOptionVisibility(options,isVisible)` methods have been added to the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api).

### Atlassian JQL bug affecting assignees

Atlassian is currently aware of a bug that affects `assignee in (...)` when used with display names. This bug can cause inconsistent results when the JQL is executed within an Enhanced Search query.

Atlassian is working on a fix for this bug, but there is no ETA for the release. In the meantime, you can use account IDs instead of display names in your JQL queries as a workaround.

For example, instead of `assignee in ('John Doe', 'Jane Doe')`, use `assignee in (1234567890, 9876543210)`.

## June 2023

### New Behaviours UI

We've made it easier to directly add [Behaviour scripts](https://docs.adaptavist.com/sr4jc/latest/features/behaviours), replacing the Behaviours Fields section with the new Behaviours Scripts one.

## May 2023

### New Behaviours system field

We have introduced the new [r](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-BehavioursSupportedFunctions)[eporter system field](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-BehavioursSupportedFunctions) function for Behaviours.

## April 2023

### New Behaviours custom field

We have introduced the new custom [checkbox supported field](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-SupportedFields) for Behaviours.

### New Behaviour API method

The new `getType` method has been added to the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api).

### Behaviour API method property deprecated

Refer to Atlassian's [documentation](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/) for more details regarding this deprecation.

The usage of the **[getValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-getValue)** and **[setValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-setValue)** methods has changed for several field types. Refer to [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) for more information.

For the **assignee**, **userPicker** and **multiUserPicker** fields, only accountIds are returned as the displayName property is no longer available. Scripts that rely on `displayName` information will break; instead, you will now have to make a request to ``/rest/api/3/user?accountId=`$`{accountId}`` and/or ``/rest/api/3/bulk?accountId==`$`{idsToFetch.join("&accountId=")}.``

For **single** and **multiselect**, you must use the `id`  of the option istead of an object containing the `id` and `name`. 

## March 2023

### New Behaviours API methods

New methods have been added to the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api): `isRequired` and `setRequired.`

## Jan 2023

### New Behaviours custom fields

We've gone beyond the recent introduction of [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) for ScriptRunner for Jira Cloud that supported actions on five key **system** **fields**: priority, summary, assignee, labels and description - now, you can use Behaviours on your [custom fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-SupportedFields). These include:

-   Custom single select fields
-   Custom multiple select fields
-   Custom paragraph (multi line text) fields
-   Custom user picker fields
-   Custom multiple user picker fields
-   Custom text field

Read more in our [blog](https://www.adaptavist.com/blog/scriptrunner-behaviours-for-jira-cloud-now-supports-custom-fields).

## Dec 2022

### New Behaviours feature

We've introduced [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) for ScriptRunner for Jira Cloud: gain control over fields, expand standard configurations and customise how fields behave. Read more in our [blog](https://www.adaptavist.com/blog/scriptrunner-behaviours-for-jira-cloud-is-here).

One of the most popular ScriptRunner for Jira features is now also available on Cloud. Behaviours deliver a brand new boost to your Jira customisation power, allowing you to conditionally change how fields behave when creating a new issue under a specific project or issue type.

## Nov 2022

### Get involved

Want to know how you can get involved with shaping the future of ScriptRunner? Check out our [Get Involved](https://docs.adaptavist.com/sr4jc/latest/get-involved) page. 

## March 2022

A new **[Migration report](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration/migration-reports)** is available that displays any failed items after you have migrated from ScriptRunner for Jira for Server/DC to Cloud using the Jira Cloud Migration Assistant.

## Feb 2022

UI improvements have been made to the **[S](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)[cript Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments)** page.

## Feb 2022

New example scripts have been added to the **[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)** page.

## Jan 2022

UI improvements have been made to the **[Scripted Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables)** page.

## Dec 2021

[Saved Enhanced Search filters](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries#id-.ScriptRunnerEnhancedSearchJQLQueriesvCurrent-SavedFilters) can be accessed and shared directly from **ScriptRunner Enhanced Search** page.

## Nov 2021

UI improvements have been made to the following pages:

-   **[Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs)**
-   **[Escalation Services](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service)**
-   **[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)** and
-   **[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)**.

## April 2021

-   Database connection calls can now be made via groovy within ScriptRunner for Jira Cloud, meaning that you can read or write to a database as part of a script. Refer to the [Script Examples](https://docs.adaptavist.com/sr4jc/latest/features/script-console/example-scripts) page.
-   The list of libraries from which you can import packages into your scripts has increased to include:
    -   org.codehaus.groovy:groovy-sql:2.5.12
    -   org.postgresql:postgresql:42.2.19
    -   mysql:mysql-connector-java:8.0.23
    -   com.microsoft.sqlserver:mssql-jdbc:9.2.1.jre11

## March 2021

-   Added the ability to use **[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)** when searching for issues with JQL.

## February 2021

-   Added new **[Built-in Script](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts)** for cloning issues in bulk and moving to a new project.

## Apr 2020

-   Menu items have been consolidated in the UI to improve navigation. **[Escalation Services](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service)**, **[Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables)**, and **[Script Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments)** are now found under the **More** drop-down.
    

## 7 Jan 2020

-   Added ScriptRunner Script Conditions and Validators that can be added to a workflow transition.
