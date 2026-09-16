# Rewrite Scripts for Cloud Hints and Tips

- Platform: cloud
- Space: SR4JC
- Hierarchy: ScriptRunner Migration to Cloud
- Doc ID: doc-sr4jc-3be56785-0e7f-462b-bc68-871710660b66-0e2971ef89609e42
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips

Migration from Scriptrunner for Jira Server/Data Center to ScriptRunner for Jira Cloud (either manually or through the [Atlassian Cloud Migration Assistant](https://marketplace.atlassian.com/apps/1222010/jira-cloud-migration-assistant?hosting=datacenter&tab=overview&_gl=1*1pj60n7*_gcl_au*MTg1NDMyMjg5OC4xNzQyMjI2ODg5LjE0NTY0MDIyNjUuMTc0NjIwMTA1MC4xNzQ2MjAxMTEw*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NDY3MTE5NjIkbzg0NSRnMSR0MTc0NjcxMjAxNSRqNyRsMCRoMjMxOTE0OTM2)) will require your scripts to be rewritten. This is because the APIs and programming models differ significantly between Jira Server/Data Center and Jira Cloud.

Jira Server/Data Center relies on certain APIs and functionalities that are specific to on-premises environments, while Jira Cloud operates with a different set of APIs designed for cloud-based infrastructure. For example, certain API endpoints or methods available in Jira Server/Data Center might not exist in Jira Cloud, or they might function differently. Additionally, Jira Cloud offers new capabilities and constraints that require adjustments in how scripts are structured and executed. As a result, each migration is unique and requires careful assessment and adaptation of existing scripts to ensure they work seamlessly in the cloud environment.

## Before you start

### Platform differences between Server/Data Center and Cloud

Jira Cloud utilizes the [Atlassian Connect](https://developer.atlassian.com/cloud/jira/platform/getting-started-with-connect/) framework, while Jira Server/Data Center relies on the [Atlassian Plugins](https://developer.atlassian.com/server/jira/platform/java-apis/) framework, also known as Plugins v2 (or P2). We have documented the notable differences between these two frameworks on our [Differences between ScriptRunner for Jira Server/DC and Cloud](platform-differences-between-script-runner-for-jira-server-dc-and-jira-cloud.md) page. It's important to understand these differences before you start rewriting your scripts.

The P2 framework in Jira Server/Data Center allows deep integration with the host application, providing direct access to the Java API and execution within Jira's Java Virtual Machine (JVM). In contrast, Jira Cloud uses the Atlassian Connect framework, which operates on a more decoupled model. Here, apps like ScriptRunner must rely on Jira's public REST APIs for operations.

This architectural difference means that in Jira Cloud, tasks such as retrieving, updating, or creating issues, managing projects, and other administrative functions are executed through API calls. As a result, script execution in Cloud is asynchronous. Therefore, when a script runs in Jira Cloud, users might experience page loading before the script has fully executed.

Understanding this shift in how operations are performed is crucial when adapting scripts from Jira Server/Data Center to Jira Cloud. Scripts will need to be rewritten to effectively utilize the available REST APIs and account for the asynchronous nature of Cloud operations.

Tip: Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools:

-   [ScriptRunner Migration Analyse and Assess Tool](../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-analyse-and-assess-tool.md): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-agent.md): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](../../migration-suite/uncategorized/s/script-runner-dev-and-deployment-tool.md): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069).

### Field availability

