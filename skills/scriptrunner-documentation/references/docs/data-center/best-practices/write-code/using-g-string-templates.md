# Using GString Templates

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442888180
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/using-gstring-templates

ScriptRunner allows you to write Groovy scripts with dynamically generated text using GString Templates. You can add dynamic text in a template using the `${expression}` syntax. All editors supporting GString Templates in ScriptRunner have [Code Insight](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor), allowing you to utilize code completions, parameter hints, and Javadoc lookup.

![](/sr4js/files/latest/442888180/442888182/1/1758746913000/G_string_screen.png)

Below we show a simple example of how you can use GString Templates in ScriptRunner. 

For example, if you want to create a _Send Custom Email_ listener, you can write the **Email template** and **Subject template** using GString Templates.

1.  Enter the following into the **Email template** field:
    
    ```
Dear ${issue.assignee?.displayName},
 
The ${issue.issueType.name} ${issue.key} with priority ${issue.priority?.name} has been assigned to you.

Regards,
${issue.reporter?.displayName}
```
    
2.  Enter the following into the **Subject template** field:
    
    ```
Issue ${issue.key} has been assigned to you.
```
    

For help with using the Java API see our Introduction to Atlassian Java API.
