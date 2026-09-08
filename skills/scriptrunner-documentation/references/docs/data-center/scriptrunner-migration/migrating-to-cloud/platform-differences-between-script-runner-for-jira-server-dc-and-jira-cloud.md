# Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud

- Platform: data-center
- Space: SR4JS
- Hierarchy: scriptrunner-migration > migrating-to-cloud
- Doc ID: doc-sr4js-101624734
- Source: https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud

Feature Differences

ScriptRunner for Jira Cloud **does not have the same feature set** as the Server/Data Center version. You can learn about the parity for each individual ScriptRunner for Server/Data Center feature in our [Feature Parity page](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives). We also provide details on workaround script/function alternatives where there is currently no parity with Cloud.

REST APIs

Scripts in Jira Cloud do not execute within the same process as Jira Server and so must interact with Jira using the [REST APIs](https://docs.adaptavist.com/sr4jc/latest/get-started/technical-background) rather than the JAVA APIs.

Automatic migration between Server/Data Center and Cloud does not exist due to differences in the programming model and API. Jira Cloud uses the [Atlassian Connect](https://developer.atlassian.com/cloud/jira/platform/getting-started-with-connect/) framework to allow add-ons like ScriptRunner to provide additional functionality, whereas Jira Server/Data Center use the [Atlassian Plugins](https://developer.atlassian.com/server/jira/platform/getting-started/) framework, known as Plugins2, or P2. There are fundamental differences between Connect and P2 that directly impact ScriptRunner functionality and script writing, the main ones are outlined in the table below:

  

Server/Data Center (P2)

Cloud (Connect)

Hosting Environment

Apps run within the Jira Server/Data Center environment, sharing the same JVM and having direct access to the Java API.

Apps are hosted externally, typically on a separate server, and communicate with Jira Cloud via REST APIs and webhooks.

Access to APIs

Provides direct access to Jira's internal APIs, allowing for deeper integration and manipulation of Jira's core functionalities.

Relies on public [REST APIs](https://developer.atlassian.com/cloud/jira/platform/rest/), which may offer a more limited set of functionalities compared to direct Java API access. Connect has access to a limited set of REST APIs as defined by the [Product API Scopes](https://developer.atlassian.com/cloud/jira/platform/scopes/), this means that Connect add-ons can only do things officially supported by the APIs, but it also means that APIs are less likely to change and add-ons are less likely to break as a result.

UI

Any part of the UI can be customized. Javascript runs as on the page in the same context and frame as the host application. Host application code can be manipulated and broken by add-ons and add-on code can easily be broken by host code (or its dependent libraries) updates.

Specific areas can be customized. Each add-on runs in its own iframe and Javascript Sandbox. Interaction with the host page is via a [Javascript API](https://developer.atlassian.com/cloud/jira/platform/about-the-javascript-api/).

Security model

Operates within Jira's security context, following server-based authentication and authorization mechanisms.

Utilizes OAuth 2.0 for authentication, requiring apps to securely manage tokens and permissions for API access.

Authentication and authorization

Code can run as any user in the system including as no user (which is not the same as Anonymous). Authentication and authorization can be bypassed.

Add-ons make requests as the add-on user or the user that initiated the interaction. It is not possible to bypass authorization or authentication

Programming model

In the same JVM as the host application. Events can be vetoed and code runs synchronously. A bug in add-on code can seriously affect application stability or performance.

Asynchronous. Runs as a completely separate service. No code runs in the same JVM as the host. Events are processed as [webhooks](https://developer.atlassian.com/cloud/jira/platform/webhooks/) that are fired from the host and processed asynchronously by the add-on. There is no waiting for events to be processed. A failing add-on does not impact the performance of an Atlassian application (although functionality may be missing).

Extension points

Offers a wide range of extension points within Jira, enabling customizations at various levels, including UI and backend processes.

Provides predefined extension points, such as web panels and dialogs, with a focus on UI integration and remote data handling.

Development and deployment

Requires familiarity with Java and the Atlassian SDK for development, with deployment involving installation on the Jira server.

Typically involves web development technologies (for example Node.js, Python) and deployment on external hosting platforms, with integration via app descriptors.

Scalability and maintenance

Apps are subject to the same resource constraints as the Jira server and require maintenance within that environment.

Allows for independent scaling and maintenance of apps, as they run on separate infrastructure.

There are significant differences between the Connect and P2 frameworks and it is necessary to re-think how ScriptRunner scripts execute and interact with the host application when moving from Server/Data Center to Cloud. The reliance on REST APIs in Jira Cloud may present some limitations compared to the Server/Data Center environment, as the available APIs may not cover all functionalities or provide the same level of access. However, it also offers benefits such as improved scalability, security, and the ability to integrate with other cloud services.

The asynchronous nature of Connect has implications with regards to host interaction, for example, Jira Cloud can't implement event listeners that prevent event processing. Similarly, for Server/Data Center scripts, it's crucial to consider performance impacts, especially when interacting with slow external systems.

Both Cloud and Server/Data Center environments present unique trade-offs in script writing, balancing functionality with stability and performance considerations.

  

* * *

## Related content

-   [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives)
-   [JQL Query Comparison](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison)
-   [Rewrite Scripts for Cloud Hints and Tips](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips)
