# Copy Field Values

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885922
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/copy-field-values

The _Copy Field Values_ post function copies the values from a configured field to another field on the same issue or to another field on linked issues. This post function can be used to keep fields up-to-date, eliminating the need for manual input of values.

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885922/442885936/1/1758746531000/Comment_to_issue_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Copy field values**.  
    ![Image selecting this post function](/sr4js/files/latest/442885922/442885941/1/1758746531000/Copy_field_values_logo.png)  
    
7.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
8.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
9.  Enter the **Issue relation.** This is the relationship between the issue in transition (containing the **Source Field**), and the issue containing the **Target Field**. This is either:
    1.  _Within the same issue_ - The **Source Field** and **Target Field** are in the same issue.
    2.  _Linked issues -_ The **Source Field** and **Target Field** are in different issues linked with the selected link type. Select the **Link Direction ( Link Type),** the values will be copied from the issue in transition to the issues linked by the selected link type.
10.  Select the **Source field.** Values will be copied from this field to the **Target field**.  
     
     If the source field has a null value, the target field value will be cleared out. If you want to prevent the post function execution in this case, use a _Condition_ to ensure the source field has a value.
     
11.  Select the **Target field.** All values are copied from the **S**ource field**** to this field.
     1.  When copying values from a _Short text_ or a _Select field_ to a target _Select field_, you can optionally check **Create options** to create any missing values in the target field. The value will be created if a matching one does not exist in the target field. If none of the options in the source field exist in the target and **Create options** is unchecked, the target field will be cleared.
         
         If the target field already contains values, they are overwritten by any copied values.
         
12.  Select **Add.**
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function.
14.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885922/442885935/1/1758746531000/Add_comment_5.png)  
     

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
