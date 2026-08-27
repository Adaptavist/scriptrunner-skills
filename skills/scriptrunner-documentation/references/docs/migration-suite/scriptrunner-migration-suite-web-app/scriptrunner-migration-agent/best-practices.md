# Best Practices

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-agent
- Doc ID: doc-sms-448135905
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/best-practices

There are many best practices for writing prompts in AI. Here are a few of our recommendations:

-   **Be specific about context:** Specify the feature you’re working on, mention if you're migrating from Data Center to Cloud, and include relevant Jira project details, field names, or workflow information
    
-   **Provide clear requirements:** State exactly what you want the script to accomplish and mention specific Jira objects you need to work with (issues, users, projects, etc.).
    
-   **Ask for complete solutions:** Request full working examples rather than just code snippets, ask for error handling and logging when appropriate, and mention if you need the code validated and tested.
    

## ✅ Effective prompts

> I need a post function script that automatically assigns issues to the project lead when they're transitioned to 'Ready for Review' status. The script should log any errors and handle cases where no project lead is set.

> Can you help me create a listener that triggers when a Story issue type is created, and automatically populates the 'Story Points' custom field with a default value of 3?

> I'm migrating from Data Center and need to convert this ComponentAccessor code to work in Cloud. Here's my current script: \[paste code\]. It should update issue labels based on priority changes.

> Can you give me a summary of what this DC script does? Here's my script: \[paste code\].

## ❌ Ineffective prompts

> Help me with Jira

Instead, write something like, "I need to create a listener that automatically assigns issues to the project lead when they're created.”

> My script doesn't work

Instead, write something like, “My listener script throws a 'Cannot cast object' error when trying to access issue.fields.customfield\_10001."

> How do I update issues?

Instead, write something like, “I need to update the 'Story Points' custom field and add a comment when an issue transitions to 'In Progress'.”

> Fix this code

Instead, write something like, “This workflow post-function should update the assignee but I'm getting a type error - here's my code: \[paste code\]”
