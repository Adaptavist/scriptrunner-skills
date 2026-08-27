# Example Script Variables

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-variables
- Doc ID: doc-sr4jc-104367336
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables

An example of how to use a script variable is outlined below:

1.  Navigate to **ScriptRunner > Script Variables**. 
2.  Click **Create Script Variables** from either the previously created list or the initial landing screen. The _Create Script Variable_ screen appears:  
    ![](/sr4jc/files/latest/104367336/585008234/2/1787240554000/example+VAR.jpg)
3.  Enter a name in the **Script Variable name** field. For this example, we use EXAMPLE\_VAR.
4.  Enter a value in the **Script Variable value** field. For this example, we use `I am an example`. You can click the eye icon next to this field to make it visible or not visible, as required.
5.  Click **Save**. Once saved, a confirmation message displays, and you are automatically redirected to the Script Variables page.   
    ![](/sr4jc/files/latest/104367336/585008231/2/1787241703000/script+var.jpg) 
6.  Navigate to the **Script Console**.
7.  Click **Script Context** from the code editor, as shown below:  
    ![](/sr4jc/files/latest/104367336/585008233/1/1787240844000/script+context+sc.jpg)  
    The Script context modal appears with details of parameters/variables that are available for your scripts, including the script variable EXAMPLE\_VAR created in the previous steps. For example:  
    ![](/sr4jc/files/latest/104367336/585008232/1/1787241034000/script+context+modal.jpg)  
    
8.  Close the Script context modal and enter `println EXAMPLE_VAR` in the code editor.
9.  Click **Run**. Once complete, you will see the **Script** **Variable** **value** previously created in Step 4 display in the Logs, as shown below:  
    ![](/sr4jc/files/latest/104367336/585008230/2/1787241782000/example+logs.jpg)
    
    In this example, we referenced the saved script variable in the Script Console code editor. Saved script variables can also be referenced using the _Script Context_ button in the editors for [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs), and [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service).
