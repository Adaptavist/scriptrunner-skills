# Require Comment For Action

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-441363981
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/require-comment-for-action

Conditions can also be set based on workflow transitions or states. In the following example, we show you how to make the comment field required when an issue is moved from _Done_ to _Reopened_.

Workflow functions

If you want more information about workflow functions and ScriptRunner workflow functions, check out our [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)

1.  Make sure you know which workflow action you want to associate this behaviour to. For this example, we want to associate this behaviour with the _Reopen issue_ transition in a default Jira workflow. For example:  
    ![](/sr4js/files/latest/441363981/441363985/1/1728654961000/Add_comment_7.png)
2.  Make sure the workflow transition you want to associate this behaviour to includes a [screen](https://confluence.atlassian.com/adminjiraserver100/defining-a-screen-1442845527.html). For example:  
    ![](/sr4js/files/latest/441363981/441363989/2/1758793097000/Require_a_comment_5.png)
3.  From ScriptRunner, navigate to **Behaviours**. 
4.  Select **Create Behaviour**.
5.  Enter a name for the behaviour. In this example we enter `Require a comment when reopened`.
6.  Optional: Enter a description for the behaviour.
7.  Select **Create Mapping**.
8.  Select the project and issue type(s) to map this behaviour to. In this case we chose the **ITSM** project and **All issue types**.
9.  Select **Add Mapping** to confirm the mapping.
10.  Select **Create** to create the behaviour.  
     ![](/sr4js/files/latest/441363981/441363991/1/1728653168000/Require_a_comment_2.png)
11.  You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
     
12.  Select a **Guide workflow**. This is the workflow you want to associate this behaviour to. In this example we select the `Jira Service Management default workflow`.   
     ![](/sr4js/files/latest/441363981/441363984/1/1728655378000/Require_comment_when_reopened.png) 
13.  Scroll to the **Add Field** field, select the **Comment** field, and then select **Add**.
14.  Change the **Optional/Required** field to display **Required**.
     
15.  Select **Add new condition**. The _Add condition_ pop-up displays.
16.  Configure the condition as follows:
     1.  Select **When** for _Applicability_. 
     2.  Select **Workflow Action** for _Condition_. 
     3.  Select **Reopen issue** for _Workflow Action_.
     4.  Select **Add**.  
         ![](/sr4js/files/latest/441363981/441363987/1/1728654482000/Require_a_comment_6.png)
         
17.  Select **Save Changes**.   
     ![](/sr4js/files/latest/441363981/441363983/1/1728655921000/require_comment_when_transitioned.png) 

You can test to see if this behaviour works. The comment field will display as required when a completed issue is reopened. The field will also display a warning if a user tries to transition the issue without adding a comment.

 ![](/sr4js/files/latest/441363981/441363992/1/1728653167000/Require_a_comment_4.png)
