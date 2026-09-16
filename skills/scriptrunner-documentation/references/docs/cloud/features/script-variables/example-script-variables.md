# Example Script Variables

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Script Variables
- Doc ID: doc-sr4jc-73031480-8ed7-4fcc-aea5-23eb05be548e-1f5cc9a52ebcbc7b
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-variables#example-script-variables--en

An example of how to use a script variable is outlined below:

1.  Navigate to ScriptRunner > Script Variables.
2.  Click Create Script Variables from either the previously created list or the initial landing screen.
    
    The _Create Script Variable_ screen appears:
    
3.  Enter a name in the Script Variable name field. For this example, we use `EXAMPLE_VAR`.
4.  Enter a password in the Script Variable value field. For this example, we use `I am an example`. You can click the eye icon next to this field to make it visible or not visible, as required.
5.  Click Save.
    
    Once saved, a confirmation message displays, and you are automatically redirected to the _Script Variables_ page, as shown in the example below:
    
6.  Navigate to the Script Console.
7.  Click Script Context from the code editor, as shown below:
    
    The _Script context_ modal appears with details of parameters/variables that are available for your scripts, including the script variable `EXAMPLE_VAR` created in the previous steps. For example:
    
8.  Close the _Script context_ modal and enter `println EXAMPLE_VAR` in the code editor.
9.  Click Run. Once complete, you will see the Script Variable value previously created in Step 4 display in the _Logs_, as shown below.
    
    Tip: In this example, we referenced the saved script variable in the _Script Console_ code editor. Saved script variables can also be referenced using the Script Context button in the editors for [Script Listeners](../script-listeners.md), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](../scheduled-jobs.md), and [Escalation Service](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita).
