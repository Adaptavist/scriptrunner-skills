# ScriptRunner Enhanced Search JQL Functions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-103678001
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions

Custom field name duplicates

If you have custom fields with the same name as Jira default fields, ScriptRunner Enhanced Search will prioritise Jira’s default fields during searches. We recommend renaming your custom fields before using them in search queries, as Jira’s default fields will be used instead of custom fields with the same name.

ScriptRunner Enhanced Search features several advanced ScriptRunner Enhanced Search JQL functions not available as default in Jira, which are documented within this section. 

Almost all functions require a subquery as a first parameter. If you provide an empty string (e.g.,""), your query will be inefficient because it matches all issues in your Jira instance.

You should be aware if you use the statement below within your subqueries, this means that other users will see your results, not their own results:

`assignee = currentUser()`

For example, `issueFunction` in `linkedIssuesOf("assignee = currentUser()")` saved as a ScriptRunner Enhanced Search filter will always show the issues linked to the filter owner's tickets, regardless of who views the filter.

Space Required After Commas

If you see an error message informing you that **_"Function 'X' does not exist"_**, then you should check that you have entered a space after the comma in the query you are running.

## Operators

ScriptRunner Enhanced Search uses the  `in` and `not in` operators for all JQL functions. You can also use some additional [operators](#id-.JQLFunctionsvCurrent-DateFunctions) for the Date Function.
