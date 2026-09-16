# All Sub-tasks Resolved Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Conditions
- Doc ID: doc-sr4js-2aed5228-54a6-4307-9590-f34e981f7445-bee0be1ebcb0b608
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#conditions--en#all-sub-tasks-resolved-condition--en

Use the _All sub-tasks must be resolved_ built-in condition to stop/hide a transition in a parent issue until all sub-tasks are set to a chosen resolution. For example, you can use this script to make sure a parent task cannot be transitioned to the _Done_ status until all sub-tasks have a resolution of _Done_.

Tip: It is important to remember that a resolution is different from a status. The resolution is typically automatically set using a post function when an issue is transitioned to a specific status. For example, when you transition an issue to the _Done_ status, the resolution typically updates to Done with a pre-generated post function. For this condition to work, you must ensure the _Resolution_ automatically sets to the required state using a post function. This post function is usually pre-generated in most workflows; see the [Jira Knowledge Base article on Resolutions](https://confluence.atlassian.com/jirakb/jira-issues-need-a-resolution-826873869.html) for more information.

## Use this condition

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition.
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select All sub-tasks must be resolved.
    
7.  Select Add.
8.  Optional: Enter a note that describes the condition.
9.  Select a resolution. This is the resolution you wish sub-tasks to have before the parent issue is permitted to transition.
10.  Select Preview to see an overview of the change.
11.  Select Update.
     
12.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow condition works.

### Additional example

If you would like to be more specific about which sub-tasks must be resolved before a parent transition is permitted, you can use a simple scripted condition. For example, check out the [Conditions tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial) page for an example where [All QA sub-tasks must be resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial#all-qa-sub-tasks-must-be-resolved-simple-scripted-condition--en).

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [Simple Scripted Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)
