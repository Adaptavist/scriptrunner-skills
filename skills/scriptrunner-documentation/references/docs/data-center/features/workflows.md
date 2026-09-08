# Workflows

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-441364758
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows

![](/sr4js/files/latest/441364758/441364760/1/1750863667000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#workflow-conditions) for more details.**

Enhance and automate your workflows beyond Jira's native possibilities using ScriptRunner's workflow functions: [script conditions](https://docs.adaptavist.com/display/SR4JS/.Conditions+v6.19.0), [script validators](https://docs.adaptavist.com/display/SR4JS/.Validators+v6.19.0), and [script post functions](https://docs.adaptavist.com/display/SR4JS/.Post+Functions+v6.19.0).

## View Configured ScriptRunner Workflow Functions

1.  Click the **Cog** in the top ribbon to open the _Administration_ menu and select **ScriptRunner**.
    
2.  Select **Workflows** from the side menu under _ScriptRunner,_ or click the **Workflows** tab.  
    This window displays all configured ScriptRunner conditions, validators, and post functions. You can also view the execution history under _Performance._ 
    
3.  Optionally, filter your configured ScriptRunner workflow functions by project using the **Applied to** drop-down. 

To add a new workflow function, click **Create Workflow Function.** For more details, see the [_Create a ScriptRunner Workflow Function_](#id-.Workflowsv9.x-createawffunction) section below. 

![Image of Workflows screen](/sr4js/files/latest/441364758/441364774/1/1746704649000/Workflows_screen.png)

## Create a ScriptRunner Workflow Function

The easiest way to create a new ScriptRunner workflow function is through the **Workflows** tab:

1.  Click the **Create Workflow Function** button from the ScriptRunner **Workflows** tab to open the _Create Workflow Function window._
2.  Select the workflow you want to edit from the **Workflows** drop-down.
3.  Select the transition you want to edit from the **Transitions** drop-down.
4.  Select a **Workflow Function Type**.
5.  Click **Create.** 
6.  Select a ScriptRunner workflow function from the list and configure it. 
    
    ![](/sr4js/files/latest/441364758/441364762/1/1746704637000/create-workflow-function-window.png)
    
    Visit the dedicated pages for each ScriptRunner workflow function for configuration information.
    

An alternative method is to navigate to the Jira **Workflows** page through the _Administration_ menu:

1.  Click the **Cog** in the top ribbon to open the _Administration_ menu and select **Issues**.
    
2.  Select **Workflows** from the side menu under _Workflows_.
    
3.  Click **Edit** on the workflow you wish to add or edit a workflow function.
    
4.  Select a transition in the **Diagram** view. A list of workflow functions is displayed.
    
5.  Click the function type you wish to edit/add, for example, **Condition**.   
    The _Transition_ screen shows a list of all conditions set up for this transition.
    
6.  Click **Add Condition** on the _Transition_ screen. 
    
7.  Select one of the ScriptRunner options and click **Add**. 
    
    ScriptRunner functions are denoted by \[ScriptRunner\]_._
    
    ![](/sr4js/files/latest/441364758/441364764/1/1746704637000/workflow-function-video.gif)
