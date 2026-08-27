# Extend Jira Automation with ScriptRunner

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started > scripting-in-scriptrunner-for-jira-cloud
- Doc ID: doc-sr4jc-566298279
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud/extend-jira-automation-with-scriptrunner

ScriptRunner for Jira Cloud complements Jira Automation by enabling code-based automation, advanced workflow logic, API integrations, data transformation, reusable scripts, and admin-level automation. ScriptRunner is best suited to advanced automation scenarios where you need greater flexibility. 

## When to use ScriptRunner or Jira Automation

We've provided a comparison of the capabilities of ScriptRunner for Jira Cloud and Jira Automation below to help you determine which tool is most appropriate for a given use case.

### Use ScriptRunner when you need:

-   full programming capabilities using Groovy, Typescript/JavaScript, HAPI, or assisted scripting
-   a [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) to run and debug scripts on demand against your live instance before deployment
-   reusable scripts via the [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager)
-   advanced Workflow Rules such as [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details), [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions), and [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)
-   dynamic field control and user-specific field visibility using [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours)
-   calculated custom fields using [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)
-   custom JQL functions and keywords using [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search)
-   complex data transformation, including parsing JSON or XML and manipulating collections
-   advanced REST API calls and response parsing
-   secure credential storage using [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables)
-   custom retry logic and more detailed error handling
-   bulk work item processing and complex multi-work item operations
-   admin-level actions such as managing users, groups, and space roles

### Use Jira Automation when you need: 

-   a visual drag-and-drop builder
-   quick no-code rule creation
-   simple event-driven automations
-   basic branching and workflow extensions
-   space-admin access to create and manage automation rules

## Capability comparison table

Capability

ScriptRunner for Jira

Jira Automation

Rule builder style

Code-based

Visual drag-and-drop

Execution model  

Direct script execution

Queued, subject to Atlassian throttling

Programming support

Groovy, Typescript/JavaScript, HAPI, assisted scripting

Limited to no-code and smart values

Space support

Company-managed and team-managed spaces

Company-managed and team-managed spaces

Workflow Rules

Advanced validators, conditions, and post-functions

Basic workflow extensions

Dynamic field control

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

Static field configuration only

User-specific field visibility

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

Calculated custom fields

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

Custom JQL functions and keywords

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

Standard JQL only

Complex data transformation

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

Limited smart value functions

Advanced REST API calls

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

Basic “send web request” support

API response parsing

Programmatic parsing of JSON and XML responses, including nested structures, conditional logic on response data, and error handling

Limited parsing

Secure credential storage

Script Variables, centralised, encrypted credential storage, reusable across scripts

No central credential store or cross-rule reuse

Custom retry logic

Exponential backoff and custom error handling

Not supported

Bulk work item processing

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

Limited bulk actions

Complex multi-work item operations

Conditional hierarchy and multi-work item processing

Basic branch rules only

User and group management

Supported

Not supported

space role management

Supported

Not supported

Error handling

Try/catch, custom retry, detailed logging

Basic continue-on-error behavior

Code reusability

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

Interactive testing

Script Console for rapid pre-deployment testing

Built-in rule testing and audit log for reviewing execution history

Who can create automations

Users with access to the ScriptRunner administration panel, typically Jira Admins. Access is configurable per instance.

Space Admins and Jira Admins
