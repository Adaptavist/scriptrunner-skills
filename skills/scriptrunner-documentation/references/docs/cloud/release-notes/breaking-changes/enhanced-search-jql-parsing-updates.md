# Enhanced Search: JQL Parsing Updates

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4jc-574522225
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/enhanced-search-jql-parsing-updates

Atlassian's Jira Cloud search [now strictly enforces valid JQL syntax and operators](https://developer.atlassian.com/changelog/#CHANGE-3131). Invalid JQL clauses will return in zero results. Previously, some invalid JQL clauses were handled and could return partial or lenient results, which created inconsistent search behavior. Jira Cloud is now handling these invalid JQL cases like Jira Data Center and follows the [JQL documentation](https://www.atlassian.com/software/jira/guides/jql/cheat-sheet#intro-to-jql). This change is not backwards compatible. Invalid syntax or operators that were previously in use will now receive zero results for those clauses, instead of partial or lenient results.

For example, `issuetype = ("Task", "Story")` uses the incorrect `=` operator. It should be `issuetype IN "Task", "Story")`.

### How Enhanced Search is impacted

Enhanced Search runs initial parsing checks, but it will not catch every server-side validation rule enforced by Atlassian. If you notice that your searches that previously worked are returning zero results, please review your JQL and ensure it aligns with the Atlassian [JQL documentation](https://www.atlassian.com/software/jira/guides/jql/cheat-sheet#intro-to-jql). We anticipate the most impacted clauses will be due to incorrect operators.

### What you need to do

To ensure your searches continue to function correctly, please review and update any saved queries or automated JQL strings that you rely on within Enhanced Search. If a search is failing, we recommend copying your JQL directly into Jira's native [advanced search bar](https://support.atlassian.com/jira-software-cloud/docs/what-is-advanced-search-in-jira-cloud/#Construct-JQL-queries), which highlights any syntax errors that need to be corrected.