All standard ScriptRunner for Jira field types are available in Cloud. However it is important to note that Project Picker fields are only available as single-select fields. Cloud custom fields and advanced field types are listed in [Atlassian's documentation](https://support.atlassian.com/jira-cloud-administration/docs/custom-fields-types-in-company-managed-projects/).

### ScriptRunner differences between Server/Data Center and Cloud

ScriptRunner for Jira Cloud differs from ScriptRunner for Jira Server/Data Center due to differences in the platform. You can review the main differences on the [Feature Parity and Script Alternatives](feature-parity-and-script-alternatives.md) page. Some features available in ScriptRunner for Jira Server/Data Center are not available in ScriptRunner for Jira Cloud. We recommend that you review this page before starting to rewrite your scripts to see which features have full or partial parity. You can also use this page to explore the features and capabilities of ScriptRunner for Jira Cloud, such as built-in scripts, listeners, and the Script Console.

### Simplify your scripts with HAPI

HAPI is an API you can use to write scripts in a simpler way in ScriptRunner. ScriptRunner Server/Data Center scripts that are [simplified using HAPI](https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi) will be easier to migrate when moving from Jira DC to Jira Cloud. Check out our [ScriptRunner for Jira Cloud HAPI documentation](../uncategorized/h/hapi.md) for more details on HAPI.

HAPI in ScriptRunner for Jira Cloud differs from Data Center as not all methods are available in Cloud (see the [Feature Parity and Script Alternatives](feature-parity-and-script-alternatives.md) page for more details). Scripts that use HAPI methods will likely require significantly fewer changes when migrating to ScriptRunner for Jira Cloud.

|  |  |
| --- | --- |
|  | Don't have the time or capacity to write scripts in-house? Get your Server scripts translated to Cloud without writing a single line of code yourself. Check out our [Scripting Service](https://www.adaptavist.com/solutions/development-services). |

### Migration tools

During the migration process from Jira Server/Data Center to Jira Cloud, using the right tools can help streamline the transition, especially when dealing with API calls and script testing. Below are some essential tools that you can use.

<table class="table" id="migration-tools--en__generated-table-id-1"><caption></caption><colgroup><col><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="migration-tools--en__generated-table-id-1__entry__1">Tool type</th><th class="entry" id="migration-tools--en__generated-table-id-1__entry__2">Tool</th><th class="entry" id="migration-tools--en__generated-table-id-1__entry__3">Summary</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 " rowspan="2"> <span class="ph b">API testing tools</span>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "> <a class="xref j-external-link" href="https://www.postman.com/" target="_blank">Postman</a>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 ">&#10;<ul class="ul"><li class="li">Popular API development and testing tool that allows you to create, test, and document API requests with ease.</li><li class="li">Provides an intuitive interface for crafting HTTP requests, handling authentication, and analyzing responses.</li><li class="li">Useful for testing REST API calls that you will need to adapt for Jira Cloud.</li><li class="li">Features, such as collections and environment variables, help organize and streamline your testing process.</li></ul>&#10;</td></tr><tr class="row"><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "> <a class="xref j-external-link" href="https://curl.se/" target="_blank">cURL</a>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 ">&#10;<ul class="ul"><li class="li">Command-line tool for transferring data with URLs.</li><li class="li">Versatile tool that can be used to test API endpoints directly from the terminal.</li><li class="li">Ideal for scripting and automation, allowing you to quickly test API calls and see the raw request and response data.</li><li class="li">Especially useful for developers who prefer working in a command-line environment.</li></ul>&#10;</td></tr><tr class="row"><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "> <span class="ph b">Version control systems (optional)</span>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "> <a class="xref j-external-link" href="https://git-scm.com/" target="_blank">Git</a>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 ">&#10;<ul class="ul"><li class="li">Crucial for managing changes to your scripts during migration.</li><li class="li">Allows you to track modifications, collaborate with team members, and revert to previous versions if needed.</li><li class="li">Enables branching and merging, which can be helpful when working on different aspects of the migration simultaneously.</li></ul>&#10;</td></tr><tr class="row"><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 " rowspan="2"> <span class="ph b">Integrated development environments (IDEs) (optional)</span>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "> <a class="xref j-external-link" href="https://www.jetbrains.com/idea/" target="_blank">IntelliJ IDEA</a>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 ">&#10;<ul class="ul"><li class="li">Provides a robust environment for writing and testing your scripts.</li><li class="li">Offers features such as code completion, syntax highlighting, and debugging tools that can enhance productivity and reduce errors during the migration process.</li></ul>&#10;</td></tr><tr class="row"><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 "><a class="xref j-external-link" href="https://code.visualstudio.com/" target="_blank">Visual Studio Code</a>&#10;</td><td class="entry" headers="migration-tools--en__generated-table-id-1__entry__1 migration-tools--en__generated-table-id-1__entry__2 migration-tools--en__generated-table-id-1__entry__3 ">&#10;<ul class="ul"><li class="li">Lightweight and highly customizable code editor that supports a wide range of programming languages and extensions.</li><li class="li">Well-suited for writing and testing JavaScript-based scripts that may be part of your Jira Cloud migration.</li></ul>&#10;</td></tr></tbody></table>

## Preparation steps

### Create a test environment

A test environment is crucial in the migration process from Jira Server/Data Center to Jira Cloud. It allows you to experiment, test, and refine your scripts in a controlled setting before deploying them to your production environment. Below we provide details on how to set-up and utilize a test environment.

#### Set up a Jira Cloud test instance

1.  [Create a Jira Cloud account](https://www.atlassian.com/try/cloud/signup?product=confluence.ondemand,jira-software.ondemand,jira-servicedesk.ondemand,jira-core.ondemand&developer=true) if you do not already have one.
    
    Tip: Atlassian offers free trials for Jira Cloud, allowing you to set up a test environment without incurring initial costs.
    
2.  Create a test project that mirrors your production environment as closely as possible. This includes setting up:
    -   Workflows
    -   Issue types
    -   Configurations where they are needed

#### Install ScriptRunner for Jira Cloud

Install ScriptRunner for Jira Cloud as described on our [Installation](../get-started/installation.md) page.

Tip: We recommend you install the trial version of ScriptRunner for Jira Cloud. This allows you to explore its features and test your scripts without immediate financial commitment.

#### Utilize the ScriptRunner Script Console

ScriptRunner for Jira Cloud includes a [Script Console](../features/script-console.md), similar to the one available in ScriptRunner for Jira Server/Data Center. This feature allows you to write and test scripts in real-time and can be accessed from the ScriptRunner section within your Jira Cloud instance.

We recommend you utilize the script console to do the following:

Warning: Behaviours cannot be tested in the Script Console within the cloud environment. This is because Behaviour scripts are written in JavaScript, while the Script Console exclusively uses Groovy as its scripting language.

-   Write and test scripts: Write new scripts or adapt existing ones from your server environment. The console provides immediate feedback, allowing you to test script functionality and debug issues quickly.
-   Experiment and iterate: The script console is ideal for experimentation. Try different approaches, test API calls, and iterate on your scripts until they perform as expected in the cloud environment. This iterative process helps ensure that your scripts are robust and reliable.

### Analyze existing code in Server/Data Center

Before you start your migration of ScriptRunner code from Jira Server/Data Center (DC) to Jira Cloud, we recommend you conduct a thorough analysis of your existing codebase. This will help you streamline the migration process and ensure a smoother transition. Below we list the steps you should follow to analyze your existing code and prepare your scripts for migration.

1.  Understand your Server/Data Center scripts.
    1.  Identify the purpose and functionality:
        
        Begin by clearly defining the purpose and functionality of each script in Server/Data Center. Determine what tasks the script automates, such as workflow transitions, data validation, or external system integration. This understanding will serve as a blueprint for replicating the script's functionality in ScriptRunner for Jira Cloud.
        
    2.  Review project associations:
        
        Determine which projects each script is associated with. This will help you understand the context and scope of the script, ensuring that any project-specific configurations or dependencies are considered during the migration.
        
2.  Identify duplicated and similar scripts.
    
    Review your existing scripts to identify any duplicates or scripts with similar functionality. Consolidating these scripts can reduce redundancy and simplify the migration process.
    
    Tip: You can use the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) in ScriptRunner for Jira Server/Data Center to search your ScriptRunner custom scripts and export all scripts and configurations on your instance.
    
    Consider merging similar scripts into a single, more efficient script where possible. As described above, you should also consider [simplifying your scripts with HAPI](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips#simplify-your-scripts-with-hapi--en). This can help minimize the amount of code that needs to be rewritten for the cloud environment.
    
3.  Assess unused or disabled scripts.
    
    Check for scripts that are currently disabled or no longer in use. Removing these scripts before migration can help reduce clutter and focus efforts on only the necessary code.
    
4.  Evaluate external application integrations.
    
    Review any integrations with external applications or services. Determine how these integrations are currently implemented and whether they will need to be adjusted to work with Jira Cloud's architecture.
    
    Explore Jira Cloud's available integration options, such as webhooks or OAuth, to maintain or enhance these connections.
    
5.  Assess plugin dependencies.
    
    Identify any dependencies on other plugins or add-ons within your scripts. Since not all server plugins have cloud equivalents, you'll need to find alternative solutions or workarounds for these dependencies.
    
    Research whether the functionality provided by these plugins is available in Jira Cloud. By conducting a comprehensive analysis of your existing ScriptRunner code, you'll be better prepared to address the challenges of migration and ensure that your scripts function effectively in the Jira Cloud environment.
    
6.  Categorize ScriptRunner script types.
    
    Before diving into writing or adapting scripts, it's beneficial to categorize them by type and understand the specific limitations of each type in Cloud. The [Feature Parity and Script Alternatives](feature-parity-and-script-alternatives.md) page details the parity of each ScriptRunner for Server/Data Center feature. Below is each category you should consider, along with details about certain feature limitations:
    
    <table class="table" id="analyze-existing-code-in-server-data-center--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1">Type</th><th class="entry" id="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2">Notes</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#behaviours--en">Behaviours</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 ">&#10;<p class="p">Behaviours are currently limited in Jira Cloud due to restrictions set by Atlassian. The main Behaviours limitations are as follows:</p>&#10;<ul class="ul"><li class="li">Modifying field properties (read-only, hidden, and/or required, description, helpText, manage Options) is limited for some field types and system fields.</li><li class="li">Behaviours in JSM projects (portal) are not supported.</li><li class="li">Behaviours for Assets are not supported.</li></ul>&#10;<p class="p">Check out our <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products">Behaviours Supported Fields and Products</a> page and <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations">Behaviours Limitations</a> page for more details. </p>&#10;</td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#built-in-scripts--en">Built-In Scripts</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "></td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#jobs--en">Scheduled Jobs</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 ">Includes Escalation Services.</td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#listeners--en">Script Listeners</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "></td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#ui-fragments--en">UI Fragments</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "></td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#script-fields--en">Scripted Fields</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "></td></tr><tr class="row"><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 "> <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#workflow-conditions--en">Workflow Extensions</a>&#10;</td><td class="entry" headers="analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__1 analyze-existing-code-in-server-data-center--en__generated-table-id-1__entry__2 ">There are a number of differences for workflow extensions between DC/Server and Cloud. Most importantly, Validators and Conditions can only utilize <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/jira-expressions/" target="_blank">Jira expressions</a>, not the <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details">REST API</a>. This may limit some possibilities when recreating configurations on Cloud. Additional Cloud limitations are detailed on our <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/troubleshoot-workflow-rules#perform-actions-workflow-rules-limitations--en">Perform actions limtations</a> documentation. </td></tr></tbody></table>
    
7.  Plan a migration path for each script.
    
    For effective migration, evaluate each script individually and assign it to one of the following categories:
    
    -   The script can be migrated: There is complete parity and the script will work in ScriptRunner for Jira Cloud.
    -   The script cannot be migrated but a workaround exists: There is partial parity and you can perform the same function using an alternative solution.
    -   The script cannot be migrated and there's no workaround: The process or way of working should be changed.
    

## Review and adapt scripts for Jira Cloud

Before you start migrating your scripts, it's crucial to understand how scripts work in Jira Cloud and the key differences from Server/Data Center. The following steps will guide you through understanding how scripts work in Jira Cloud, enabling you to effectively rewrite your scripts.

### Step one: Review imports and dependencies

Examine your scripts for any imported external libraries. These libraries can introduce additional complexity when migrating to Jira Cloud. In addition you should identify plugins, for example Tempo, that the scripts rely on.

Determine if these libraries/plugins are supported or available in the cloud environment. If they are not available you should identify alternative approaches or built-in functionalities in Jira Cloud that can replace them.

### Step two: Analyze API calls

Identify any API calls within your scripts, especially those that interact with Jira's internal APIs. Since Jira Cloud relies on REST APIs, you'll need to adapt these calls to use the appropriate cloud-based endpoints. Use the following tips to effectively analyze API calls:

1.  List existing API calls:
    
    -   Compile a list of API calls in your Server/Data Center scripts.
    -   Include calls to Jira's internal APIs and any external applications.
    -   Verify the purpose of each API call by checking the [Atlassian Jira REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#about) documentation or using [Migration Tools](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips#migration-tools--en) mentioned above.
    
2.  Understand API endpoints:
    
    -   Familiarize yourself with the Atlassian [Jira REST API in Cloud](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#version).
    -   Determine which API endpoints are required to replicate the functionality of your existing scripts. This may include endpoints for creating, updating, or retrieving issues, managing projects, handling user data, and more.
    -   Pay attention to the request types (GET, POST, PUT, DELETE), path parameters, query parameters and request body.
    
3.  Consider permissions:
    
    -   Ensure that the API calls respect Jira's permission schemes. The user making the API request must have the necessary permissions to perform the action, such as creating issues or editing project settings.
    
4.  Implement proper authorization:
    
    -   Jira Cloud APIs typically use OAuth 2.0 for authorization. You'll need to manage tokens and ensure that your requests include the appropriate authorization headers.
    

For more details on APIs see the [Commonly used Atlassian Java API endpoints and their Cloud equivalents](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips#commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en) section below.

### Step three: Understand and apply basic operations

It's important to understand the basic operations in Jira Cloud's API before you migrate your scripts. This understanding will form the foundation for successfully adapting your existing scripts and ensuring they function correctly in the new environment. In this section, we explore field updates and issue updates.

#### Work with field updates

The following points outline key considerations for understanding and implementing field updates in Jira Cloud:

-   Understand field types: Most fields in Jira Cloud can be updated using the string representation of their values. This eliminates the need to locate option IDs which is often required in ScriptRunner for Server/Data Center scripts. However, some field types (for example text, number, date, select lists, user pickers) may have different representations and constraints in Jira Cloud. For each field type, determine the correct JSON format for updates. The representation may vary based on the field type (for example, date fields may require specific formatting). Understanding these differences is crucial for correctly formatting API requests.
-   Check field availability: Use the Jira Cloud REST API to verify that each field you need is available. You can retrieve a list of fields using the /rest/api/3/field endpoint, which provides metadata about all fields in your Jira Cloud instance.
    
    Tip: Pay special attention to custom fields, as their IDs and configurations might differ between Server/Data Center and Cloud.
    
-   Supported operations: Ensure that the fields you need to update can be managed through the Jira Cloud REST API. Not all fields may be editable or support the same operations as in the server version.
-   Field IDs: Note that in Jira Cloud, fields are often referenced by their unique IDs rather than names. Ensure you have the correct field IDs for use in API requests.
-   Test updates: Experiment with updating fields using the `/rest/api/3/issue/{issueIdOrKey}` endpoint, providing a JSON payload that specifies the fields and values to update.

#### Work with issue updates

Updating issues in Jira Cloud using the REST API requires a clear understanding of the JSON payload format, as this dictates how data is structured and transmitted to the server. Below is a detailed guide on how to approach this task.

Tip: Practical steps for handling JSON payloads

We recommend you review the following steps to effectively handle JSON payloads and ensure successful interactions with the Atlassian Jira Cloud REST API:

1.  Review API documentation: Regularly consult the Atlassian Jira Cloud REST API documentation for examples and guidelines on JSON payload structures for different field types.
2.  Use the ScriptRunner console: If using ScriptRunner, leverage the Script Console to test small scripts that perform GET requests to fetch issue data. This helps you understand how fields are structured in JSON format.
3.  Experiment with test data: Use a test Jira Cloud instance and create sample issues with various field types. Use the API to retrieve these issues and examine the JSON format of the response. This provides insights into how fields are represented and should be updated.
4.  Develop your update scripts iteratively: Start with simple fields and gradually incorporating more complex or custom fields. This approach helps isolate and troubleshoot formatting issues.
5.  Implement error handling: Implement error handling in your scripts to capture and respond to common issues, such as incorrect field IDs, validation errors, or permission issues.

By thoroughly understanding the JSON payload format and field-specific requirements, you can effectively update issues in Jira Cloud, ensuring your scripts function as intended in the new environment.

Basic structure

The JSON payload for updating an issue is typically structured with a root `fields` object. Each field you wish to update is included as a key-value pair within this object. For example:

```
{
	"fields": {
		"summary": "Updated issue summary",
		"description": "Updated issue description"
	}
}
```

Field-specific formatting

Different field types may require specific formatting in the JSON payload. Understanding these requirements is crucial for successful updates:

-   Text fields: Straightforward, accepting plain text strings.
-   Select lists: Require the option's ID or value to be specified.
-   User picker fields: Require the account ID of the user, rather than their username or email.
-   Date fields: Must be formatted in ISO-8601 format (for example `2025-03-04`).
-   Multi-select fields: Accept an array of IDs or values.

Custom fields

Custom fields are identified by their unique IDs (for example `customfield_10010`). Ensure you use the correct ID in the JSON payload:

```
{
	"fields": {
		"customfield_10010": "Custom value"
	}
}
```

Complex fields

Fields like `components` or `labels` may require arrays of objects or strings:

```
{
	"fields": {
		"components": [
			{ "id": "10001" }
		],
		"labels": ["label1", "label2"]
	}
}
```

For more details on implementation for basic operations see the [Common operations](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips#common-operations--en) section below.

### Step four: Leverage Unirest in ScriptRunner for Jira Cloud

When working with ScriptRunner for Jira Cloud, the Unirest library is a powerful tool for making HTTP requests to interact with Jira's REST API and other web services. It's important to understand how to use Unirest effectively within ScriptRunner scripts to perform actions like retrieving, creating, or updating Jira issues. Below we describe how to use Unirest in ScriptRunner for Jira Cloud:

-   Unirest library: Unirest is a lightweight HTTP library that simplifies making HTTP requests in Java and Groovy. We recommend you research the ScriptRunner for Jira Cloud style for writing HTTP calls using the Unirest library. This library is auto-imported into scripts, allowing you to directly use methods like `get()`, `put()`, and `post()` as documented in [Unirest's documentation](https://kong.github.io/unirest-java/requests/) without additional import statements. See our documentation on the [Unirest Library](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips/unirest-library) for more information.
-   Example scripts: Review the available [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) on the ScriptRunner website and within the Script Console in your Jira Cloud instance. These examples provide insights into the style and code structure for common use cases.

By following these steps, you'll be well-prepared to rewrite your Server/Data Center scripts for Jira Cloud, ensuring a smooth transition and maintaining the desired functionality in the new environment.

### Step five: Test your scripts, API calls and integrations

-   Test real scenarios: Use the Test environment described above to simulate real scenarios and workflows that your scripts will encounter in production. This includes testing API calls, integrations with other applications, and handling various data inputs and outputs.
-   Monitor performance and behavior: Pay attention to how your scripts perform in the test environment. Monitor for any performance bottlenecks, unexpected behaviors, or errors that need to be addressed before going live.

By creating a test environment you can identify and resolve issues early, reducing the likelihood of disruptions in your production environment.

### Step six: Migrate to production

The final step is to deploy the scripts in the production environment.

This is a manual process, so each script must be copied manually from test environment to production environment (note that custom field IDs change per environment). Usually this process is scheduled outside working hours to reduce impact in service and needs to be heavily coordinated with the rest of the teams.

## Best practices and tips for ScriptRunner for Jira Cloud

When migrating to or working with ScriptRunner for Jira Cloud, keep these best practices and tips in mind. They apply to various use cases and can help streamline your scripting process.

### Understand REST API responses

To understand how issue values are represented in REST responses create a test issue and execute a GET request using this endpoint:

-   https://YourCloudURL.atlassian.net/rest/api/3/issue/YourIssueKey

Analyze the response to understand data structure and field representations.

### Simplify scripts for Cloud

When converting scripts from ScriptRunner for Jira Server/Data Center to ScriptRunner for Jira Cloud, you may find that many complex objects can be omitted. Server/Data Center scripts often use complex Java methods. In Cloud, these can often be replaced by straightforward REST calls with structured body parameters.

### User execution context

In Jira Cloud, scripts generally cannot be executed as another user, except for the ScriptRunner add-on user. While you can pass user account IDs as parameters to certain REST calls, the calls themselves will execute as either the initiating user or the ScriptRunner add-on user.

### Authentication headers

You do not need to manually define REST request authentication headers in ScriptRunner for Jira Cloud scripts. These headers are automatically configured. Scripts will execute as the user who triggers the script or as the ScriptRunner add-on user. This execution context is easily controlled through a drop-down menu within the ScriptRunner script configuration UI.

### Grouping scripts

In a Server/Data Center script, it is typical to call `issue.update { setX(...) }` many times to update several fields of an issue at a time. When updating multiple fields of an issue in ScriptRunner for Jira Cloud, it's crucial to group all updates into a single issue update POST call. This approach ensures that all changes are included in the same changeset and prevents multiple notifications from being sent. Here's an example comparing the Data Center (DC) version with the Cloud version:

```
//DC version
import com.atlassian.jira.component.ComponentAccessor
 
import java.sql.Timestamp
 
def versionManager = ComponentAccessor.versionManager
def projectComponentManager = ComponentAccessor.projectComponentManager
def customFieldManager = ComponentAccessor.customFieldManager
def userManager = ComponentAccessor.userManager

def issue = Issues.getByKey('SSPA-1')

def project = issue.getProjectObject()
 
def version = versionManager.getVersion(project.getId(), "Version 2.0")
def component = projectComponentManager.findByComponentName(project.getId(), "MyComponent")
def user = Users.getByName("admin")

log.warn("version = ${version}")
log.warn("component = ${component}")
 
if (version) {
    issue.update{
        setFixVersions(version)
    }
}

if (component) {
    issue.update{
        setComponents(component)
    }
}

issue.update {
    // Text Field
    setCustomFieldValue('CustomField', 'ABC')
    // Date Field
    setCustomFieldValue('CustomDatePicker', new Timestamp((new Date() + 7).time))
    // User Field
    setCustomFieldValue('UserPickerField', user)
    // System Fields
    setDescription('new description')
    setDueDate(new Timestamp((new Date() + 1).time).toString())
}


// get custom fields
def fields = ComponentAccessor.customFieldManager.customFieldObjects

//CLOUD version
 
def issueToUpdate = Issues.getByKey(issue.key) // get the issue by its key
def tomorrowStr = (new Date() + 1).format("yyyy-MM-dd'T'HH:mm:ssZ", TimeZone.getTimeZone("UTC")) // date format in iso8601

issueToUpdate.update {
    setFixVersions('1.1')
    setComment('MyComponent')
    setDescription('A generated description')
    setCustomFieldValue('Custom Field 1', 'Some text value')
    setCustomFieldValue('Custom Field 2', tomorrowStr)
    setCustomFieldValue('Custom Field 3', 'admin')
}
```

Key points to remember:

-   The Cloud script is shorter and uses one API call for all updates. The [documentation](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-put) for the update is also much simpler.
-   No managers or multiple API calls are needed in the Cloud version.
-   Ensure `fixVersion` and component exist, and fields are visible on screens.

Tip: Fields must be visible on the edit screens for them to be updated by the issue edit API.

Tip: Assertions for response codes will print out the response body and relevant information. A good pattern is to use `assert resp.status == 200` (replace 200 with the appropriate response code). Successful APIs call may respond with 204, others with 200, 201 or 303.

## Supporting technical information on APIs, listener events, and common operations

### Commonly used Atlassian Java API endpoints and their Cloud equivalents

This table maps some of the most commonly used Atlassian Java APIs (in ScriptRunner for Jira Server/Data Center) to the closest Atlassian REST API endpoints (ScriptRunner for Jira Cloud) to guide you in script conversions.

Note:

-   The latest version of the Jira Cloud platform REST API is [version 3](https://developer.atlassian.com/cloud/jira/platform/rest/v3/). [Version 2](https://developer.atlassian.com/cloud/jira/platform/rest/v2/intro/#about) and 3 of the API offer the same collection of operations. However, version 3 provides support for the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/) (ADF) and is continuously being enhanced.
-   The REST API may not provide direct equivalents for all Java API functionalities. In such cases, consider using a combination of available endpoints or re-evaluating the script's logic to fit within the cloud's constraints.
-   Always refer to the official [Jira Cloud REST API documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/) for the most up-to-date information on available endpoints and their usage.

<table class="table" id="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1"> Java API (Server)&#10;                            </th><th class="entry" id="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2"> REST API (Cloud) &#10;                            </th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">ApplicationProperties</code> (get properties) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">/rest/api/3/application-properties</code> (Get application properties) </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">AttachmentManager</code> (get attachments) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">To get an attachment use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-attachments#api-group-issue-attachments" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/attachment/content/{id}</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">CommentManager</code> (get, add comments) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">To get or add comments to an issue use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-comments#api-rest-api-3-issue-issueidorkey-comment-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}/comment</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">ProjectComponentManager</code> (get components) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">To get components use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-components/#api-rest-api-3-component-id-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/component</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">CustomFieldManager</code> (get custom fields) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">To get fields use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-fields/#api-rest-api-2-field-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/field</code> To create fields use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-fields/#api-rest-api-2-field-post" target="_blank">POST</a> (create fields) <code class="ph codeph">/rest/api/3/field</code> Do not use this endpoint to update values of fields, use the issues <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issues/#api-rest-api-2-issue-issueidorkey-put" target="_blank">PUT</a> endpoint. </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">GroupManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Create a group: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-post" target="_blank">POST</a> <code class="ph codeph">/rest/api/3/group</code> Delete a group: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/group</code> Get members of a group <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-member-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/group/member</code> Add user to group <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-user-post" target="_blank">POST</a> <code class="ph codeph">/rest/api/3/group/user</code> Remove user from group <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-user-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/group/user</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">IssueManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">To get issues use: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issues/#api-rest-api-2-issue-issueidorkey-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">IssueSecurityLevelManager / IssueSecuritySchemeManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">You need the ID to get a security level so you have to follow this: <ol class="ol"><li class="li">As an admin user Get all security schemes: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-security-schemes/#api-rest-api-3-issuesecurityschemes-id-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issuesecurityschemes</code>&#10;                                    </li><li class="li">Look for the name of your required scheme and get its ID.</li><li class="li">Use <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-security-level/#api-rest-api-3-securitylevel-id-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/securitylevel/{id}</code> to get the security level. </li></ol>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">IssueService</code> (create, update, delete) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Getting issues: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}</code> Updating issues: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-put" target="_blank">PUT</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}</code> Deleting issues: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">issueService.newIssueInputParameters()</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">You don't need to do this in cloud, you just send a JSON structure of the fields you want to change in the <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issues/#api-rest-api-2-issue-issueidorkey-put" target="_blank">PUT</a> requests body parameters. For example: <pre class="pre codeblock"><code>fields: [&#10;                (fieldId): newValue, // Text Field&#10;        ]</code></pre>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">issueService.validateUpdate</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">You don't need to do validation like this prior to updating issues in Jira Cloud as the endpoint itself will return an error if what you try to do is invalid.</td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">IssueTypeManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get all issue types the executing user has permission to see <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-types#api-rest-api-3-issuetype-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issuetype</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">JiraAuthenticationContext</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Used by Server to get user who will run a Java function. This is not required in ScriptRunner for Jira Cloud as you choose to run scripts as the <em class="ph i">Current User</em> or <em class="ph i">ScriptRunner Addon User</em> only <em class="ph i">.</em> You may need to pass user ID's in the REST API body parameters, but running a script as a user other than <em class="ph i">Current User</em> or <em class="ph i">ScriptRunner Add-on User</em> is not currently possible in Cloud. </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">LabelManager</code> (get labels) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">/rest/api/3/label</code> (no direct equivalent; manage labels via issue updates) </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">LinkManager</code> (issue linking) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">/rest/api/3/issueLink</code> (create, retrieve issue links) </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">OptionsManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Updating field options: Currently, these endpoints are all experimental for Jira Cloud so you may not be able to do exactly the same thing as in Jira Server.Refer to all the experimental endpoints <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-custom-field-options/#api-group-issue-custom-field-options" target="_blank">here</a>. </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">PriorityManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get all Issue Priorities <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-priorities/#api-rest-api-2-priority-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/2/priority</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">ProjectManager</code> (get project details) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get a project details by id or key: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-projectidorkey-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}</code> Get projects with a paginated search using project Key or Name: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-search-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/project/search</code> Update a project by id or key: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-projects/#api-rest-api-2-project-projectidorkey-put" target="_blank">PUT</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}</code> Delete a project by id or key: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-projects/#api-rest-api-2-project-projectidorkey-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">ProjectRoleservice / ProjectRoleManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Control role actors <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-project-role-actors/#api-group-project-role-actors" target="_blank">PUT</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}/role/{id}</code> Get a projects roles <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-project-roles/#api-group-project-roles" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}/role</code> Delete project roles <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-project-roles/#api-rest-api-2-role-id-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/role/{id}</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">SearchService</code> (execute JQL queries) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Search with JQL using rest <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-search/#api-rest-api-3-search-jql-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/search/jql</code> If the JQL is too large for a query param use <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-search/#api-rest-api-3-search-jql-post" target="_blank">POST</a> <code class="ph codeph">/rest/api/3/search/jql</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">UserManager</code> (get user details) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get user details <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-users/#api-rest-api-3-user-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/users/search</code> Get all users <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-users/#api-rest-api-3-users-search-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/users/search</code> Search users with query <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-user-search/#api-rest-api-3-user-search-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/user/search</code> User <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-users/#api-rest-api-2-user-post" target="_blank">creation</a> and <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-users/#api-rest-api-2-user-delete" target="_blank">deletion</a> is in experimental state. </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">VersionManager</code> (get versions) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get all versions for a project: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-versions#api-group-project-versions" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/project/{projectIdOrKey}/versions</code> Create versions for a project: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-versions/#api-rest-api-3-version-post" target="_blank">POST</a> <code class="ph codeph">/rest/api/3/version</code> Update versions within a project: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-versions/#api-rest-api-3-version-id-put" target="_blank">PUT</a> (Update versions) <code class="ph codeph">/rest/api/3/version/{id}</code> Delete/Replace versions in a project: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-versions/#api-rest-api-3-version-id-removeandswap-post" target="_blank">POST</a> <code class="ph codeph">/rest/api/3/version/{id}/removeAndSwap</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">WatcherManager</code>&#10;                            </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 ">Get Watchers for an issue: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-watchers/#api-rest-api-2-issue-issueidorkey-watchers-get" target="_blank">GET</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}/watchers</code> Add watchers to an issue: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-watchers/#api-rest-api-2-issue-issueidorkey-watchers-post" target="_blank">POST</a> (add watchers) <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}/watchers</code> Delete watchers from an issue: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-watchers/#api-rest-api-2-issue-issueidorkey-watchers-delete" target="_blank">DELETE</a> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}/watchers</code>&#10;                            </td></tr><tr class="row"><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">WorklogManager</code> (get add worklogs) </td><td class="entry" headers="commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__1 commonly-used-atlassian-java-api-endpoints-and-their-cloud-equivalents--en__generated-table-id-1__entry__2 "> <code class="ph codeph">/rest/api/3/issue/{issueIdOrKey}/worklog</code> (get, add worklogs to an issue) </td></tr></tbody></table>

### Common listener events availability

Below is a list of common listener events in ScriptRunner for Jira Server/Data Center and their availability in Cloud. More detail on what ScriptRunner can do with the supported Cloud events can be found on our [Script Listeners](../features/script-listeners.md) page.

| Server/DC Event | Available? | Notes |
| --- | --- | --- |
| Issue Created/Updated/Deleted |  |  |
| Issue Assigned |  |  |
| Issue Resolved |  |  |
| Issue Closed |  |  |
| Issue Reopened |  |  |
| Issue Moved |  |  |
| Issue Link Created/Deleted |  |  |
| Issue Watcher Added/Deleted |  |  |
| Issue Archived |  | Not a Cloud feature |
| Comment Created/Updated/Deleted |  |  |
| Project Created/Updated/Deleted |  |  |
| Project Component events |  |  |
| Project Role events |  |  |
| Version Created/Updated/Deleted |  |  |
| Version Moved |  |  |
| Version Released/Unreleased |  |  |
| User Created/Deleted/Edited |  | User management events may not be directly available in Cloud. |
| Group Created/Updated/Deleted |  |  |
| Worklog Created/Updated/Deleted |  |  |
| Custom Event |  | Custom events are not directly supported in Cloud but can be simulated using webhooks and automation. |

### Common operations

Here we have listed some common operations required in ScriptRunner for Jira Cloud scripts. Switch between the tabs to show the Cloud or Server/Data Center scripts. These operations can be utilized for many use cases.

Note: Where relevant we have provided a HAPI version and a Jira API version of the Server/Data Center scripts. These versions highlight the advantages of using HAPI, demonstrating shorter, clearer scripts that are easier to convert to Cloud.

#### Get field name to ID map

Cloud

```
/*
 For Cloud, you are unlikely to need a map of field names to IDs for custom fields, as you can simply update or create an issue using the custom field name instead of its ID by using HAPI methods
*/
def fieldNameToIdMap
 
def fields = get('/rest/api/2/field')
        .header('Content-Type', 'application/json')
        .asObject(List)
if (fields.status == 200){
    fieldNameToIdMap = fields.body.collectEntries {
        [(it.name): it.id]
    }
} else {
    return "Failed to generate fields map ${fields.status} ${fields.body}"
}
```

Server/Data Center

```
/*
 For Server/DC you are unlikely to need to get a map of field names to ID for custom fields as you can just
 use this simple method to get a collection CustomField objects and then filter by name as shown in the next example.
*/
import com.atlassian.jira.component.ComponentAccessor

def fields = ComponentAccessor.customFieldManager.getCustomFieldObjects()
```

#### Get a single field ID with its name

Cloud

```
/*
 For Cloud, you are unlikely to need custom field ID, as you can simply update or create an issue using its name using HAPI methods
*/
final customFieldName = 'TextFieldA'

def fieldId
def fields = get('/rest/api/2/field')
        .header('Content-Type', 'application/json')
        .asObject(List)
if (fields.status == 200){
    fieldId = fields.body.find {
        it.name == customFieldName
    }.id
} else {
    return "Failed to generate fields map ${fields.status} ${fields.body}"
}
```

Server/Data Center

```
import com.atlassian.jira.component.ComponentAccessor
 
final FIELD_NAME = 'TextFieldA'
 
def customFieldId = ComponentAccessor.customFieldManager.getCustomFieldObjectsByName(FIELD_NAME).find().id
```

#### Update fields

Cloud

```
def issue = Issues.getByKey("TEST-2")

issue.update {
    setSkipScreenCheck(true)
    setCustomFieldValue("SelectListA", "BBB") //Single Select List
    setCustomFieldValue("Multi Select", "BBBB", "CCCC") //Multi Select List
    setCustomFieldValue("RadioButtonA", "Maybe") // Radio Buttons
    setCustomFieldValue("CheckBoxA", "Maybe", "No") // Checkboxes
    setCustomFieldValue("TextFieldA", "QWERTY") // Text Field
    setCustomFieldValue("UserPickerA", "5b9a84022d389f762bd0bd23")  // Single User Picker
    setCustomFieldValue("MultiUserPickerA", "5b9a84022d389f762bd0bd23")  // Multi User Picker
    setCustomFieldValue("DateTimePickerA",  "2021-10-16T15:41:00.000+0100")  // Date Time Field
    setCustomFieldValue("DatePickerA", "2021-10-11")  // Date Field
    setCustomFieldValue("ProjectPickerA", "TP")  // Project Picker
    setCustomFieldValue("LabelFieldA", "here", "test")  // Labels field
    setCustomFieldValue("VersionPickerA", "testv1") // Single Version Picker
    setCustomFieldValue("MultiVersionPickerA", "testv1", "anotherv2") // Multi Version Picker
    setCustomFieldValue("singleGroup", "jira-software-users-mattdevtest") // Single Group Picker
    setCustomFieldValue("multiGroup", "jira-servicemanagement-users-mattdevtest", "jira-software-users-mattdevtest", "jira-workmanagement-users-mattdevtest") //Multi-Group Picker    
}
```

Server/Data Center (HAPI version)

```
// Example from https://www.scriptrunnerhq.com/help/example-scripts/basics-updating-customfields-onPrem
// the issue key to update
def issueKey = "Test-1"

Issues.getByKey(issueKey).update {
    // set custom fields with options (select lists, checkboxes, radio buttons)
    setCustomFieldValue('SelectListA', 'BBB')
    setCustomFieldValue('MultiSelectA', 'BBB', 'CCC')
    setCustomFieldValue('RadioButtons', 'Yes')
    setCustomFieldValue('Checkboxes', 'Maybe', 'Yes')

    // cascading select
    setCustomFieldValue('CascadingSelect', 'BBB', 'B2')

    // set text fields
    setCustomFieldValue('TextFieldA', 'New Value')

    // set user fields
    setCustomFieldValue('UserPicker', 'bob')
    setCustomFieldValue('MultiUserPickerA', 'bob', 'alice')

    setCustomFieldValue('GroupPicker', 'jira-users')
    setCustomFieldValue('MultiGroupPicker', 'jira-users', 'jira-administrators')

    // set date, and date-time custom fields
    setCustomFieldValue('First DateTime', '04/Feb/12 8:47 PM')
    // setCustomFieldValue('Date', '04/Feb/12')

    // a "project picker" custom field - provide a project key
    setCustomFieldValue('ProjectPicker', 'SSPA')

    // set custom field of type version
    setCustomFieldValue('SingleVersionPicker', 'Version1')
}
```

Server/Data Center (Jira API version)

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.fields.CustomField
import groovy.transform.Field

// the issue key to update
@Field final String issueKey = "Test-1"

// the name of a 'single select list' custom field
final String selectList = "SelectListA"

// the name of a 'multi select list' custom field
final String multiSelectList = "MultiSelectA"

// name of a 'radio button' custom field
final String radioButtonField = "RadioButtons"

// name of a 'check box' custom field
final String checkboxField = "Checkboxes"

// the name of a 'text field' custom field
final String textField = "TextFieldA"

// the name of a 'user picker' custom field
final String userPicker = "UserPicker"

// the name of a 'multi user picker' custom field
final String multiUserPicker = "MultiUserPickerA"

// the name of a 'group picker' custom field
final String groupPicker = "GroupPicker"

// the name of a 'multi group picker' custom field
final String multiGroupPicker = "MultiGroupPicker"

// the name of a 'date and time' custom field
final String dateTimeField = "First DateTime"

// the name of a 'date' custom field
final String dateField = "Date"

// the name of a 'project picker' custom field
final String projectPickerField = "ProjectPicker"

// the name of a 'label' picker custom field
final String labelField = "LabelField"

// name of a 'single version picker' custom field
final String versionField = "VersionPicker"

// name of a 'multi version picker' custom field
final String multiVersionField = "VersionsPicker"

// change to 'true' if you want to send an email if the update is successful
final boolean sendMail = false

def issueService = ComponentAccessor.issueService
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issue = ComponentAccessor.issueManager.getIssueByCurrentKey(issueKey)

assert issue: "Could not find issue with key $issueKey"

def issueInputParameters = issueService.newIssueInputParameters().with {
    // set custom fields with options (select lists, checkboxes, radio buttons)
    addCustomFieldValue(getSingleCustomFieldByName(selectList).id, *getOptionIdsForFieldByValue(selectList, "BBB"))
    addCustomFieldValue(getSingleCustomFieldByName(multiSelectList).id, *getOptionIdsForFieldByValue(multiSelectList, "BBB", "CCC"))
    addCustomFieldValue(getSingleCustomFieldByName(radioButtonField).id, *getOptionIdsForFieldByValue(radioButtonField, "Yes"))
    addCustomFieldValue(getSingleCustomFieldByName(checkboxField).id, *getOptionIdsForFieldByValue(checkboxField, "Maybe", "Yes"))

    // set text fields
    addCustomFieldValue(getSingleCustomFieldByName(textField).id, "New Value")

    // set user fields
    addCustomFieldValue(getSingleCustomFieldByName(userPicker).id, "admin")
    addCustomFieldValue(getSingleCustomFieldByName(multiUserPicker).id, "admin", "anuser")

    // set group fields
    addCustomFieldValue(getSingleCustomFieldByName(groupPicker).id, "jira-users")
    addCustomFieldValue(getSingleCustomFieldByName(multiGroupPicker).id, "jira-users", "jira-administrators")

    // set custom field of type date
    addCustomFieldValue(getSingleCustomFieldByName(dateTimeField).id, "04/Feb/12 8:47 PM")
    addCustomFieldValue(getSingleCustomFieldByName(dateField).id, "04/Feb/12")
}

// set project picker field
def project = ComponentAccessor.projectManager.getProjectObjByKey("SSPA")
assert project: "Could not find project"
issueInputParameters.addCustomFieldValue(getSingleCustomFieldByName(projectPickerField).id, project.id.toString())

// set custom field of type label
issueInputParameters.addCustomFieldValue(getSingleCustomFieldByName(labelField).id, "foo", "bar")

// set custom field of type version picker
def versionOne = ComponentAccessor.versionManager.getVersions(issue.projectObject).findByName("Version1")
assert versionOne: "Could not find version"
issueInputParameters.addCustomFieldValue(getSingleCustomFieldByName(versionField).id, versionOne.id.toString())

// set custom field of type multi-version picker
def versionTwo = ComponentAccessor.versionManager.getVersions(issue.projectObject).findByName("Version2")
assert versionTwo: "Could not find version"
issueInputParameters.addCustomFieldValue(getSingleCustomFieldByName(multiVersionField).id, versionOne.id.toString(), versionTwo.id.toString())

def updateValidationResult = issueService.validateUpdate(loggedInUser, issue.id, issueInputParameters)
assert updateValidationResult.valid: updateValidationResult.errorCollection

def issueUpdateResult = issueService.update(loggedInUser, updateValidationResult, EventDispatchOption.ISSUE_UPDATED, sendMail)
assert issueUpdateResult.valid: issueUpdateResult.errorCollection

/**
 * Get a custom field given a custom field name.
 * If there are than one custom fields with the same name under the same Context then return the first one.
 * @param fieldName The name of the custom field
 * @param issue The issue to look for that custom field
 * @return the custom field, if that exists
 */
CustomField getSingleCustomFieldByName(String fieldName) {
    def issue = ComponentAccessor.issueManager.getIssueByCurrentKey(issueKey)
    def customField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue).findByName(fieldName)

    assert customField: "Could not find custom field with name $fieldName"
    customField
}

/**
 * Given a custom field name and option values, retrieve their ids as String
 * @param customFieldName The name of the custom field
 * @param values The values in order to get their ids
 * @return List < String >  The ids of the given values
 */
List<String> getOptionIdsForFieldByValue(String customFieldName, String... values) {
    def issue = ComponentAccessor.issueManager.getIssueByCurrentKey(issueKey)
    def customField = getSingleCustomFieldByName(customFieldName)

    ComponentAccessor.optionsManager.getOptions(customField.getRelevantConfig(issue)).findAll {
        it.value in values.toList()
    }*.optionId*.toString()
}
```

#### Perform JQL searches

Cloud

```
def issues = Issues.search("project = TEST")

// print all the issue keys just to demonstrate what was found
issues*.key
```

Server/Data Center (HAPI version)

```
// Example from https://www.scriptrunnerhq.com/help/example-scripts/jql-search-onPrem
Issues.search('project = TEST').each { issue ->
    // do something with `issue`
}
```

Server/Data Center (Jira API version)

```
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.SearchException
import com.atlassian.jira.web.bean.PagerFilter
import org.apache.log4j.Level

// Set log level to INFO
log.setLevel(Level.INFO)

// The JQL query you want to search with
final jqlSearch = "project = TEST"

// Some components
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def searchService = ComponentAccessor.getComponentOfType(SearchService)

// Parse the query
def parseResult = searchService.parseQuery(user, jqlSearch)
if (!parseResult.valid) {
    log.error('Invalid query')
    return null
}

try {
    // Perform the query to get the issues
    def results = searchService.search(user, parseResult.query, PagerFilter.unlimitedFilter)
    def issues = results.results
    issues.each {
        log.info(it.key)
    }

    issues*.key
} catch (SearchException e) {
    e.printStackTrace()
    null
}
```

## Related Content

-   [Simplify Current Scripts with HAPI](https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi)
-   [API documentation for Jira Cloud](https://developer.atlassian.com/cloud/jira/platform/rest/v2/intro/)
-   [API documentation for Jira Server](https://docs.atlassian.com/software/jira/docs/api/8.13.15/)
-   [Migrate from ScriptRunner for Jira Server to Cloud Guide](migration-checklist.md)
