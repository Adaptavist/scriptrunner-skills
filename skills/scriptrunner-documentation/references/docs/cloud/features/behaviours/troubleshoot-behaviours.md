# Troubleshoot Behaviours

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-266699303
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/troubleshoot-behaviours

Behaviours are built on the [UI Modifications API](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/) provided by Atlassian. Described below are some of the common errors that can occur as a result of using that API for the Behaviours feature.

If your Jira instance is using IP allow lists, you need to expand them to include the [Atlassian Forge IP address range](https://ip-ranges.atlassian.com/) and all AWS IP ranges for your region. For more details, refer to Atlassian's [IP addresses and domains for Atlassian cloud products](https://support.atlassian.com/organization-administration/docs/ip-addresses-and-domains-for-atlassian-cloud-products/) and [AWS IP Ranges](https://ip-ranges.amazonaws.com/ip-ranges.json). 

ADF tool

If you are setting a field value which is in the **Atlassian Doc Format**, you can use the [ADF builder tool](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) provided by Atlassian and refer to their [documentation](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/?_ga=2.116963205.265153314.1664180857-1688501704.1660815719) for more details.

Behaviour script not running

Scripting language

Ensure you are using [Javascript](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) or Typescript within your script, not Groovy**.** Refer to [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) for more details on our scripts.

We recommend adding logging to the first line of your script if you are using a [supported product](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) and space type. For example

```
logger.info(“Debugging : Script for behaviour XXX is running”)
```

You should verify the following:

-   Check the [behaviour](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs) logs for the logging line once you have tried to initiate your behaviour. If the logging line is output, the script is initiating, so it's most likely the case that you have an issue with the contents of your script. 
-   Ensure the **field types** you’re using in your script are currently supported in our [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products).
-   Ensure the **view** you're testing the behaviour on is currently supported in our [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products)..
-   Check that you're using the correct [behaviour API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) methods and syntax for Cloud. If you are [migrating from Server/DC](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist), the methods are different**.**

If you have checked the above and believe your script is correct, please contact the [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27) team, providing a copy of the script for further assistance. 

**_Please note that our Support SLA does not cover custom scripting, including converting Server/DC scripts to the Cloud. Should you require assistance with this, please contact our_ [_Development Services_](https://www.adaptavist.com/solutions/scripting-as-a-service) _team__._** 

## Field data not changing on change of work type or space

If you set a default `Description` or default field values based on the work type, you may find that these values remain when changing from the applicable work type to a different work type. The same is true when changing to a different space. This is a native Jira feature to prevent accidental data loss and is _not_ enforced by ScriptRunner. 

As [REST APIs v3](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#version) uses the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/) (ADF) for fields like `Comments`, `Description`, `Environment` and `Text Field (multi-line)`, you cannot clear the `Description` field using plain text methods like `getFieldById("description").setValue("")` or `getFieldById("description").setValue(null)`.

Instead, you’ll need to set or clear the field using the [ADF builder](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) and generate the required ADF format. For example, if you enter and then remove the content in the builder, it will show you the ADF structure for an empty field.

Here’s an example of how to clear the `Description` field using an ADF body, which you may find helpful as a reference:

```
// Clear the Description field
getFieldById("description").setValue({
    "version": 1,
    "type": "doc",
    "content": []
})
```

You may also find mapping your Behaviours to all spaces or all work types helpful. Additionally, you may need to add a condition to check the space key or work type and then update or clear the `Description` field.

Atlassian's [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira is being permanently rolled out in **April 2025**. As a consequence, how your Jira expressions ([conditions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/conditions) and [validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/validators)) work will change. Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) section for more information.

## Incorrect value type error

A common error that can occur within the Behaviours feature happens when you set the wrong value type. The result of this type of error means that all changes made in the UI do not take effect, and in turn, any behaviours that have been configured on other fields also do not run.

If you have a script that uses the **[setValue()](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#id-.BehavioursAPIvCurrent-setValue)** method and the field's value is set using the wrong data type, then you will see an error message displayed.

In this instance, you will see the error message appear on the **Create Issue** screen when a behaviours script fails to run, as shown below:

![](/sr4jc/files/latest/266699303/266699305/1/1718976657000/Screenshot+2022-10-20+at+11.59.31.png)

**Resolution:**

To resolve this error, ensure that you set the correct value type for the affected field. Review the **Behaviours Scripts** mapped to the affected work type by navigating to **Behaviours** > **Behaviours Scripts** > **Affected field** and then select **Edit** from the **Actions** ellipsis. 

Check to ensure that the correct value for the field is set. The value types associated with each field are described on the [Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) page.

If you have set the wrong value type you will see a code linting error in your script. This highlights that the value being set is incorrect when writing your code, as shown below.

![](/sr4jc/files/latest/266699303/266699306/1/1718976657000/troubleshoot.jpg)

It's important to note that if you are setting the **Description** field, you will _not_ see a warning if you set a string value and the **Description** field is using a **Wiki Text Renderer** (you can also set this field to use a **Plain Text Renderer** in the field configuration). In this case, we advise you to check the type configured for the **Description** field and set the value to Atlassian Document Format for a **Wiki Text Renderer** or a string for a **Plain Text Renderer**.

## Dynamic usage of affected field

A common error that can occur when using ScriptRunner for Jira Cloud Behaviours is when users try to create dynamic scripts like the example below, and this causes the Behaviours script to fail:

```
let variable = "banana";
let fieldId = null;
if (variable == "banana") {
 fieldId = "customfield_10185"; //Number select list
}
 else if (variable == "apple") {
 fieldId = "customfield_10038"; //select list field
}
console.log("variable"+variable)
console.log("fieldId"+fieldId)

const field = getFieldById(fieldId);
field.setRequired(true);
```

The Behaviours feature does not support dynamically selecting the **Affected Field** within the script. The issue in the example script above is the dynamic usage of the `getFieldById` method. Due to Atlassian's constraints, we must automatically calculate and pass the affected fields based on the script. However, as the script is dynamic, our parser cannot identify which fields are affected.

The script needs to use the field name explicitly:

```
getFieldById("customfield_10185").setRequired(true);
```

Instead of:

```
const field = getFieldById(fieldId);
field.setRequired(true);
```

* * *

## Related content

-   See our [Example Scripts](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/example-behaviour-scripts) for Behaviours.
-   [Behaviours Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations).
-   [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products).
