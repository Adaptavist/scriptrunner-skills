# Custom Validators

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885621
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/custom-validators

Use the _Custom script validator_ to run an embedded script that determines whether an issue should be permitted to transition to a particular status within a workflow. This validator allows you to write Groovy scripts that can evaluate a wide range of conditions based on issue fields, workflow states, project properties, user permissions, and other contextual data. 

With the introduction of [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi), you can do what the _Custom script validator_ does but in fewer lines when using our [Simple Scripted Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators) built-in workflow function. We therefore recommend using the _Simple scripted validator_ over the _Custom script validator_ where possible.

If you need help writing your script, check out the [Scripting tips](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/scripting-tips) page.

## Use this validator

### Validator exceptions

You can use the `InvalidInputException` to block a workflow transition if certain validation criteria are not met. This exception can also be used to provide feedback to the user about what needs to be corrected before the transition can proceed.

The [Simple Scripted Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators) has a UI where you specify what field to apply the error message to. We recommend using the _Simple scripted validator_ over the _Custom script validator_ where possible.

#### Set a specific field in error

When you want to indicate that there's an issue with a particular field, you can throw an `InvalidInputException` and specify the field and the error message. For example:

```
import com.opensymphony.workflow.InvalidInputException

throw new InvalidInputException("resolution", "Resolution must not be fixed if not specifying a fix-version")
```

This constructor of `InvalidInputException` takes two arguments; the ID of the field that has the error and the error message to display. When the exception is thrown, Jira will prevent the transition and display the specified error message next to the `resolution` field on the transition screen:

![Image example of the error](/sr4js/files/latest/442885621/442885628/1/1758746500000/Error_1.png)

#### Apply a general error message

If the error is not specific to a single field, you can throw an `InvalidInputException` with just an error message:  

```
throw new InvalidInputException("Some combination of multiple fields are in error")
```

In this case, the error message will be displayed at the top of the transition screen or as a general error message, not associated with any particular field.

![Image example of the error](/sr4js/files/latest/442885621/442885627/1/1758746500000/Error_2.png)

### Step-by-step instructions

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Validators.  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Custom script validator**.  
    ![Image of custom script validator selected](/sr4js/files/latest/442885621/442885633/1/1758746501000/Custom_script_validator_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the validator. This is for your own reference. 
9.  Enter an inline script of your choice. 
    
10.  Optional: Select **Preview**.
11.  Select **Update**.  
     
12.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     You can now test to see if this workflow validator works.
     

## Example

### Require _Fix Version_ if the _Resolution_ is _Fixed_

You can use the following script to require the user to enter at least one _F__ix Version_ if the _Resolution_ is _Fixed_:

```
import com.opensymphony.workflow.InvalidInputException

if (issue.resolution.name == "Fixed" && !issue.fixVersions) {
    throw new InvalidInputException("fixVersions",
        "Fix Version/s is required when specifying Resolution of 'Fixed'")
}
```

![Image example of the error](/sr4js/files/latest/442885621/442885624/1/1758746500000/Error+3.png)

This example is easier using [Simple Scripted Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators). As stated previously, we recommend using the _Simple scripted validator_ over the _Custom script validator_.

  

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [Simple Scripted Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators)
