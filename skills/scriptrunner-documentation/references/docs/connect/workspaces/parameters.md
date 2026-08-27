# Parameters

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-304350337
- Source: https://docs.adaptavist.com/src/latest/workspaces/parameters

Parameters (formerly known as Environment Variables) let you separate configuration from your scripts. These values can be defined at the workspace-environment level and referenced in your code using their corresponding parameter keys. By using parameters instead of hardcoding environment-specific configuration details, you can create more maintainable and modular code.

ScriptRunner Connect also uses parameters in its templates to simplify setup and configuration.

**Environment specificity 🔎**

Each environment can have its own set of parameters. Your scripts will be injected with the appropriate parameters depending on which environment triggers the script.  
  
**Instant application 🚀**

You don't need to release and deploy to update parameters. Any changes you make are applied instantly to the environment where you made them.

## Parameters tutorial video

## The basics

Let's define the essential actions surrounding parameters.

### Create a new Variable

Click **Parameters** in the _Resource Manager_, then click **\+ Variable**:

![A screenshot of the Resource Manager, with the Parameters option and the Add Variable option highlighted.](/src/files/latest/304350337/304350340/1/1732134981000/parameters-new-variable.png)

### Save your Parameters

Once you've added or edited a parameter, click **Save** to ensure you don't lose your work:

![The Save option highlighted in the Parameters section of the Resource Manager screen.](/src/files/latest/304350337/304350339/1/1732136171000/save-parameter.png)

### Rearrange Parameters

Use the drag-and-drop option to change the position of and rearrange parameters. This feature also lets you move parameters into and out of folders.

![The drag-and-drop option for an associated parameter highlighted.](/src/files/latest/304350337/304350343/1/1732132702000/drag-variable.png)

## Reuse Parameters across multiple environments

You can assign different values to the same parameter across different environments or even use completely different sets of parameters with distinct keys.

The following example demonstrates how to have multiple environments with different values for the same parameter (using the same key). In the _Default_ environment in the previous image, the variable is set to `Hello World;` in the _Dev_ environment in the image that follows, it's set to `Hello Kitty`.

![A screenshot of the Resource Manager with the Environment and Parameter Value variables shown. ](/src/files/latest/304350337/304350338/2/1732205920000/same-variable-example.png)

## Access Parameters in your scripts

Once you have defined your parameters, you can then access them in your scripts from the `context` object, under `environment` → `vars`.

The following example demonstrates how to retrieve the `myParameter` value in the script and log it out:

```
export default async function(event: any, context: Context): Promise<void> {
	console.log('myParameter', context.environment.vars.myParameter);
}
```

If we run this script in the _Default_ environment, the value for `myParameter` is logged as `Hello World`. However, if we run the script in the `_Dev_` environment, the value is `Hello Kitty.`

**Backwards compatibility ⬅️**

To retain backwards compatibility, the access pattern did not change when the feature was renamed from `Environment Variables` to `Parameters`, hence you still can get to the parameters from `context.environment.vars.*.`

## Supported value types

You can choose from multiple value types when creating a new parameter. These value types are designed to simplify template setup by restricting the kinds of values that can be used. While the _Text_ value type is versatile and works for almost anything, you can also use more specific value types, especially when sharing the workspace with colleagues.

Here is the list of supported value types, including TypeScript types, and how each is exposed at the scripting level:

Value Type

TypeScript Type

Comment

Text

`string` 

Accepts any string value.

Password

`string` 

Accepts any string value and stores it securely. Read below how password values are protected.

Number

`number` 

Accepts any positive or negative integer or floating point number based on [IEEE754](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) standard.

Boolean

`boolean` 

Accepts `true` or `false` values.

Date

