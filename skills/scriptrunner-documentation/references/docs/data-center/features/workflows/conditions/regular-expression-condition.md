# Regular Expression Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885550
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/regular-expression-condition

Use the _Regular Expression Condition_ to make a transition unavailable if a text field input does not match a regular expression. For example, you may want to use this condition to ensure:

-   a field contains only letters and numbers. You could use `^[A-Za-z0-9]*$` when you enter the regular expression.
-   a **US Social Security** field is populated in the correct format. You could use `^(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$` when you enter the regular expression.
-   a **UK Postcode** field is in the correct format. You could use `^(GIR ?0AA|[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2})$` when you enter the regular expression.

This condition is only available on text fields

Text fields supported include:

-   System fields - **Description**, **Environment**, and **Summary**
-   Custom fields - **Text Field (single line)** and **Text Field (multi-line)**

You can add this condition to any transition in a workflow that allows conditions.

## Use this condition

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![](/sr4js/files/latest/442885550/442885553/1/1758746495000/Reg_ex_1.png)  
    **
5.  Select **Regular expression condition**.
    
6.  Optional: Enter a description of the condition in **Note**. This allows you to identify your workflow condition more easily.
    
7.  Select the **Field** to validate with the regular expression.
    
    Make sure your selected field is on the screen for the project(s) your condition applies. This condition function will check field values even if they are not on the screen.
    
8.  Enter the Java **Regular Expression** to validate the field value against. You can expand **Show Examples** for common regular expressions.
    
    For a tutorial on how to write a regular expression, see [Oracle's Regular Expressions tutorial.](https://docs.oracle.com/javase/tutorial/essential/regex/) 
    
    We recommend you [test your regular expression](https://regex101.com/) before saving.
    
9.  Optional: Select **Match Entire String**. When selected, all text input in the chosen field must match the regular expression provided. By default, the condition only checks if the regular expression exists in part of the text field value. 
    
10.  Enter a **Preview Issue Key** to test the regular expression on an existing issue.
11.  Select **Preview**.  
     The result will display as `true` or `false`, depending if the issue provided matches the regular expression or not. 
12.  Select **Update**.  
     ![](/sr4js/files/latest/442885550/442885552/1/1758746494000/Reg_ex_2.png)
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885550/442885551/1/1758746494000/Reg_ex_3.png)
     

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
