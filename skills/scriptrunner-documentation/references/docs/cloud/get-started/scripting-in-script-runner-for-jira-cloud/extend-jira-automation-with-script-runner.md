# Extend Jira Automation with ScriptRunner

- Platform: cloud
- Space: SR4JC
- Hierarchy: Get Started > Scripting in ScriptRunner for Jira Cloud
- Doc ID: doc-sr4jc-b473e34c-cd57-484d-9e98-467a6c9be29c-f9b2d452107b6036
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud#extend-jira-automation-with-scriptrunner--en

Learn when to use ScriptRunner for Jira Cloud versus Jira Automation, and compare their capabilities for advanced, code-based automation.

ScriptRunner for Jira Cloud complements Jira Automation by enabling code-based automation, advanced workflow logic, API integrations, data transformation, reusable scripts, and admin-level automation. ScriptRunner is best suited to advanced automation scenarios where you need greater flexibility.

## When to use ScriptRunner or Jira Automation

We've provided a comparison of the capabilities of ScriptRunner for Jira Cloud and Jira Automation below to help you determine which tool is most appropriate for a given use case.

## Use ScriptRunner when you need:

-   full programming capabilities using Groovy, Typescript/JavaScript, HAPI, or assisted scripting
-   a [Script Console](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/features_script_console.dita) to run and debug scripts on demand against your live instance before deployment
-   reusable scripts via the [Script Manager](../../features/script-manager.md)
-   advanced Workflow Rules such as [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details), [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions), and [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)
-   dynamic field control and user-specific field visibility using [Behaviours](../../features/behaviours.md)
-   calculated custom fields using [Scripted Fields](../../features/scripted-fields.md)
-   custom JQL functions and keywords using [ScriptRunner Enhanced Search](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/scriptrunner_enhanced_search.dita)
-   complex data transformation, including parsing JSON or XML and manipulating collections
-   advanced REST API calls and response parsing
-   secure credential storage using [Script Variables](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/features_script_variables.dita)
-   custom retry logic and more detailed error handling
-   bulk work item processing and complex multi-work item operations
-   admin-level actions such as managing users, groups, and space roles

## Use Jira Automation when you need:

-   a visual drag-and-drop builder
-   quick no-code rule creation
-   simple event-driven automations
-   basic branching and workflow extensions
-   space-admin access to create and manage automation rules

## Capability comparison table

| Capability | ScriptRunner for Jira | Jira Automation |
| --- | --- | --- |
| Rule builder style | Code-based | Visual drag-and-drop |
| Execution model | Direct script execution | Queued, subject to Atlassian throttling |
| Programming support | Groovy, Typescript/JavaScript, HAPI, assisted scripting | Limited to no-code and smart values |
| Space support | Company-managed and team-managed spaces | Company-managed and team-managed spaces |
| Workflow Rules | Advanced validators, conditions, and post-functions | Basic workflow extensions |
| Dynamic field control |  | Static field configuration only |
| User-specific field visibility |  |  |
| Calculated custom fields |  |  |
| Custom JQL functions and keywords |  | Standard JQL only |
| Complex data transformation |  | Limited smart value functions |
| Advanced REST API calls |  | Basic "send web request" support |
| API response parsing | Programmatic parsing of JSON and XML responses, including nested structures, conditional logic on response data, and error handling | Limited parsing |
| Secure credential storage | Script Variables, centralised, encrypted credential storage, reusable across scripts | No central credential store or cross-rule reuse |
| Custom retry logic | Exponential backoff and custom error handling | Not supported |
| Bulk work item processing |  | Limited bulk actions |
| Complex multi-work item operations | Conditional hierarchy and multi-work item processing | Basic branch rules only |
| User and group management | Supported | Not supported |
| space role management | Supported | Not supported |
| Error handling | Try/catch, custom retry, detailed logging | Basic continue-on-error behavior |
| Code reusability |  |  |
| Interactive testing | Script Console for rapid pre-deployment testing | Built-in rule testing and audit log for reviewing execution history |
| Who can create automations | Users with access to the ScriptRunner administration panel, typically Jira Admins. Access is configurable per instance. | Space Admins and Jira Admins |
