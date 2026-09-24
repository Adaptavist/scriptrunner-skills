# Using GString Templates

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-1b5b8533-99c8-4697-a08b-87414247493a-267da7670dd4cda1
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#using-gstring-templates--en

ScriptRunner allows you to write Groovy scripts with dynamically generated text using GString Templates.

You can add dynamic text in a template using the `${expression}` syntax. All editors supporting GString Templates in ScriptRunner have [Code Insight](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor), allowing you to utilize code completions, parameter hints, and Javadoc lookup.

Below, we show a simple example of how you can use GString Templates in ScriptRunner.

For example, if you want to create a _Send Custom Email_ listener, you can write the Email template and Subject template using GString Templates.

The following example is for a custom email triggering on a space created event.

1.  Enter the following into the Subject template field:
    
    ```
    New space ${event.space.name} created
    ```
    
2.  Enter the following into the Email template field:
    
    ```
    Dear ${event.user.displayName}
    A new space ${event.space.name} has been created.
    ```
