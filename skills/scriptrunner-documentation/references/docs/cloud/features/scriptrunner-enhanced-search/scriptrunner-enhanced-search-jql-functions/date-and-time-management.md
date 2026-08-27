# Date and Time Management

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-functions
- Doc ID: doc-sr4jc-313196626
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/date-and-time-management

## dateCompare

The ScriptRunner Enhanced Search JQL `dateCompare` function allows you to find issues based on date comparisons between two dates associated with the same issue. It is helpful for:

-   Ensuring project timelines are adhered to by comparing creation, update, resolution, and due dates.
    
-   Facilitating detailed audit trails and compliance checks by examining the timing of issue updates relative to other critical milestones.
    
-   Supporting dynamic reporting and insights into project management processes, such as identifying bottlenecks or delays in resolving issues.
    

### **Syntax and parameters:**

```
dateCompare(Subquery, Date Comparison Expression)
```

-   **Subquery:** A JQL query that defines the subset of issues to be evaluated.
    
-   **Date comparison expression:** A string that specifies how two dates should be compared. This can involve literal dates, date fields, arithmetic operations on dates (such as adding days or weeks), and methods to manipulate date and time values.
    

### **Examples**

1.  **Finding issues updated after they were created:**
    
    To identify all issues in a project that were updated after their creation date:
    
    ```
issueFunction in dateCompare("project = DEMO", "created < updated")
```
    
    This query can help in tracking modifications or follow-ups on issues post-creation.
    
2.  **Identifying issues resolved around their due dates:**
    
    To find issues that were resolved up to six days after their due date:
    
    ```
issueFunction in dateCompare("project = DEMO", "resolutiondate +1d < duedate +1w")
```
    
    This is useful for performance analysis, to understand how often issues are resolved in proximity to their deadlines.
    
3.  **Comparing resolution to a custom date field:**
    
    For issues that need to be resolved by a specific custom date:
    
    ```
issueFunction in dateCompare("project = DEMO", "resolutiondate <= customfield_10500")
```
    
    This could be used to ensure compliance with externally mandated or contractually obligated timelines.
    

-   **Precision in date comparisons:** When comparing dates that include times, consider using methods like `.clearTime()` to focus only on the date components if the time of day is not relevant.
    
-   **Optimize performance:** Keep the subquery as narrow as possible to improve the performance of the date comparison, especially in larger projects.
    
-   **Regular review of date-dependent workflows:** Use `dateCompare` in regular reviews to monitor and optimize workflows that are heavily dependent on timely issue resolutions and updates.
