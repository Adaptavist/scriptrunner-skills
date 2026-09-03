# Vendors API Example Plugin

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > vendors-api
- Doc ID: doc-sr4js-442888203
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api/vendors-api-example-plugin

This example demonstrates how to integrate a Jira custom field with the Behaviours API. You can download the source code from [GitHub](https://github.com/scriptrunnerhq/vendors-api-example). You'll also need the latest version of ScriptRunner for Jira (8.14.0 or above) for the integration to work.

There are three stages to working with this example plugin:

-   [Compile the example plugin](#id-.VendorsAPIExamplePluginv9.x-compilation)
-   [Configure a custom field](#id-.VendorsAPIExamplePluginv9.x-configuration)
-   [Test](#id-.VendorsAPIExamplePluginv9.x-testing)

## Compile the example plugin

1.  Run `atlas-mvn` `package` at the root of the project.  
    This step provides a plugin JAR file in the `backend`/`target` directory.
2.  Install the provided JAR file in your local Jira instance.
    

Troubleshooting

If the above steps do not work, do `npm install` and `npm run build` in the `/frontend` folder **before** you run `atlas-mvn package` at the root of the project. This steps makes sure the latest frontend code is bundled in the .jar.

## Configure a custom field

1.  In your local Jira instance, go to **Issues > Custom fields**_._
2.  Select **Add a custom field**.
3.  Select the **SR Vendors API Select Example** or **SR Vendors API Example**, and name it `Vendors API`.
4.  Add the new custom field to a chosen project screen. You can now access the field in the **Issue Create** modal.

## Test

When our custom field is visible on the _Issue Create_ modal, we can configure _Behaviours_ to test the implementation.

1.  Navigate to the ScriptRunner **Behaviours** page and configure the new Behaviour.
    
2.  Map the Behaviour to **All Issue Projects** and **All Issue Types**. 
    

### **Testing the _setting_ value**

To test the _setting_ field value, we'll use an **Initialiser** script.

1.  Navigate to the ScriptRunner **Behaviours** page and configure the new Behaviour.
    
2.  Name the Behaviour `Test setting value`.
3.  Map the Behaviour to **All Issue Projects** and **All Issue Types**. 
    
4.  Select **Create Script** under **Initialiser** and add the following script:  
    
    ```
getFieldByName('Vendors API').setFormValue('value from Behaviour initialiser')
```
    
5.  **Save** the Behaviour. 
6.  Open the **Create Issue** modal and verify that the initial value for the field was set. 

### **Testing the _getting_ value**

To test the _getting_ value, we’ll get the value from our custom field and set it as an issue description when _Summary_ is edited. To achieve this, we need to add the _Summary_ field to our Behaviour and key in a script:

1.  Navigate to the ScriptRunner **Behaviours** page and configure the new Behaviour.
    
2.  Name the Behaviour `Test getting value`.
3.  Map the Behaviour to **All Issue Projects** and **All Issue Types**. 
    
4.  Under **Add Field**, select **Summary**. 
5.  Select **Add**. 
6.  Select **Create Script** and add the following script:  
    
    ```
def fieldValue = getFieldByName('Vendors API').getFormValue()

getFieldByName('Description').setFormValue(fieldValue)
```
    
7.  Open the **Create Issue** modal.
8.  Change the value of **Vendors API** field, then change the value of the **Summary** field.  
    Observe how **Description** was also set.

### **Testing handling user changes**

Test handling user change by adding a Behaviour to the **Vendors API** field:

1.  Navigate to the ScriptRunner **Behaviours** page and configure the new Behaviour.
    
2.  Name the Behaviour `Test handling user changes`.
3.  Map the Behaviour to **All Issue Projects** and **All Issue Types**. 
    
4.  Under **Add Field**, select **Vendors API**. 
5.  Select **Add**. 
6.  Select **Create Script** and add the following script:  
    
    ```
def userValue = getFieldByName('Vendors API').getFormValue()

getFieldByName('Description').setFormValue("User value: ${userValue}")
```
    
7.  Open the **Create Issue** modal.
8.  Change the value of **Vendors API** field.  
    Observe how **Description** was also changed.

### Testing read-only status

Test the read-only status by changing the script for the **Summary** field in the **[Test getting value](#id-.VendorsAPIExamplePluginv9.x-getting-value)** Behaviour:

1.  Navigate to the ScriptRunner **Behaviours** page.
    
2.  Map the Behaviour to **All Issue Projects** and **All Issue Types**. 
    
3.  Locate the **Test getting value** Behaviour and select **Edit**. 
4.  Update the **Summary** field script to the following:  
    
    ```
def summaryValue = getFieldByName('Summary').getFormValue()

getFieldByName('Vendors API').setReadOnly(summaryValue == 'read-only')
```
    
5.  Open the **Create Issue** modal.
6.  Type `read-only` into the issue **Summary** field.  
    Observe that the **Vendors API** field becomes read-only. If any other value is entered into the **Summary** field, observe that the **Vendors API** field can still be modified.
