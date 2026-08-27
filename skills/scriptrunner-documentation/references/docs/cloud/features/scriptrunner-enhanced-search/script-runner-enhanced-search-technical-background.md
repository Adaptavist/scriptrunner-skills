# ScriptRunner Enhanced Search Technical Background

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-313196599
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-technical-background

Add-on developers do not have access to the underlying database, therefore, the only way we can make a search to retrieve data is by using the [Search API](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-search-get). Enhanced Search works by making simple queries to available APIs and then processing the results using pattern matching, comparing, aggregation and so on.

Let’s have a look at this example query:

`assignee = currentUser() AND issueFunction in dateCompare("project = SRCLOUD", "created +1w < firstCommented") AND status = "In progress"`

This contains a nested query. As you can see, the date compare function in the middle of the expression is not natively supported by Jira Cloud. We parse this query and process the dateCompare subquery as a first step. We make a standard search using the subquery _"project = SRCLOUD"_ and then we apply the comparison expression on the results. At the end we make a final search to Jira Cloud with structure:

`assignee = currentUser() AND issue in ("10012", "10013", "10055") AND status = "In progress"`

As you can observe, the dateCompare query was replaced by another query: _issue in (..)_. It contains issue ids/keys that were evaluated from the subquery. If you specify more than one advanced subquery, all of them will be evaluated and replaced in the final search.
