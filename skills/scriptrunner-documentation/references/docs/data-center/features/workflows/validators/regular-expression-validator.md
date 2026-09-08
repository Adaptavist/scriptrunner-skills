# Regular Expression Validator

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885684
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/regular-expression-validator

Use the Regular expression validator to validate that the text field input on a transition screen matches a regular expression (regex) before transitioning the issue. A regular expression is a sequence of characters that specifies a pattern. For example, you may want to use this validator to ensure:

-   a field contains only letters and numbers. You could use `^[A-Za-z0-9]*$` when you enter the regular expression.
-   a **US Social Security** field is populated in the correct format. You could use `^(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$` when you enter the regular expression.
-   a **UK Postcode** field is in the correct format. You could use `^(GIR ?0AA|[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2})$` when you enter the regular expression.

This condition is only available on text fields

Text fields supported include:

-   System fields - **Description**, **Environment**, and **Summary**
-   Custom fields - **Text Field (single line)** and **Text Field (multi-line)**

## Use this validator

You can add this condition to any transition in a workflow. 

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this validator to. 
3.  Select the transition you want to add this validator to.
4.  Under **Options**, select **Validators.  
    ![Image of validator option being selected](/sr4js/files/latest/442885684/442885687/1/1758746505000/Regex_1.png)**
    
5.  Select ****Regular expression validator**.**
6.  Optional: Enter a description of the validator in **Note**. This allows you to identify your workflow validator more easily.
7.  Select the **Field** to validate with the regular expression.  
    
    Make sure your selected field is on the screen for the project(s) your condition applies. This condition function will check field values even if they are not on the screen.
    
8.  Enter the Java **Regular expression** to validate the field value against. You can expand **Show examples** for common regular expressions.
    
    For a tutorial on how to write a regular expression, see [Oracle's Regular Expressions tutorial.](https://docs.oracle.com/javase/tutorial/essential/regex/) 
    
    We recommend you [test your regular expression](https://regex101.com/) before saving.
    
9.  Optional: Select **Match entire string**. When selected, all text input in the chosen field must match the regular expression provided. By default, the validator only checks if the regular expression exists in part of the text field value.
10.  Enter an **Error message** to display to the user if the regular expression does not match the field value. 
11.  Select **Update**.   
     ![Image of the completed validator with all form fields filled in](/sr4js/files/latest/442885684/442885686/1/1758746505000/Regex_2.png) 
12.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     
     You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue and the chosen form field does not have an input that matches the given regular expression.
     
     ![Image example of error](/sr4js/files/latest/442885684/442885685/1/1758746505000/Regex-3.png)
     

  

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
