# Custom Script Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885415
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/custom-script-condition

Use the _Custom script condition_ to run an embedded script that determines whether an issue should be permitted to transition to a particular status within a workflow. This condition allows you to write Groovy scripts that can evaluate a wide range of conditions based on issue fields, workflow states, project properties, user permissions, and other contextual data. 

With the introduction of [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi), you can do what the _Custom Script Condition_ does but in fewer lines when using our [Simple Scripted Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition) built-in workflow function. We therefore recommend, where possible, to use the _Simple Scripted Condition_ over the _Custom Script Condition_. 

If you need help writing your script, check out the [Scripting tips](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/scripting-tips) page.

## Use this condition

### Condition functions

Condition functions determine if a transition should be visible for a particular issue. Jira runs condition functions frequently, it's therefore important to avoid doing any long processing in them.

To control whether a transition is permitted, you must set a variable named `passesCondition` to `true` or `false`. By default, `passesCondition` is `true`, meaning the action will be allowed unless you explicitly set it otherwise.

### Step-by-step instructions

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **Custom script condition**.  
    ![](/sr4js/files/latest/442885415/442885425/1/1758746485000/Custom_script_condition_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the condition.
9.  Enter an inline script of your choice. 
    
10.  Optional: Select **Preview**.
11.  Select **Update**.  
     
12.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     You can now test to see if this workflow condition works.
     

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [Simple Scripted Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)
