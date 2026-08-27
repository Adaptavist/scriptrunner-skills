# Platform Differences

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration
- Doc ID: doc-sr4cc-114205208
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/platform-differences

Due to the differences in the programming model and APIs, no automatic migration between Server and Cloud exists. The process of migration involves analyzing the desired functionality and translating that into the target platform. Confluence Cloud uses the [Atlassian Connect](https://developer.atlassian.com/cloud/confluence/about-confluence-cloud/) framework to allow apps like ScriptRunner to provide additional functionality whereas Confluence Server (and Data Center) uses the [Atlassian Plugins](https://developer.atlassian.com/docs/) framework, known as Plugins v2 or P2.

There are fundamental differences between Connect and P2 that directly impact ScriptRunner functionality and script writing. Some of the differences are:

  

  

P2

Connect

API

Java API.

It is possible to call almost any of the Host application code directly. Plugins are running in the same JVM as the host application.

[REST APIs](https://developer.atlassian.com/cloud/confluence/rest/) are available to interact with the host application.

Connect has access to a limited set of REST APIs. This means that connect add-ons can only do things officially supported by the APIs, but it also means that APIs are less likely to change and add-ons are less likely to break as a result.

UI

Any part of the UI can be customized.

Javascript runs as on the page in the same context and frame as the host application. Host application code can be manipulated and broken by add-ons and add-on code can easily be broken by host code (or its dependent libraries) updates.

Specific areas can be cusomised.

Each add-on runs in its own iframe and JavaScript Sandbox. Interaction with the host page is via a [JavaScript API](https://developer.atlassian.com/cloud/jira/platform/about-the-javascript-api/).

Programming Model

In the same JVM as the host application.

Events can be vetoed and code runs synchronously. A bug in add-on code can seriously affect application stability or performance.

Asynchronous. Runs as a completely separate service.

No code runs in the same JVM as the host. Events are processed as [webhooks](https://developer.atlassian.com/cloud/confluence/modules/webhook/) that fired from the host and processed asynchronously by the add-on, so there's no waiting for events to be processed. A failing add-on does not impact the performance of an Atlassian application (although functionality may be missing).

Authentication and Authorization

Code can run as any user in the system including as no user (which is not the same as anonymous).

Authentication and authorisation can be bypassed.

Add-ons make requests as the add-on user or the user that initiated the interaction.

It is not possible to bypass authorisation or authentication

There are significant differences between the Connect and P2 frameworks, and it is necessary to re-think how ScriptRunner scripts execute and interact with the host application when moving from Server to Cloud or Cloud to Server.

The asynchronous nature of Connect has implications with regards to host interaction. For example, in Confluence it is not possible to implement scripted event listeners that prevent event processing. Similarly when writing ScriptRunner scripts for Server hosts, it is important to consider the impact that scripts will have, particularly when interacting with external systems that might be slow.

As with most programming situations there are trade offs when writing scripts for both Cloud and Server, and the limitations of Cloud are at the expense of stability and performance of the Atlassian application.
