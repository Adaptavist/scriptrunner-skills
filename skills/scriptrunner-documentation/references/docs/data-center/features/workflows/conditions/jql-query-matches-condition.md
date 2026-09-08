# JQL Query Matches Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885471
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/jql-query-matches-condition

Use the _JQL Query Matches Condition_ to control if an issue can be transitioned based on if a JQL query would return the current issue.

For example:

-   If you want the transition to be allowed when the current issue is using the _Task_ issue type, you would use the JQL query: `issuetype = "Task"`
-   If you want the transition to be allowed when the current issue has a **Priority** of _Medium_ or higher, you would use the JQL query: `priority >= Medium`

## Use this condition

You can add this condition to any transition except the _Create_ transition.  

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![](/sr4js/files/latest/442885471/442885474/1/1758746489000/JQL_query_condition_1.png)  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **JQL query matches condition**. ![](/sr4js/files/latest/442885471/442885478/1/1758746489000/JQL_matches_condition_logo.png)
    
7.  Optional: Enter a note that describes the condition.
8.  Enter your **JQL Query.**
    
9.  Optional: Enter a preview issue key and select **Preview**. See the [example below](#id-.JQLQueryMatchesConditionv9.x-preview-example) for more details.
10.  Select **Update.**
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885471/442885472/1/1758746488000/JQL_condition_3.png)
     

## Testing your JQL

You can use the **Preview** feature within the workflow condition to test your JQL query against a specific issue.

1.  Edit or create a new JQL query matches condition.
2.  Enter your **JQL Query**.
3.  Enter the key for an issue you want to test with into **Preview Issue Key**.
4.  Click **Preview**.

This conditions JQL is efficient; for example if the query you enter would typically return millions of issues, it will be modified to something like the following:

```
{issue = 15130} AND {issuetype = "Task"}
```

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
