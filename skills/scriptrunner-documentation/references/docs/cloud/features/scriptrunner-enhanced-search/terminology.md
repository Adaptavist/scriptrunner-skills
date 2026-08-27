# Terminology

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-335381031
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/terminology

This page provides a comprehensive list of key terms and definitions used throughout the ScriptRunner Enhanced Search for Jira Cloud app and/or within this documentation. Each term is defined concisely to offer quick reference, making it easier to interpret technical concepts. Understanding these terms will help you navigate both the app and the content more effectively and ensure clarity.

You might find some of the information in our [Troubleshoot Enhanced Search for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search) section useful too!

## Regular expression (Regex)

### Definition

A sequence of characters that define a search pattern. Regex allows you to create flexible and precise search criteria. In the context of ScriptRunner [Enhanced Search JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions), such as, `versionMatch`, `componentMatch`, `issueFieldMatch`, and `projectMatch,` regex helps users find relevant data without manually listing every possible value.

### Why use Regex?

Regex enables users to:

-   Find text that follows a **specific pattern** (e.g., versions starting with `"RC"`, projects with a numeric suffix, components containing `"API"`, etc.).
    
-   Perform **fuzzy searches** without needing exact matches.
    
-   Improve search efficiency by grouping multiple values into a **single pattern** instead of listing each one manually.
    

### Examples

Regex pattern

Meaning

Use case

`^ABC.*`

Starts with `"ABC"`

Find versions, components, or project names that begin with `"ABC"` (e.g., `"ABC-1", "ABC-Release"`).

`.*Beta$`

Ends with `"Beta"`

Match any version that ends in "Beta" (e.g., `"1.0-Beta", "2.3.5-Beta"`).

`\d+`

One or more digits

Find versions or issues containing numbers (e.g., `"V1", "V123"`).

`release-\d{4}`

`"release-"` followed by 4 digits

Match project names or versions with a year-based naming scheme (e.g., `"release-2023"`).

`` `QA ``

Testing\`

Matches `"QA" OR "Testing"`

.`*API.*`

Contains `"API"` anywhere

Find components related to APIs (e.g., `"Backend-API", "UserAPI", "Public-API-v2"`).

## Recursive

This applies to the `linkedIssuesOfRecursive` and `linkedIssuesOfRecursiveLimited` functions

### Definition

Recursive refers to the ability to traverse multiple levels of issue links, not just direct relationships but also indirect or nested dependencies.

A **recursive function** is one that calls itself repeatedly until a certain condition is met. For example, for `linkedIssuesofRecursive`:

1.  Starts with an initial issue or set of issues (from the subquery).
    
2.  Finds all directly linked issues.
    
3.  Then, for each of those linked issues, finds their linked issues.
    
4.  Continues this process until no more new linked issues are found.
    

For example, for `issueFunction in linkedIssuesOfRecursive("epic = EPIC-123")`

This query **recursively** finds:

1.  All tasks linked to **EPIC-123**.
    
2.  Then, all tasks linked to those tasks.
    
3.  Then, all tasks linked to those tasks, and so on...
    
4.  It stops when there are no more linked issues to process.
    

### Recursive vs. non-recursive example

Non-recursive: `issueFunction in linkedIssues("epic = EPIC-123")`

Finds only direct links to `EPIC-123`**.**

Recursive query: `issueFunction in linkedIssuesOfRecursive("epic = EPIC-123")`

Finds direct AND indirect dependencies, even tasks linked through multiple levels.

## Rate limiting

The Enhanced Search [JQL Keyword Sync](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) process uses Atlassian APIs to retrieve and update issue data. This can be an API intensive process, requiring many requests both to get individual issue data and to update it with metadata.

Atlassian limits the rate of REST API requests to ensure that services are reliable and responsive for all customers. You can find more information about Atlassian’s rate limiting approach and guidance [here](https://developer.atlassian.com/cloud/jira/platform/rate-limiting/). We have designed our services to handle API usage with Atlassian’s rate limiting guidance in mind.
