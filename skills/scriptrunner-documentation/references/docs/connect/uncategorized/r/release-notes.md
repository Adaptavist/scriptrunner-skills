# Release Notes

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194675058
- Source: https://docs.adaptavist.com/src/latest/release-notes

Here are the changes we document in the Release Notes:

-   **New features** \- Brand new functionality designed to make ScriptRunner Connect an exceptional app.
-   **Updates** \- Changes we've made, large and small, that we want you to be aware of.
-   **Bug Fixes** \- Issues we've resolved to make ScriptRunner Connect work as intended.

## 20 July 2026

### Update

We've expanded our [REST API](https://docs.api.scriptrunnerconnect.com/#/) to include endpoints, for working with event listeners.

## 2 March 2026

### New feature

We've added [FIFO Event Queue](https://docs.adaptavist.com/src/latest/workspaces/event-queues), which allows processing incoming events sequentially rather than concurrently, reducing the risk of race conditions.

## 24 February 2026

### Update

We have a very exciting update to share! ✨

#### Pro Plan Free Trial

A free, 3-month trial of the Pro Plan is available to users of the Free Plan and users who annually subscribe to the Basic and Advanced Plans.  
With a trial of the Pro Plan, you'll have access to unlimited script executions and connectors.  
You'll also have access to a trial of [Remote Workspace](https://docs.adaptavist.com/src/latest/external-coding), which is only available on paid plans. This allows you to access, edit, and manage integrations directly from your own development environment. 

  
To initiate your free trial in 3️⃣ easy steps:

1.  Log in to ScriptRunner Connect and click **Start free trial** in the _Settings_ section of the left-hand menu.   
    ![](/src/files/latest/194675058/517019989/1/1771950789000/start-free-trial.png)  
    A dialog box opens with the instructions needed to begin a free trial. 
2.  Follow the instructions in the dialog, which will walk you through raising a support ticket.
3.  Once we approve your trial request, we'll send you a confirmation and let you know how to quickly start your trial. 

## 19 February 2026

### Updates

We have 2️⃣ important updates:

#### Security 🔒

