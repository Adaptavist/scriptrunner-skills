# Rewrite Scripts for Cloud Guide

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration
- Doc ID: doc-sr4cc-419662196
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide

Migration from ScriptRunner for Confluence Server/Data Center to ScriptRunner for Confluence Cloud (either manually or through the [Atlassian Cloud Migration Assistant](https://marketplace.atlassian.com/apps/1219672/confluence-cloud-migration-assistant?hosting=datacenter&tab=overview)) **will require your scripts to be rewritten**. This is because the APIs and programming models differ significantly between Confluence Server/Data Center and Confluence Cloud.

Confluence Server/Data Center relies on certain APIs and functionalities that are specific to on-premises environments, while Confluence Cloud operates with a different set of APIs designed for cloud-based infrastructure. For example, certain API endpoints or methods available in Confluence Server/Data Center might not exist in Confluence Cloud, or they might function differently. Additionally, Confluence Cloud offers new capabilities and constraints that require adjustments in how scripts are structured and executed. As a result, each migration is unique and requires careful assessment and adaptation of existing scripts to ensure they work seamlessly in the cloud environment.

## Before you start

### Platform differences between Server/Data Center and Cloud

Confluence Cloud uses the [Atlassian Connect](https://developer.atlassian.com/cloud/confluence/getting-started-with-connect/) framework, while Confluence Server/Data Center relies on the [Atlassian Plugins](https://developer.atlassian.com/server/confluence/confluence-plugin-guide/) framework, also known as Plugins v2 (or P2). We have documented the notable differences between these two frameworks on our [Differences between ScriptRunner for Confluence Server/DC and Cloud](https://docs.adaptavist.com/sr4cc/latest/migration/platform-differences) page. It's important to understand these differences before you start rewriting your scripts.

The P2 framework in Confluence Server/Data Center allows deep integration with the host application, providing direct access to the Java API. In contrast, Confluence Cloud uses the Atlassian Connect framework, which operates on a more decoupled model.  In this environment, apps like ScriptRunner must rely on Confluence's public REST APIs to perform operations.

This architectural difference means that in Confluence Cloud, tasks such as retrieving, updating, or creating pages, managing spaces, and performing other administrative functions are executed through API calls. As a result, script execution in Cloud is asynchronous. Therefore, when a script runs in Confluence Cloud, users might experience page loading before the script has fully executed.

Understanding this shift in how operations are performed is crucial when adapting scripts from Confluence Server/Data Center to Confluence Cloud. Scripts will need to be rewritten to effectively use the available REST APIs and account for the asynchronous nature of Cloud operations.

### ScriptRunner differences between Server/Data Center and Cloud

ScriptRunner for Confluence Cloud differs from ScriptRunner for Confluence Server/Data Center due to differences in the platform. You can review the main differences on the [Feature Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity) page. Some features available in ScriptRunner for Confluence Server/Data Center are not available in ScriptRunner for Confluence Cloud. We recommend that you review this page before starting to rewrite your scripts to see which features have full or partial parity. You can also use this page to explore the features and capabilities of ScriptRunner for Confluence Cloud, such as built-in scripts, listeners, and macros.

### Simplify your scripts with HAPI 

HAPI is an API you can use to write scripts in a simpler way in ScriptRunner. ScriptRunner Server/Data Center scripts that are simplified using HAPI will be easier to migrate when moving from Confluence DC to Confluence Cloud. Check out our [ScriptRunner for Confluence Cloud HAPI documentation](https://docs.adaptavist.com/sr4cc/latest/hapi) for more details on HAPI.

HAPI in ScriptRunner for Confluence Cloud differs from Data Center as not all methods are available in Cloud. Scripts that use HAPI methods will likely require significantly fewer changes when migrating to ScriptRunner for Confluence Cloud.

* * *

![](/files/419661878/426117647/1/1756887170000/sr-icon-light-bulb+%281%29.png)

Don’t have the time or capacity to write scripts in-house? Get your Server scripts translated to Cloud without writing a single line of code yourself. Check out our Scripting Service.

[shortcut Scripting Service](https://www.adaptavist.com/solutions/development-services)

* * *

### Migration tools

During the migration process from Confluence Server/Data Center to Confluence Cloud, using the right tools can help streamline the transition, especially when dealing with API calls and script testing. Below are some essential tools that you can use. 

Tool type

Tool

Summary

**API testing tools**

[Postman](https://www.postman.com/)

-   Popular API development and testing tool that allows you to create, test, and document API requests with ease. 
-   Provides an intuitive interface for crafting HTTP requests, handling authentication, and analyzing responses. 
-   Useful for testing REST API calls that you will need to adapt for Confluence Cloud.
-   Features, such as collections and environment variables, help organize and streamline your testing process.

[cURL](https://curl.se/)

-   Command-line tool for transferring data with URLs.
-   Versatile tool that can be used to test API endpoints directly from the terminal.
-   Ideal for scripting and automation, allowing you to quickly test API calls and see the raw request and response data. 
-   Especially useful for developers who prefer working in a command-line environment.

**Version control systems (optional)**

[Git](https://git-scm.com/)

-   Crucial for managing changes to your scripts during migration.
-   Allows you to track modifications, collaborate with team members, and revert to previous versions if needed.
-   Enables branching and merging, which can be helpful when working on different aspects of the migration simultaneously.

**Integrated development environments (IDEs) (optional)**

[IntelliJ IDEA](https://www.jetbrains.com/idea/)

-   Provides a robust environment for writing and testing your scripts.
-   Offers features such as code completion, syntax highlighting, and debugging tools that can enhance productivity and reduce errors during the migration process.

[Visual Studio Code](https://code.visualstudio.com/)

-   Lightweight and highly customizable code editor that supports a wide range of programming languages and extensions.
-   Well-suited for writing and testing JavaScript-based scripts that may be part of your Confluence Cloud migration.

## Next steps

-   [Prepare to Migrate Scripts](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/prepare-to-migrate-scripts)
-   [Adapt Scripts for Confluence Cloud](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/adapt-scripts-for-confluence-cloud)
-   [Migration Best Practices and Supporting Technical Information](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/migration-best-practices-and-supporting-technical-information)
