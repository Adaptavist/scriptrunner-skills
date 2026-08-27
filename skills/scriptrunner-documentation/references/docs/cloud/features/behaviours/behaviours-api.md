# Behaviours API

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-151629829
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api

You can reference the functions and properties outlined below within your behaviour scripts.

## Read/update fields

### Access a field

All [supported fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#id-.BehavioursvCurrent-supportedfields) can be accessed by using `**getFieldById(fieldID)**.`

For example:

```
const theDescription = getFieldById("description")
theDescription.setName("The description name");
const theValue = "the value is " + theDescription.getValue();
logger.info(theValue);
```

### Accessing custom fields

-   Custom fields cannot be accessed by their field name and instead have to be accessed by their ID e.g customfield\_01232
    
-   The ID of the custom field can be found by either utilising the Jira Cloud REST API to make a request to the field endpoint [https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-fields/#api-rest-api-3-field-get](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-fields/#api-rest-api-3-field-get) such as [https://YOUR\_ATLASSIAN\_INSTANCE/rest/api/3/field](https://YOUR_ATLASSIAN_INSTANCE/rest/api/3/field)
    
-   When selecting a custom field as the affected field, the custom field ID will display at the top of the Create modal screen.  
    ![](/sr4jc/files/latest/151629829/206800562/1/1698827284000/Screenshot+2023-11-01+at+08.27.53.png)
    

### Access a changed field

If your script is triggered onChange you can use the getChangeField() function. This function will return an object with the same structure as `getFieldById.`

For example:

```
const changedField = getChangeField()
if(changedField.getName() == "summary") {
	logger.info("The summary has changed!");
}
```

## Available read methods

It is important to note that these methods are only accessible on the object returned by `**getFieldById**.`

The usage of the **[getValue](#id-.BehavioursAPIvCurrent-getValue)** and **[setValue](#id-.BehavioursAPIvCurrent-setValue)** methods has changed for several fields as the `displayName` property has been deprecated. The examples outlined below show how these now work. 

For the **assignee**, **userPicker** and **multiUserPicker** fields, only accountIds are returned as the displayName property is no longer available. Scripts that rely on `displayName` information will break; instead, you will now have to make a request to ``/rest/api/3/user?accountId=`$`{accountId}`` and/or ``/rest/api/3/bulk?accountId==`$`{idsToFetch.join("&accountId=")}.``

For **single** and **multiselect**, you must now use the `value` property instead of the deprecated `name` property.

### getContext

Returns the context details provided by Atlassian when a Jira or JSM behaviours script is run.

Return Type: `Object`

#### Jira

```
{
  cloudId: string;
  localId: string;
  environmentId: string;
  environmentType: string;
  moduleKey: string;
  siteUrl: string;
  appVersion: string;
  extension: {
    type: string;
    project: {
      id: string;
      key: string;
      type: string;
    };
    issueType: {
      id: string;
      name: string;
    };
    viewType: string;
    jira: {
      isNewNavigation: boolean;
    };
    location: string;
  };
  accountId: string;
  license: {
    active: boolean;
    type: string;
    supportEntitlementNumber: string | null;
    trialEndDate: string;
    subscriptionEndDate: string;
    isEvaluation: boolean;
    billingPeriod: string;
    ccpEntitlementId: string;
    ccpEntitlementSlug: string;
    capabilitySet: string | null;
  };
  timezone: string;
  locale: string;
  theme: {
    dark: string;
    light: string;
    motion: string;
    shape: string;
    spacing: string;
    typography: string;
    colorMode: string;
  };
  surfaceColor: string;
  userAccess: {
    hasAccess: boolean;
    enabled: boolean;
  };
  permissions: {
    scopes: string[];
    external: {
      fetch: {
        backend: string[];
        client: string[];
      };
      fonts: string[];
      styles: string[];
      frames: string[];
      images: string[];
      media: string[];
      scripts: string[];
    };
  };
};
```

When a behaviour is run on the Issue View inside the extension property of the context object, then there is an issue object with the structure, as shown below.

```
        issue: { 
            id: string, 
            key: string, 
        }
```

```
const context = await getContext()
```

Access the user that loaded the screen by account ID.

```
const context = await getContext()
context.accountId
```

Access the project key of the current project.

```
const context = await getContext()
context.extension.project.key
```

Access the ID of the current issue type.

```
const context = await getContext()
context.extension.issueType.id
```

Access the current issue key when on an issue view

```
const context = await getContext()
context.extension.issue.key
```

#### JSM portal create view

```
{
  cloudId: string;
  localId: string;
  environmentId: string;
  environmentType: string;
  moduleKey: string;
  siteUrl: string;
  appVersion: string;
  extension: {
    type: string;
    portal: {
      id: number;
    };
    request: {
      typeId: number;
    };
    viewType: string;
    location: string;
  };
  accountId: string;
  license: {
    active: boolean;
    type: string;
    supportEntitlementNumber: string | null;
    trialEndDate: string;
    subscriptionEndDate: string;
    isEvaluation: boolean;
    billingPeriod: string;
    ccpEntitlementId: string;
    ccpEntitlementSlug: string;
    capabilitySet: string | null;
  };
  timezone: string;
  locale: string;
  theme: {
    dark: string;
    motion: string;
    shape: string;
    spacing: string;
    colorMode: string;
  };
  surfaceColor: string;
  userAccess: {
    hasAccess: boolean;
    enabled: boolean;
  };
  permissions: {
    scopes: string[];
    external: {
      fetch: {
        backend: string[];
        client: string[];
      };
      fonts: string[];
      styles: string[];
      frames: string[];
      images: string[];
      media: string[];
      scripts: string[];
    };
  };
};
```

### getDescription

Returns the description of the field

Return type: `String`

```
getFieldById("summary").getDescription()
```

### getId

Returns the id of the field

Return type: `string`

```
getFieldById("summary").getId()
```

### getName

Returns the name of a field

Return type: `String`

```
getFieldById("summary").getName()
```

### getOptionsVisibility

Returns the options that are visible for a field.

This method can only be used after [setOptionVisiblity](#id-.BehavioursAPIvCurrent-setoptionvisibility) has been called; otherwise, it may be returned as undefined.

Return Type: `Object`

```
{options: Array<string>, isVisble: boolean}
```

**Supported Fields:**

-   Priority
-   Issue Type
-   Select List Fields
-   Multi-Select List Fields
-   Checkbox Fields

```
getFieldById("priority").getOptionsVisibility()
```

```
getFieldById("issuetype").getOptionsVisibility()
```

**Note:**  This method works for **On Change events only** and always returns undefined for On Load events.

### getType

Returns the type of the field.

Return type: `string`

```
getFieldById("summary").getType()
```

### **getValue**

Returns the value of a field. The return type depends on the field you’re updating:

Field name

Return type

Example getValue()

**Affects Versions**

`{ id: string, name: string }`

  

```
// returns Affects versions
const versions = getFieldById("versions"); 
versions.getValue();

//example return value
{id: "10001", name: "2"}
```

  

**Assignee Field**

`null | { accountId: string }`

```
const assignee = getFieldById("assignee");
assignee.getValue();

//example return value
{accountId: "dfqsw43ref"}
```

**Cascading Select**

`null | { parent: { id: string; value: string }; child: { id: string; value: string } | null }`

```
getFieldById("customfield_10035").getValue()

// example return value
Parent 1 - Child 1.1
```

**Components Field**

`{ id: string, name: string }`

```
const components = getFieldById("components");
components.getValue();

//example return value
{id: "1234", name: "Component One"}
```

**Custom Checkbox Field**

`{ id: string, value: string }[]`

```
const checkboxValue = getFieldById("customfield_02133").getValue();  


//example return value
[{"id":"10021","value":"A"},{"id":"10022","value":"B"}]
```

**Custom Date Picker Field**

`string | null`

```
const date = getFieldById("customfield_02136").getValue();  

//example return value
"2023-11-14"
```

**Custom Date Time Picker Field**

`string | null`

```
const dateTime = getFieldById("customfield_10035”).getValue();

//example return value 
"2024-03-13T15:30+03:00"
```

**Custom Multi User Picker Field**

`{ accountId: string }[]`

```
const userPicker = getFieldById("customfield_10984");
userPicker.getValue();

//example return value
[{accountId: "394urfjj9r2",},{accountId: "432-jftpwer0",},]
```

**Custom Multiple Select Field**

`{ id: string, value: string }[]`

```
const multipleSelect = getFieldById("customfield_01232");
multipleSelect.getValue();

//example return value 
[{id: "12345", value: "helloWorld",}, {id: "67890",value: "fooBar",}]
```

**Custom Number Field**

`string | null`

```
const number = getFieldById("customfield_02138").getValue();  

//example return value
100
```

**Custom Paragraph Field**

`string | ADParagraphField`

```
// string is for Plain-text editor
// Rich-text editor (ADF format)
type ParagraphField = {
	string | ADParagraphField
}
```

More details about ADF: [https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/)

**Custom Radio Buttons Field**

`string | null`

```
const radiobutons = getFieldById("customfield_02134").getValue();  

//example return value
"10021"
```

**Custom Select Field**

`null | { id: string, value: string }`

```
const singleSelect = getFieldById("customfield_01231");
singleSelect.getValue();

//example return value
{id: "12345",value: "helloWorld",}
```

**Custom Text Field**

`string`

  

**Custom URL Field**

`string | null`

```
const url = getFieldById("customfield_02135").getValue();  


//example return value
"https://www.adaptavist.com"
```

**Custom User Picker Field**

`null | { accountId: string }`

```
const userPicker = getFieldById("customfield_10984");
userPicker.getValue();

//example return value
{accountId: "394urfjj9r2",}
```

**Description**

`string | ADF`

```
// We return a string or ADF (Atlassian Doc Format), depending on your Jira configuration
type ADF = {
    version: 1,
    type: 'doc',
    content: Node[]
}
```

More details about ADF:  
[https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/)

**Due Date**

`string | null`

```
// returns due date
const dueDate = getFieldById("duedate").getValue();  

//example return value
"2024-11-05"
```

**Fix Versions Field**

`{ id: string, name: string }`

```
const fixVersions = getFieldById("fixVersions");
fixVersions.getValue();

//example return value
{id: "1234", name: "version One"}
```

**Work Type Field**

`{ id: string, name: string }`

```
const workType = getFieldById("issuetype"); 
workType.getValue();

//example return value
{id: "1234", name: "Task"}
```

**Labels**

`string[]`

  

**Original Estimate**

`number | null`

```
const originalEstimateField = getFieldById("timeoriginalestimate");
originalEstimateField.getValue();

//example return value
4 | null
```

**Parent Field**

`{ id: "10001", key: "DEMO-1000" } | null`

```
const parentField = getFieldById("parent"); 
parentField.getValue();

//example return value 
{ id: "10001", key: "DEMO-1000" } | null
```

**Priority Field**

`{ id: string, name: string, iconUrl?: string }`

```
const priority = getFieldById("priority"); 
priority.getValue();

//example return value
{id: "12345", name: "test"}
```

**Space Picker Field**

`{ projectId: string }`

```
const spacePicker = getFieldById("customfield_10001"); 
spacePicker.getValue();

//example return value
{projectId: "10899"}
```

**Reporter Field**

`null | { accountId: string }`

```
const reporter = getFieldById("reporter");
reporter.getValue();

//example return value
{accountId: "dfqsw43ref",}
```

**Status Field**

`{ id: string, name: string }`

```
// returns StatusField
const statusField = getFieldById("status"); 
statusField.getValue();

//example return value
{id: "12345", name: "test"}
```

**Summary**

`string`

```
getFieldById("summary").getValue()
```

**Target End Date**

`string | null`

```
// returns target end date
const targetEnd = getFieldById("customfield_10023").getValue();  

//example return value
"2024-11-05"
```

**Target Start Date**

`string | null`

```
// returns target start date
const targetStart = getFieldById("customfield_10022").getValue();  

//example return value
"2024-11-05"
```

### isCreateView

Returns whether or not the current view is the Create View.

Return type: `boolean`

```
if(isCreateView()){
    getFieldById("summary").setValue("This code works only on the Create View");
}
```

### isIssueView

Returns whether or not the current view is the Issue View.

Return type: `boolean`

```
if (isIssueView()){
    getFieldById("summary").setValue("This code works only on the Issue View")
}
```

### **isTransitionView**

Returns whether or not the current view is the Transition View.

Return type: `boolean`

```
if(isTransitionView()){
    const descriptionField = getFieldById("description");

    descriptionField.setValue({
        version: 1,
        type: "doc",
        content: [
            {
                type: "paragraph",
                content: [
                    {
                        type: "text",
                        text: "This code works only on the Transition View"
                    }
                ]
            }
        ]
    });
}
```

### isReadOnly

Returns whether the field has been set as read-only.

Return type: `boolean`

```
getFieldById("summary").isReadOnly()
```

### isRequired

Returns whether or not the field is required.

Return type: `boolean`

```
getFieldById("summary").isRequired()
```

### isVisible

Returns whether the field has been hidden.

Return type: `boolean`

```
getFieldById("summary").isVisible()
```

## Available write methods

It is important to note that these methods are only accessible on the object returned by **`getFieldById`** and `**getChange**.`

If you are setting a field value which is in Atlassian Doc Format, Atlassian provides a [tool](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) that allows you to generate the ADF. You can read more in Atlassian's [documentation](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/?_ga=2.116963205.265153314.1664180857-1688501704.1660815719).

The usage of the **[getValue](#id-.BehavioursAPIvCurrent-getValue)** and **[setValue](#id-.BehavioursAPIvCurrent-setValue)** methods has changed for several fields as the `displayName` property has been deprecated. The examples provided in the table below show how these now work. 

For the **assignee**, **userPicker** and **multiUserPicker** fields, only accountIds are returned as the displayName property is no longer available. Scripts that rely on `displayName` information will break; instead, you will now have to make a request to ``/rest/api/3/user?accountId=`$`{accountId}`` and/or ``/rest/api/3/bulk?accountId==`$`{idsToFetch.join("&accountId=")}.``

For **single** and **multiselect**, you must now use the `value` property instead of the deprecated `name` property.

### setDescription(desc)

Updates the field description.

Parameter: `desc`

Parameter type: `string`

```
getFieldById("summary").setDescription("A new description")
```

### setName(name)

Updates the field name.

Parameter: `name`

Parameter type: `string`

```
getFieldById("summary").setName("A new name")
```

### **setOptionVisibility(options,isVisible)**

Updates the values that are selectable in a field.

Parameter:  `options`

Parameter type: `Array<string>` - Strings of the option value IDs

Parameter:  `isVisible`

Parameter type: `boolean`

**Note:** setting `isVisible` to **true** shows the specified option values in the field only, whereas **false** hides the specified option values in the field.

```
getFieldById("priority").setOptionsVisibility(["1","2"], true)
```

```
getFieldById("issuetype").setOptionsVisibility(["12345","67890"], true)
```

### **setReadOnly(readable)**

Sets a field to read-only.

Parameter: `readable`

Parameter type: `boolean`

```
const summary = getFieldById("summary").setReadOnly(true)
```

Hidden fields

When the text (single), select list (single and multiple), checkbox, radio and number fields are set to read only but have no value in Issue View, they will be hidden.

### **setRequired(required)**

Updates a field as to whether or not it should be required.

Parameter: `required`

Parameter type: `boolean`

```
getFieldById("summary").setRequired(true)
```

### setValue(value)

Updates the field value.

Parameter: `value`

Parameter type: Depends on the field you’re updating:

Field Name

Return / Parameter Type

Example setValue()

**Affects Versions**

`(value: string[] ) // Strings of version ids`

```
getFieldById("versions").setValue(["10000","10001"])
```

**Assignee**

`(value: string | null)`

  

```
const assignee = getFieldById("assignee")assignee.setValue("5556634")
```

  

**Cascading Select**

`(value: {` `parentId: string;` `childId: string | null**;**``} | null)`

  

```
getFieldById("customfield_10054").setValue({
  parentId: "1030",
  childId: "1031"
})
```

  

**Components**

`(value: string[] ) // Strings of component Ids`

```
getFieldById("components").setValue(["12345","56789"])
```

  

**Custom Checkbox Field**

`string[]` (option IDs)

```
const checkbox = getFieldById("customfield_02133").setValue(['10021','10022'])
```

**Custom Date Picker Field**

`string` (`yyyy-mm-dd`)

```
const datePicker = getFieldById("customfield_02136").setValue('2023-11-14')
```

**Custom Multiple Select Field**

`(value: string[])`

```
const multipleSelect = getFieldById("customfield_01232")
multipleSelect.setValue(["4", "5"])
```

**Custom Multiple User Picker**

`string[]` (accountIds)

```
const multiUserPicker = getFieldById("customfield_012322")
multiUserPicker.setValue(["557058:db4467a5-32f3-48f9-be3b-687a1bc0468c", "712020:b81688df-0c5d-44cb-bc11-315f0e8e4390"])
```

**Custom Number Field**

`number`

```
const numberField = getFieldById("customfield_02138").setValue(100')
```

**Custom Paragraph Field**

`string | ADF`

```
// Plain-text editor: | type ADF = {version: 1,  type: 'doc', content: Node[]} // Rich-text editor (ADF format)//
```

[https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/)

**Custom Radio Buttons Field**

`string` (option ID)

```
const radioButtons = getFieldById("customfield_02135").setValue('10021')
```

**Custom Single Select Field**

`(id: string | null)`

```
const singleSelect = getFieldById("customfield_01231")
singleSelect.setValue("3")
```

**Custom Text Field**

`string`

  

**Custom URL Field**

`string`

```
const urlField = getFieldById("customfield_02134").setValue("https://www.adaptavist.com")
```

**Custom User Picker Field**

`string` (accountId)

```
const singleUserPicker = getFieldById("customfield_012321")
singleUserPicker.setValue("557058:db4467a5-32f3-48f9-be3b-687a1bc0468c")
```

**Description**

`string | ADF`

  

**Due Date**

`string` (`yyyy-mm-dd`)

```
const dueDate = getFieldById("duedate").setValue("2024-11-05")
```

**Fix Versions**

(value: string\[\] ) // Strings of version Ids

```
getFieldById("fixVersions").setValue(["12345","56789"])
```

**Issue Type**

( value: string | null) // String is the Issue Type ID

```
getFieldById("issuetype").setValue("12345")
```

**Labels**

`string[]`

  

**Original Estimate**

(value: number | null) 

```
getFieldById("timeoriginalestimate").setValue(4)
```

**Parent**

(id: string | null ) // String of parent Id

```
getFieldById("parent").setValue("10001")
```

**Priority**

(value: string | null)

```
const priority = getFieldById("priority")priority.setValue("2")
```

**Space Picker Field**

(projectId: string | null)

```
getFieldById("customfield_10001").setValue("10899")
```

**Reporter**

(value: string | null)

```
getFieldById("reporter").setValue("1234-3434-324234")
```

**Status**

`(transitionId: string )` `// String of transition ID`

```
getFieldById("status").setValue("10")
```

**Summary**

`string`

```
getFieldById("summary").setValue(<FieldValue>)
```

**Target End Date**

`string` (`yyyy-mm-dd`)

```
const targetEnd = getFieldById("customfield_10023").setValue("2024-11-05")
```

**Target Start Date**

`string` (`yyyy-mm-dd`)

```
const targetStart = getFieldById("customfield_10022").setValue("2024-11-05")
```

### setVisible(visible)

Updates the visibility of the field.

Parameter: `visible`

Parameter type: `boolean`

```
getFieldById("summary").setVisible(false)
```

## Behaviours on screen tabs

Demo video

You can watch our helpful [demo video](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour) highlighting how the Behaviours on Screen Tabs feature works.

It is important to note that all Behaviours on screen tabs methods are only accessible on the object returned by [`**getScreenTabById**`](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.193738413.1853332841.1732524211-477394109.1726125732#iterating-over-screen-tabs)`.`

```
type ScreenTab = {
    getId: () => string;
    isVisible: () => boolean;
    setVisible: (isVisible: boolean) => void;
    focus: () => void;
}
```

### getId

Returns the screen tab identifier.

Return type:  `string`

```
getId(): string
```

### isVisible

Returns `true` if the tab is currently visible. Returns `false` otherwise.

Return type:  `boolean`

```
isVisible(): boolean
```

### setVisible

Changes tab visibility.

Return type:  `void`

```
setVisible(value: boolean): ScreenTabAPI

tab.setVisible(false);
```

Do not hide in-focus tabs

Always ensure that you are not hiding the tab currently in focus. Doing so means your UIM won't be applied and the `onError` callback will receive a S`CREENTABS_VALIDATION_FAILED` error.

### focus

Switches the focus to a given screen tab. Automatically puts other visible tabs out of focus.

Return type:  `void`

```
focus(): ScreenTabAPI

tab.focus();
```

  

The screen tab setter methods are grouped and applied after the completion of other Behaviours that run `on load` or `on change`. This means that reading the values using the getter methods will always return the screen tab’s initial state.

You can refer to Atlassian's [UI Modifications documentation](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#querying-screen-tabs) for more details about screen tabs.

## Make REST requests

You can use `makeRequest` to hit the Jira Cloud REST API.

Parameters:

url: string of the rest endpoint

requestOptions: Optional request options of type [RequestInit | typescript - v3.7.7](https://microsoft.github.io/PowerBI-JavaScript/interfaces/_node_modules_typedoc_node_modules_typescript_lib_lib_dom_d_.requestinit.html)

Return type: Promise<{status: number, body: JSON }>

For example:

```
const res = await makeRequest("/rest/api/2/myself");
if(res.body.accountId == "the accountId") {
logger.info("User is bob");
}
```

Some Jira REST APIs are not supported on Atlassian Forge and will, therefore, not work on the Behaviours feature. For example, requests with OAuth2 permission scopes generally work on Forge. Where this scope is absent, we expect that the API endpoint is not supported on Forge.

You can make a POST request that specifies request options and headers with the `makeRequest` method. You can also make other types of REST requests, including PUT or POST. The example below shows how to make a POST request to the Jira expression API to test if an issue has more than 25 characters in the description and if so, to set some text in the summary field.

```
const body = `{
    "expression": "issue.description.plainText.length >25",
    "context": {
        "issue": {
            "key": "DEMO-1" // Specify the Issue key to test agains
        },
        "project": {
            "key": "DEMO" // Specify the project key here for the project of the issue being tested against
        }
    }
}`;
 
const res = await makeRequest("/rest/api/3/expression/eval?expand=meta.complexity", {
method: "POST",
headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  },
body: body
});
 
if(res.body.value === false){
    getFieldById("summary").setValue("Description field has less than 25 characters");
}else{
    getFieldById("summary").setValue("Description field has more than 25 characters");
}
```

## Logs

A logger is available, which will allow admins to view logs on the log page. This can be accessed by using the logger object.

Using the logger allows you to read the logs from your scripts inside the [ScriptRunner Logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs) page.

For example:

`[logger.info](http://logger.info)("hello world");`

Available functions - each method takes a string parameter:

-   warn(msg)
    
-   debug(msg)
    
-   info(msg)
    
-   trace(msg)