[Enhanced isolation mode](https://docs.adaptavist.com/src/latest/scripting/runtime#enhanced-isolation-mode) is now available for added security.

-   This adds an extra layer of security against sandbox escape.
-   This feature is available only for paid users.

#### New runtime version 🆕

An enhanced [runtime version](https://docs.adaptavist.com/src/latest/scripting/runtime#versions) (V2) is now available. 

-   You may select the new version using the **Runtime version** option in the _Workspace edit_ settings.
-   Our V2 runtime version will be made the default option on the 1st of April 2026.

V2 runtime benefits:

-   Upgraded internal implementations of [TextEncoder](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder) and [TextDecoder](https://developer.mozilla.org/en-US/docs/Web/API/TextDecoder) APIs.
-   A `fastTransfer` option for some APIs that work with [ArrayBuffers](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer).

## 29 January 2026

### Update

We added support for [deploying remote workspace content from CI/CD pipelines](https://docs.adaptavist.com/src/latest/external-coding/deploying-from-build-pipelines).

## 16 January 2026

### Update

Expanded public API coverage to support [CRUD operations for environment variables](https://loop.scriptrunnerhq.com/c/integration-forum/now-supporting-programatic-access-for-environment-variables-parameters) (parameters).

## 08 January 2026

### Update

Added support for [base64 content streaming for large attachments](https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-attachments?_gl=1*1rlxry*_gcl_au*MTA2OTkyMTg1Ni4xNzYyOTM5Njc3*_ga*NDU0OTkwNDYwLjE3MzQ1MTY3MjI.*_ga_JSWCBH0VZP*czE3Njc4ODY2MTMkbzUzJGcxJHQxNzY3ODg2OTUzJGo1MSRsMCRoMA..#using-base64-upload). 📌

## 12 December 2025

### Update

We introduced a minor terminology change in the remote workspace structure for agentic coding.  
Find more [information documented here](https://loop.scriptrunnerhq.com/c/integration-forum/introducing-a-minor-change-in-remote-workspace-structure-for-agentic-coding). 

## 21 November 2025

### New features

We have 1️⃣ cool new feature to share:

**Duplicate parameters 👥**

To avoid the tedious task of recreating the same or similar parameters across environments in the workspace, we've created the ability to [duplicate parameters](https://docs.adaptavist.com/src/latest/workspaces/parameters#id-.ParametersvDraft-Duplicateaparameter%F0%9F%91%A5).   
This feature is available in the _Parameters_ section of every environment.

## 03 November 2025

### New features

We have 3️⃣ wonderful new features to tell you about:

#### External coding update 🔑

External Coding features are now available to use without request.   
See the [External Coding](https://docs.adaptavist.com/src/latest/external-coding) section of the documentation to learn more about customising your coding experience.

#### Share a connector 📩

We released a new feature that allows you to share connectors with teammates.

Read more about connector sharing on our [Connectors](https://docs.adaptavist.com/src/latest/connectors) page.

#### Customised notifications ⚠️

[Customise script failure notifications](https://docs.adaptavist.com/src/latest/security) on a workspace level.

## 09 June 2025

### New feature

We released a team scope for Record Storage. Read more about it [here](https://loop.scriptrunnerhq.com/c/integration-forum/record-storage-now-supports-team-level-scope).

## 02 April 2025

### Updates

SRC went live with a [US-based version of ScriptRunner Connect](https://www.scriptrunnerhq.com/scriptrunner-connect/us-data-residency) to enable US businesses to store their data within US borders for regulatory compliance.  
This new feature is available across all pricing plans at no additional cost.

We made improvements to our Parameters feature for a better developer experience:

-   You can now use Monaco code completion to show which parameters have been created in your workspace, rather than checking the parameters tab to see which are defined.
    
-   Parameters are now typed, allowing you to use related methods without casting the parameters to their type.
    

## 10 March 2025

### New features

We have 2️⃣ new AI-related features to share! 

#### AI Explain Error 🔎

A new feature has been added to help you resolve errors in the console. The AI Explain Error feature uses our AI assistant to help you understand the context and specific error message when one is displayed in the console. You'll be able to send or omit the relevant code with the error message when prompted to use this feature.

#### AI Explain Code 📍

To have our AI assistant help you by explaining a section of code, simply highlight the relevant section with your cursor and select the **AI Explain Code** option after a right-click in the same area. This will open a new window where our AI Assistant will be prompted to give the proper context for your highlighted section of code.

## 28 February 2025

### Update

#### AI assistant chat history 🪄

The AI Assistant has been updated to include a _Chat history_ option. This option lets you see previous interactions with the AI Assistant across sessions, browsers, and users.   
Chat history will remain available when accessed via anonymous browsers and even when the system crashes. You may also delete your chat history manually if desired.

## 13 February 2025

### New feature

#### Public REST API ⚡

An initial set of [REST API](https://docs.adaptavist.com/src/latest/rest-api) endpoints were released that now allow query script invocation and audit logs from ScriptRunner Connect. If you want to store our logs longer than we are or would like to push logs to your third-party systems for analytical or monitoring and alerting purposes, you now have this option. To illustrate how to go about querying our logs, we have an accompanying [t](https://templates.scriptrunnerconnect.com/template/backup-sr-connect-logs-into-aws-s3)emplate that periodically creates a backup of script invocation logs in AWS S3.

## 04 February 2025

### Update

We updated the templates screen with two new filtering categories, _Use cases_ and _Complexity,_ to help you find relevant listings! ![magnifying glass tilted left](/plugins/servlet/twitterEmojiRedirector?id=1f50d "magnifying glass tilted left")   
![](/src/files/latest/194675058/326078785/1/1738773297000/SRC-templates-page.png)

### New features

#### New connector! ⚡

We created a connector for AWS! 🤩 Fine details can be found on the [Connectors](https://docs.adaptavist.com/src/latest/connectors) page.

#### New templates!

We have 2️⃣ new templates to tell you about:

We created a [new template for AWS S3](https://templates.scriptrunnerconnect.com/template/01JK8TYP5DBZQMV070EDF2Q6J7)!  
The template copies newly added Jira Cloud attachments to AWS S3.

We created a [new template for Azure DevOps](https://templates.scriptrunnerconnect.com/template/01JJ1TQ0P4WD95XNDPM9CKXA9K)!  
The template creates a work item in Azure DevOps when an issue is created in Jira Cloud.

## 23 January 2025

### New feature

We have 1️⃣ cool new feature to share:

#### AI assistant 🪄

We created an AI assistant based on the ChatGPT 4o model to help you write scripts, learn cool things about the ScriptRunner Connect app, and find awesome templates for your use cases.

See [AI Assistant](https://docs.adaptavist.com/src/latest/get-help/ai-assistant) to learn all about it!

## 20 November 2024

It's been a year since we launched ScriptRunner Connect, so we're rolling out some major improvements to the app—and we've got more in store for 2025! 

### Updates

We have 4️⃣ stellar updates to tell you about!

#### Feature name change 🔀

We changed "Environment Variables" to "Parameters." They work the same as always; we just improved the name. See [Parameters](https://docs.adaptavist.com/src/latest/workspaces/parameters). 

#### New and improved navigation 🧭

The new side-navigation design makes it faster to move around the platform to find exactly what you need. Useful information has been thoughtfully restructured to help you find team and personal settings more conveniently. Plus, you can now see the appropriate workspaces and connectors for the team you've selected. Pretty solid update!

#### Setup guide 🌟

A new setup guide has been implemented to assist you through a seven-step process that covers selecting apps to work with all the way to testing and running the integration. 

#### Usage-insights dashboard 📊

Keep track of key usage stats at a glance! The new usage dashboard lets you

-   see the progress of your monthly script executions against your allowance,
-   review relevant integration templates, and
-   watch tutorials to become an integration pro!

To view the usage details, just visit the _Home_ tab. 

![](/src/files/latest/194675058/304349553/1/1732117325000/usage-dashboard.png)

### Coming soon! ⏰

-   **Setup guide for onboarding ⚡**  
    We're simplifying the onboarding process with an easy-to-follow guide designed to help you get your integrations up and running.
    
-   **AI Scripting Assistant 🌟**  
    Our new AI assistant will save you valuable time by helping you find the right code for your business logic.
    

## 26 September 2024

### New features

We have 3️⃣ new features to tell you about!

#### New connector! ⚡

We created a new connector for [Azure DevOps](https://azure.microsoft.com/en-us/products/devops)! 🤩 Fine details can be found on the [Connectors](https://docs.adaptavist.com/src/latest/connectors) page.

#### New connector! ⚡

We created a new connector for [Zendesk](https://www.zendesk.com/)! 🤩 Fine details can be found on the [Connectors](https://docs.adaptavist.com/src/latest/connectors) page.

#### Audit logs are here! 🧾

We’ve introduced audit logs to provide visibility into user actions within ScriptRunner Connect. This new feature allows you to view historical actions for yourself and your teammates, provided you have the appropriate access.

In the app, navigate to _Reporting > Audit Logs_ to review logged activities. Users can see logs relevant to their own actions; admins and super admins can access logs for their respective teams.

-   **Retention**: Logs are stored for six months before being automatically deleted.
-   **Key fields**: Each log includes details like the actor, action performed, IP address, timestamp, related entities, and more.
-   **Export options**: Logs can be exported as CSV files for further analysis, with team-based filters applied.

Read more in the _Reporting_ section on the [Audit Logs](https://docs.adaptavist.com/src/latest/observability/audit-logs) page. 

## 29 August 2024

### Update

We've made a small update to the generic connector. Previously, if you specified an HTTP header in a fetch call that was also defined at the connector level, the connector's header would take precedence, overriding the fetch-level header. With this update, the logic has been reversed: now, the fetch-level header will overwrite the connector-level header. Please note that this change applies only to generic connectors.

See the [Generic Connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector) page for more info.

## 16 August 2024

### New features

We have 1️⃣ cool new feature to tell you about:

#### Console Log 🔍

When you perform an action in a workspace, run a script manually, or trigger a script through a scheduled or external event, the related logs will appear in the console log.

See [Console Log](https://docs.adaptavist.com/src/latest/workspaces/console-log) to learn all about it, including how to filter and refine the log messages to find precisely what you're looking for.

![](/src/files/latest/194675058/281116708/1/1723841990000/full-console.png)

### Update

-   ScriptRunner Connect is now fully [ISO 27001](https://www.iso.org/standard/27001) and [SOC Type 2](https://www.imperva.com/learn/data-security/soc-2-compliance/) certified! 🥳 🥂 
-   We added the [Convert Data Types](https://docs.adaptavist.com/src/latest/scripting/convert-data-types) topic. 

## 27 June 2024

### New features

We have 1️⃣ cool new feature to tell you about:

#### Multi-Factor Authentication (MFA) 🔒

After popular demand, we're happy to announce the addition of Multi-Factor Authentication (MFA) to enhance the security of ScriptRunner Connect! Next time you log in, you will receive a prompt asking whether you want to enable MFA.

Multi-factor authentication (MFA) is a multi-step login process that enhances security by requiring users to provide more information than just a username and password. To log in with MFA enabled, you'll use a one-time password (OTP) generated from an authenticator app. Popular options include Authy, Google Authenticator, Auth0 Guardian, and Microsoft Authenticator, all of which can be downloaded from the Google Play or Apple app stores.

You can manage your MFA preference in your profile settings:

![](/src/files/latest/194675058/266700640/1/1719507354000/MFA-toggle.png)

### Updates

We created a way for you to work more efficiently with large attachments when not using managed APIs. [Read all about it.](https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-attachments#working-with-large-attachments)

## 11 June 2024

### New features

We have 2️⃣ wonderful new features to tell you about:

#### New connector! ⚡

We created a [new connector for NetSuite](https://www.npmjs.com/package/@managed-api/netsuite-v1-sr-connect)! 🤩 The fine details are on the [Connectors](https://docs.adaptavist.com/src/latest/connectors) page.

#### Vendor API versions for Confluence Cloud and monday.com connectors! ⚡

Confluence Cloud and monday.com API connectors now include a **Vendor API Version** field, allowing you to choose which base API version you want to use with ScriptRunner Connect's Managed APIs. If needed, you can use multiple versions in your workspace by creating multiple API connections with different base versions.

![](/src/files/latest/194675058/261981571/1/1718124486000/api-version-select.png)

### Updates

We improved the [Sync ServiceNow Incidents with Jira Cloud Issues](https://app.scriptrunnerconnect.com/template/01GMT114JSESH9PQRYX18X3A8W) template in the following ways:

-   The template now supports attachments.
-   The template now allows you to start the sync from either ServieNow or Jira Cloud (rather than only from Jira Cloud).
-   The template now instructs you to create a custom field to hold the ServiceNow ID rather than storing it in the comments.

Find this and all other templates on our [Templates](https://docs.adaptavist.com/src/latest/templates) page! ✨

## 17 May 2024

### New features

We have 3️⃣ wonderful new features to tell you about:

#### New template for Jira 💪🏾

We created a new template for Jira users, [Keep Jira On-Prem issues in sync with Jira Cloud](https://app.scriptrunnerconnect.com/template/01HNFNQMDF7G1N8Y34D2SDPDDD), which improves data visibility, cross-team collaboration, and work efficiency. 

**Just Cloud? ☁️**

If you want to sync data between multiple Jira Cloud instances, check out the [Keep Jira Cloud issues in sync](https://app.scriptrunnerconnect.com/template/01GYW8F8WHZ8SAFCNVBAQY16D8) template.

#### Environment variables 🌱

We are also excited to announce that [Environment variables are live](https://docs.adaptavist.com/src/latest/workspaces/parameters)!

This new feature lets you securely manage and utilize environment-specific settings and configurations for more modular, secure, and easy-to-maintain code.

#### Notifications for script failures 📨

Finally, you can now receive email notifications when scripts fail. To opt-in, just make the following quick update to your ScriptRunner Connect profile:

![](/src/files/latest/194675058/253365859/1/1715972990000/email-on-script-fail.png)

## 22 March 2024

### Updates

We created a handy new Slack template, [Holidaytron4000](https://app.scriptrunnerconnect.com/template/01HSB7YF3QQRW2J1X821QZX5GA)! 🤖

The template periodically checks BambooHR and then posts your teammates' holiday/PTO summaries to a Slack channel. 

## 2 February 2024

### Updates

-   We improved the [Jira Cloud to Jira Cloud sync template](https://app.scriptrunnerconnect.com/template/01GYW8F8WHZ8SAFCNVBAQY16D8) to cover more use cases. Check it out!

### Bug Fixes

-   Fixed a bug in our runtime where the output string from the [atob](https://developer.mozilla.org/en-US/docs/Web/API/atob) function was erroneously encoded with UTF-8; now it's correctly encoded with [latin1](https://en.wikipedia.org/wiki/ISO/IEC_8859-1).
-   Started releasing version 2.0.0 of Managed APIs, incorporating a _non-backward compatible bug fix_. Specifically, we have started URL encoding all URL paths and query string parameters.  
    
    **Remove manual encoding 🔪**
    
    If you fixed this issue by encoding the parameters manually, then with the new version, you must remove your explicit encoding; otherwise, the parameters will be double-encoded.
    
    A new _Package Updates Available_ modal now greets you when outdated packages are detected in your workspace. You don't necessarily have to apply updates immediately, but when you do, click **View Changelog** to review each package you plan to update.
    
      
    
    ![](/src/files/latest/194675058/227347403/36/1706894229000/package-updates-available.png)  
      
    Changelog example:  
      
    ![](/src/files/latest/194675058/227347402/36/1706894344000/package-update-change-log.png)

## 30 January 2024

### New Feature

Now you can [replay script invocations](https://docs.adaptavist.com/src/latest/observability/script-invocation-logs/replay-script-invocations)!

![](/src/files/latest/194675058/227149261/1/1706636377000/replay-invocation-button2.png)

### Update

New topic: [Sign JWT Token with a Private Key](https://docs.adaptavist.com/src/latest/scripting/code-snippets/sign-jwt-token-with-a-private-key)

## 12 January 2024

### New Feature

ScriptRunner Connect now supports [mutual TLS](https://www.cloudflare.com/en-gb/learning/access-management/what-is-mutual-tls/) with [Fetch API](https://docs.adaptavist.com/src/latest/scripting/fetch-api). Take a look at [our example](https://docs.adaptavist.com/src/latest/scripting/code-snippets/perform-mutual-tls).

## 22 December 2023

### Updates

-   We overhauled our environments and deployments feature to simplify it but still retain the flexibility offered with the previous version. New [docs](https://docs.adaptavist.com/src/latest/workspaces/deployments-and-environments) have been published on how the new version works. For those who previously had a version deployed to their only environment, you will find that you can no longer make changes in that environment since now changes can only be made in an environment targeting a `HEAD` version. To overcome this situation, you can either create a new environment and keep it targeting the `HEAD` version and apply changes there and eventually promote those changes to your current environment, or re-target your current environment to target the `HEAD` version, which you can do if you click on the ellipsis icon and select `Deployment Manager`.
-   Avatar colors are now randomized.

## 29 November 2023

### New Feature

We created a [new template for Zendesk](https://app.scriptrunnerconnect.com/template/01HG8FA1N66Q0EJZM4AANB4P04)! 

The template helps implement OAuth 2.0 for the app using our [generic connector](https://docs.adaptavist.com/src/latest/connectors#id-.ConnectorsvCurrent-genericconnector).

## 27 November 2023

### New Feature

You now have the ability to duplicate a workspace!  💾⚡💾

Gone are the days when you had to labor to duplicate a workspace by manually adding each script, API connection, and/or event listener from scratch. Total headache!

Now you can simply click the **Options** menu (ellipsis) on a workspace card, then select **Duplicate**.

![](/src/files/latest/194675058/209685982/1/1701117314000/duplicate-workspace.png)

Before the new workspace is created, you can change the title and description and even attribute the new workspace to a different team. Nice!

### Bug Fixes

-   Fixed a bug that caused the user-specified `Content-Type` header value to be overwritten when using the generic connector.
-   Fixed a bug that caused selected items in the Workspace resource tree not to be highlighted.
-   Fixed vendor API URL links for the Jira Cloud Managed API.

## 9 November 2023

### Updates

-   Added a check to prevent the creation of a generic connector without a protocol being specified with the base URL.
-   Converted Trello templates to make use of Managed APIs for Trello-specific API calls.

### Bug Fixes

-   Fixed a bug related to estimated dates for scheduled triggers that caused some estimated dates to be from the past.

## 3 November 2023

### New Feature

We created a [new template for Excel](https://app.scriptrunnerconnect.com/template/01HE30HQR4BXER40X6C2DXYM3T)! 

The template demonstrates how to construct an Excel file in memory using a [third-party NPM package](https://www.npmjs.com/package/write-excel-file) (thanks to our [package manager](https://docs.adaptavist.com/src/latest/workspaces/package-manager) feature) and then upload the file to Jira Cloud as an issue attachment.

## 21 September 2023

### Product launch! 

We are excited to announce the official launch of **ScriptRunner Connect**, the app formerly known as Stitch It!  🥳

We have evolved throughout a tremendously successful beta period and are now a part of the ScriptRunner suite of products as ScriptRunner Connect.

Unfamiliar with Stitch It?  👀 [Learn about ScriptRunner Connect!](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect)  👀

Here's what's changing for our beloved Stitch It users:

-   A new [app URL](https://app.scriptrunnerconnect.com/)
-   A new [marketing website](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect)
-   A new app logo
-   The app is now out of the beta stage and ready for serious business use
-   Existing teams have been implemented under the Free plan

As we finalize the checkout process, you can continue to use ScriptRunner Connect for free until the pricing plans become available on 12 October 2023. At that point, choose the sweet spot for your team and dig in!

**Talk to us!  💬**

We have a [ScriptRunner Connect Nolt board](https://scriptrunnerconnect.nolt.io/top) so you can share ideas and steer future app development!

**Old bones  🦴**

Remnants of the Stitch It name remain in a few of the YouTube demo videos that are available in the app and customer documentation, but they will be replaced very soon. We appreciate your patience.
