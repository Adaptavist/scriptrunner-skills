# Using GString Templates

- Platform: data-center
- Space: SR4JS
- Hierarchy: Best Practices > Write Code
- Doc ID: doc-sr4js-dcf7bddf-6668-4c98-8074-978c8349a570-b43376e7ae6ef044
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code#using-gstring-templates--en

ScriptRunner allows you to write Groovy scripts with dynamically generated text using GString Templates. You can add dynamic text in a template using the `${expression}` syntax. All editors supporting GString Templates in ScriptRunner have [Code Insight](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor), allowing you to utilize code completions, parameter hints, and Javadoc lookup.

Below we show a simple example of how you can use GString Templates in ScriptRunner.

For example, if you want to create a Send Custom Email listener, you can write the Email template and Subject template using GString Templates.

1.  Enter the following into the Email template field:
    
    ```
    Dear ${issue.assignee?.displayName},
     
    The ${issue.issueType.name} ${issue.key} with priority ${issue.priority?.name} has been assigned to you.
    
    Regards,
    ${issue.reporter?.displayName}
    ```
    
2.  Enter the following into the Subject template field:
    
    ```
    Issue ${issue.key} has been assigned to you.
    ```
    

Tip: For help with using the Java API see our [Introduction to Atlassian Java API](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/using-gstring-templates).
