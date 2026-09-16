# Require Comment For Action

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours > Behaviours Examples
- Doc ID: doc-sr4js-595f930d-2678-4547-b621-6d788a566a5e-e88b3e211f5f4676
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-examples--en#require-comment-for-action--en

Conditions can also be set based on workflow transitions or states. In the following example, we show you how to make the comment field required when an issue is moved from _Done_ to _Reopened_.

Tip: Workflow functions

If you want more information about workflow functions and ScriptRunner workflow functions, check out our [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)

1.  Make sure you know which workflow action you want to associate this behaviour to.
    
    For this example, we want to associate this behaviour with the _Reopen issue_ transition in a default Jira workflow. For example:
    
2.  Make sure the workflow transition you want to associate this behaviour to includes a [screen](https://confluence.atlassian.com/adminjiraserver100/defining-a-screen-1442845527.html).
    
    For example:
    
3.  From ScriptRunner, navigate to Behaviours.
4.  Select Create Behaviour.
5.  Enter a name for the behaviour.
    
    In this example we enter `Require a comment when reopened`.
    
6.  Optional: Enter a description for the behaviour.
7.  Select Create Mapping.
8.  Select the project and issue type(s) to map this behaviour to.
    
    In this case we chose the ITSM project and All issue types.
    
9.  Select Add Mapping to confirm the mapping.
10.  Select Create to create the behaviour.
     
11.  You're taken to the Edit Behaviour screen where you can configure the behaviour further.
12.  Select a Guide workflow.
     
     This is the workflow you want to associate this behaviour to. In this example we select the `Jira Service Management default workflow`.
     
13.  Scroll to the Add Field field, select the Comment field, and then select Add.
14.  Change the Optional/Required field to display Required.
15.  Select Add new condition.
     
     The _Add condition_ pop-up displays.
     
16.  Configure the condition as follows:
     1.  Select When for _Applicability_.
     2.  Select Workflow Action for _Condition_.
     3.  Select Reopen issue for _Workflow Action_.
     4.  Select Add.
         
17.  Select Save Changes.
     

You can test to see if this behaviour works. The comment field will display as required when a completed issue is reopened. The field will also display a warning if a user tries to transition the issue without adding a comment.
