# Build Efficient Queries

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-cb7d56b2-f4a7-4bb9-a5e1-a0af5957918d-e9856b4125496e60
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#build-efficient-queries--en

Occasionally, you may encounter long loading times, which can be a result of writing inefficient queries. The image below summarises how you can write efficient queries and how you can avoid writing inefficient ones:

Some additional tips for writing efficient queries include:

-   ScriptRunner Enhanced Search allows for sub-queries, which can be optimised separately before being included in the main query.
-   We process Enhanced Search functions individually, so try to minimise the data set within that function's parameters in order to get a benefit.
-   Limit the scope by project and issue types, use time restrictions, status filters, and assignees.
-   Always place project, status, and date filters inside the function itself, so only relevant issues are evaluated from the start.
-   Add a time-based condition inside the function to limit results to relevant, recent issues.
-   Always include an issue type filter inside the function when using recursive or relationship-based functions.

Note: When writing queries, ensure that you have entered a space after the comma in the query you are running, or you may see the error message _"Function 'X' does not exist"._

It's worth noting the most performance-intensive functions in ScriptRunner Enhanced Search, as listed below:

1.  [`linkedIssuesOf`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesof--en)
2.  [`Recursive`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesofrecursive--en) functions
3.  [`projectMatch`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#projectmatch--en)
4.  [`versionMatch`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#versionmatch--en)
5.  [`componentMatch`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#componentmatch--en)

You can refer to our [Troubleshooting](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search) section for more information.

## How to write efficient queries video walkthrough

[Media](https://www.youtube.com/watch?v=YKlGHP9c5Kg)