`string`  ([ISO 8601](https://en.wikipedia.org/wiki/ISO_8601))

Accepts date value.

Multiline text

`string` 

Same as `String` value type, but allows line breaks to be entered.

Single choice

`string` 

Allows multiple choices to be defined, whereas only one can be selected.

Multiple choices

`Array<string>` 

Allows multiple choices to be defined and multiple options to be selected.

List

`Array<string>` 

Allows a list of values to be defined.

Map

`Record<string, string>` 

Allows a list of key-value pairs to be defined.

### Leverage the Password value type

The _password_ value type is ideal for storing secret information you need to use in API calls, such as an API key. This type has additional security features, including:

-   Masking the input field to hide sensitive information
-   Making the value difficult to retrieve once it is entered
    

For example, if you attempt to log a password value, you will receive a placeholder like `ENV_VARIABLE_${ID}` instead of the actual value. This ensures that if you inadvertently log a password, it won't reveal the actual information—just a placeholder. The same protection applies to [HTTP logs](https://docs.adaptavist.com/src/latest/observability/http-logs): only placeholders are stored, not actual password values.

The placeholders for the password value type are replaced with the actual values when the final API call is made.

#### Contexts

You can use password value types in the following contexts when making API calls:

-   URL
-   Headers
-   Body, if the `content-type` header is set to one of the following (otherwise, the value won't get replaced):
    -   application/json
    -   application/xml
    -   application/x-www-form-urlencoded
    -   text/plain
    -   text/css
    -   text/csv
    -   text/html
    -   text/javascript
    -   text/xml

**Body default 💡**

The body `content-type` header defaults to `application/json` if no other is specified.

**Using password values with Managed APIs 🔑**

You can use password values as parameters when making API calls with Managed APIs, as Managed APIs internally use standard HTTP calls with URL, headers, and body parameters.

**New plain text content types 📝**

If you encounter a content type represented in plain text and would like it added to the list of recognised content types, please [contact the ScriptRunner Connect support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/20).

**Manipulating password value types**

Since password value types get replaced at the very last minute when making API calls, you cannot use the password value as an input to a transformation at the runtime level because what you'll be getting is the placeholder value, not the actual value. Consider storing the transformed value in the password field, such as a base64-encoded string for a basic authentication header, when possible, rather than storing the password only and then trying to calculate the base64-encoded string at runtime. If you need to transform secrets at runtime, consider using a regular text value type or store the secret in the [Record Storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) if you wish to hide it slightly more.

## Folders

You can use folders to organise your parameters. At the scripting level, parameters within a folder are exposed within an object that matches the folder's name. For example, if you have a folder named `myFolder` with a parameter called `myParameter`, you can access it as follows:

```
export default async function(event: any, context: Context): Promise<void> {
	console.log('myParameter', context.environment.vars.myFolder.myParameter);
}
```

## Use a default value

When creating a parameter, you can optionally define a default value of the same type as the regular value. Default values are used when copying parameters; the value of a new parameter will be the default value of the copied parameter. This mechanism is designed to enhance the user experience when creating a workspace from a template; however, it can also be used when sharing a workspace with colleagues.

Copying occurs in the following situations:

-   A new environment is created within the workspace.
-   A new workspace is created from a template.
-   A workspace is duplicated.

**Please note! ☝🏾**

The source environment from which the parameters are copied is always the first default environment created when the workspace is created.

## Duplicate a parameter 👥

To avoid the tedious task of recreating the same or similar parameters across environments in the workspace, we've created the ability to duplicate parameters.   
This feature is available in the _Parameters_ section of every environment.

Single environment

If your workspace contains only a single environment the _Duplicate parameter_ option will not display. 

Save changes 💾

Save changes in your workspace before attempting to duplicate a parameter.

To ensure that the latest data is being copied, parameters cannot be duplicated when there are any unsaved changes in the form.  
If you try to duplicate a parameter with unsaved changes, a dialog box will appear and ask you to cancel until you've saved or discarded your current changes. 

### Existing parameters overwritten

It can happen that a parameter with the same name as the one being duplicated already exists, in one or more targeted environment. When this occurs, we'll display a warning indicating the issue. The warning dialogue will allow you to cancel the duplication process or to overwrite your existing parameters.  
![](/src/files/latest/304350337/472514921/1/1763488987000/parameter-overwrite-dialog-box.png)

Previous parameter data will be lost

The overwriting process involves deleting all of the parameter data in the target environment. This will update all previously existing fields, including type, that are not specified in the duplicate. 

### How to duplicate a parameter:

1.  Within your desired _workspace,_ select the parameter you'd like to duplicate.
2.  Select the **Duplicate parameter** option for your desired parameter.  
    ![](/src/files/latest/304350337/472514923/1/1763488880000/select-duplicate-parameter.png)  
    The _Duplicate parameter_ dialog box appears.
3.  Select desired options to include in the duplicate: _Key, Value,_ and _Default value_.   
    
    Selection options
    
    The _Key_ field will always be selected as it is required for all parameters.  
    If _Default_ _value_ and _Value_ are selected, they will be added to the duplicate parameter in the target environment(s). If they're unselected they will be blank in the duplicate. 
    
    Additional fields
    
    The rest of the fields in the duplicated parameter, _Description_, _Required_, etc., are automatically included in the duplicate.
    
    If the duplicated parameter identifies type, _single_ _choice_ or _multiple_ _choice_, the available choices will be copied over in the duplicate, if either _Value_ or _Default_ _value_ is selected in the _Duplicate parameter_ dialogue options.
    
4.  Select desired environment(s) to copy the duplicate into. 
5.  Click **Duplicate**.  
    A success message appears.  
    ![](/src/files/latest/304350337/472514922/1/1763488944000/duplicatation-success-message.png)

### Parameters in folders

Folders cannot be duplicated directly across environments. However, parameters inside of folders can be. 

Parameters duplicated from inside folders have a slightly different execution dialogue than others. The differentiation is an additional section: _Selected parameter location_.

The options for this section are _Root level_ and _Folder_:

-   **Root level** selections ignore folder structure and allow the parameter to be copied into the root level in the target environment. 
-   **Folder** selections attempt to find a folder in each target environment that has the same name as the one in which our source parameter is located. If such a folder is found, the new parameter will be placed in that folder. If not, the folder will be created. In any case, the parent-child relationship in the target environments will be preserved.
    
    Note that folders are not duplicated in this case, meaning that the folder _Description_ is not copied over to the target environments.
    

## Use a required value

Similar to default values, the ability to mark a parameter as required is primarily intended for templates; however, it can also be useful for other purposes. Making a parameter required prevents the rest of the parameters from being saved until all required parameters are satisfied. If a parameter is unsatisfactory, a few visual indicators will appear to highlight the issue.
