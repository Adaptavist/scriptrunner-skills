# Workflows

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-ff5efcb4-53a1-4cf0-9506-a8bc743142c0-9bb82f848f27c51e
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature has partial parity in Cloud.<br>[Cloud Feature Parity documentation](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#workflow-conditions--en) |

Enhance and automate your workflows beyond Jira's native possibilities using ScriptRunner's workflow functions: [conditions](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions), [validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators), and [post functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions).

## View Configured ScriptRunner Workflow Functions

1.  Click the Cog in the top ribbon to open the _Administration_ menu and select ScriptRunner.
2.  Select Workflows from the side menu under _ScriptRunner,_ or click the Workflows tab.
    
    This window displays all configured ScriptRunner conditions, validators, and post functions. You can also view the execution history under _Performance._
    
3.  Optionally, filter your configured ScriptRunner workflow functions by project using the Applied to drop-down.

To add a new workflow function, click Create Workflow Function. For more details, see the [_Create a ScriptRunner Workflow Function_](https://docs.adaptavist.com/sr4js/latest/features/workflows#create-a-scriptrunner-workflow-function--en) section below.

## Create a ScriptRunner Workflow Function

The easiest way to create a new ScriptRunner workflow function is through the Workflows tab:

1.  Click the Create Workflow Function button from the ScriptRunner Workflows tab to open the Create Workflow Function window.
2.  Select the workflow you want to edit from the Workflows drop-down.
3.  Select the transition you want to edit from the Transitions drop-down.
4.  Select a Workflow Function Type.
5.  Click Create.
6.  Select a ScriptRunner workflow function from the list and configure it.
    
    Note: Visit the dedicated pages for each ScriptRunner workflow function for configuration information.
    
    An alternative method is to navigate to the Jira Workflows page through the Administration menu:
    
    1.  Navigate to Cog > Issues.
    2.  Select Workflows from the side menu under Workflows.
    3.  Click Edit on the workflow you wish to add or edit a workflow function.
    4.  Select a transition in the Diagram view. A list of workflow functions is displayed.
    5.  Click the function type you wish to edit/add, for example, Condition. The Transition screen shows a list of all conditions set up for this transition.
    6.  Click Add Condition on the Transition screen.
    7.  Select one of the ScriptRunner options and click Add.
        
        Note: ScriptRunner functions are denoted by \[ScriptRunner\].
