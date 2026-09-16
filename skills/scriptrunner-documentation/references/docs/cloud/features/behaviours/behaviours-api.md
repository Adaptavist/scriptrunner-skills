# Behaviours API

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Behaviours
- Doc ID: doc-sr4jc-4a7c8b49-f594-4c22-889e-b4f6c4c6a821-643ce848d143adb7
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours#behaviours-api--en

You can reference the functions and properties outlined below within your behaviour scripts.

## Read/update fields

### Access a field

All [supported fields](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) can be accessed by using `getFieldById(fieldID).`

For example:

```
const theDescription = getFieldById("description")
theDescription.setName("The description name");
const theValue = "the value is " + theDescription.getValue();
logger.info(theValue);
```

### Accessing custom fields

-   Custom fields cannot be accessed by their field name and instead have to be accessed by their ID e.g `customfield_01232`
-   The ID of the custom field can be found by either utilising the Jira Cloud REST API to make a request to the field endpoint [https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-fields/#api-rest-api-3-field-get](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-fields/#api-rest-api-3-field-get) such as [https://YOUR\_ATLASSIAN\_INSTANCE/rest/api/3/field](https://your_atlassian_instance/rest/api/3/field)
-   When selecting a custom field as the affected field, the custom field ID will display at the top of the Create modal screen.

### Access a changed field

If your script is triggered onChange you can use the `getChangeField()` function. This function will return an object with the same structure as `getFieldById.`

For example:

```
const changedField = getChangeField()
if(changedField.getName() == "summary") {
    logger.info("The summary has changed!");
}
```

## Available read methods

It is important to note that these methods are only accessible on the object returned by `getFieldById`.

Note: The usage of the [getValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) and [setValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) methods has changed for several fields as the `displayName` property has been deprecated. The examples outlined below show how these now work.

For the assignee, userPicker and multiUserPicker fields, only accountIds are returned as the displayName property is no longer available. Scripts that rely on `displayName` information will break; instead, you will now have to make a request to `/rest/api/3/user?accountId=` $ `{accountId}` and/or `/rest/api/3/bulk?accountId==` $ `{idsToFetch.join("&accountId=")}.`

For single and multiselect, you must now use the `value` property instead of the deprecated `name` property.

### getContext

Returns the context details provided by Atlassian when a Jira or JSM behaviours script is run.

Return Type: `Object`

Jira

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
}
```

Note: When a behaviour is run on the Issue View inside the extension property of the context object, then there is an issue object with the structure, as shown below.

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

JSM portal create view

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
}
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

This method can only be used after [setOptionVisiblity](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#setoptionvisibility-options-isvisible--en) has been called; otherwise, it may be returned as undefined.

Return Type: `Object`

```
{options: Array<string>, isVisble: boolean}
```

Supported Fields:

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

Note: This method works for On Change events only and always returns undefined for On Load events.

### getType

Returns the type of the field.

Return type: `string`

```
getFieldById("summary").getType()
```

### getValue

Returns the value of a field. The return type depends on the field you're updating:

<table class="table" id="getvalue--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="getvalue--en__generated-table-id-1__entry__1">Field name</th><th class="entry" id="getvalue--en__generated-table-id-1__entry__2">Return type</th><th class="entry" id="getvalue--en__generated-table-id-1__entry__3">Example getValue()</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Affects Versions</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// returns Affects versions&#10;const versions = getFieldById("versions"); &#10;versions.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "10001", name: "2"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Assignee Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">null | { accountId: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const assignee = getFieldById("assignee");&#10;assignee.getValue();&#10;&nbsp;&#10;//example return value&#10;{accountId: "dfqsw43ref"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Cascading Select</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">null | { parent: { id: string; value: string }; child: { id: string; value: string } | null }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("customfield_10035").getValue()&#10;&nbsp;&#10;// example return value&#10;Parent 1 - Child 1.1</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Components Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const components = getFieldById("components");&#10;components.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "1234", name: "Component One"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Checkbox Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, value: string }[]</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const checkboxValue = getFieldById("customfield_02133").getValue();  &#10;&nbsp;&#10;&nbsp;&#10;//example return value&#10;[{"id":"10021","value":"A"},{"id":"10022","value":"B"}]</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Date Picker Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const date = getFieldById("customfield_02136").getValue();  &#10;&nbsp;&#10;//example return value&#10;"2023-11-14"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Date Time Picker Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const dateTime = getFieldById("customfield_10035”).getValue();&#10;&nbsp;&#10;//example return value &#10;"2024-03-13T15:30+03:00"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Multi User Picker Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ accountId: string }[]</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const userPicker = getFieldById("customfield_10984");&#10;userPicker.getValue();&#10;&nbsp;&#10;//example return value&#10;[{accountId: "394urfjj9r2",},{accountId: "432-jftpwer0",},]</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Multiple Select Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, value: string }[]</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const multipleSelect = getFieldById("customfield_01232");&#10;multipleSelect.getValue();&#10;&nbsp;&#10;//example return value &#10;[{id: "12345", value: "helloWorld",}, {id: "67890",value: "fooBar",}] </code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Number Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const number = getFieldById("customfield_02138").getValue();  &#10;&nbsp;&#10;//example return value&#10;100</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Paragraph Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | ADParagraphField</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// string is for Plain-text editor&#10;// Rich-text editor (ADF format)&#10;type ParagraphField = {&#10;    string | ADParagraphField&#10;}</code></pre>&#10;                <p class="p">More details about ADF: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/" target="_blank">https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/</a>&#10;                </p>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Radio Buttons Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const radiobutons = getFieldById("customfield_02134").getValue();  &#10;&nbsp;&#10;//example return value&#10;"10021"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Select Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">null | { id: string, value: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const singleSelect = getFieldById("customfield_01231");&#10;singleSelect.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "12345",value: "helloWorld",} </code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Text Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 "></td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom URL Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const url = getFieldById("customfield_02135").getValue();  &#10;&nbsp;&#10;&nbsp;&#10;//example return value&#10;"https://www.adaptavist.com"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom User Picker Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">null | { accountId: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const userPicker = getFieldById("customfield_10984");&#10;userPicker.getValue();&#10;&nbsp;&#10;//example return value&#10;{accountId: "394urfjj9r2",}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Description</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | ADF</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// We return a string or ADF (Atlassian Doc Format), depending on your Jira configuration&#10;type ADF = {&#10;    version: 1,&#10;    type: 'doc',&#10;    content: Node[]&#10;}</code></pre>&#10;                <p class="p">More details about ADF: <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/" target="_blank">https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/</a>&#10;                </p>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Due Date</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// returns due date&#10;const dueDate = getFieldById("duedate").getValue();  &#10;&nbsp;&#10;//example return value&#10;"2024-11-05"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Fix Versions Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const fixVersions = getFieldById("fixVersions");&#10;fixVersions.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "1234", name: "version One"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Work Type Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const workType = getFieldById("issuetype"); &#10;workType.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "1234", name: "Task"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Labels</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string[]</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 "></td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Original Estimate</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">number | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const originalEstimateField = getFieldById("timeoriginalestimate");&#10;originalEstimateField.getValue();&#10;&nbsp;&#10;//example return value&#10;4 | null</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Parent Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: "10001", key: "DEMO-1000" } | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const parentField = getFieldById("parent"); &#10;parentField.getValue();&#10;&nbsp;&#10;//example return value &#10;{ id: "10001", key: "DEMO-1000" } | null</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Priority Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string, iconUrl?: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const priority = getFieldById("priority"); &#10;priority.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "12345", name: "test"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Space Picker Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ projectId: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const spacePicker = getFieldById("customfield_10001"); &#10;spacePicker.getValue();&#10;&nbsp;&#10;//example return value&#10;{projectId: "10899"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Reporter Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">null | { accountId: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const reporter = getFieldById("reporter");&#10;reporter.getValue();&#10;&nbsp;&#10;//example return value&#10;{accountId: "dfqsw43ref",}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Status Field</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">{ id: string, name: string }</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// returns StatusField&#10;const statusField = getFieldById("status"); &#10;statusField.getValue();&#10;&nbsp;&#10;//example return value&#10;{id: "12345", name: "test"}</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Summary</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("summary").getValue()</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Target End Date</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// returns target end date&#10;const targetEnd = getFieldById("customfield_10023").getValue();  &#10;&nbsp;&#10;//example return value&#10;"2024-11-05"</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Target Start Date</span>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | null</code>&#10;              </td><td class="entry" headers="getvalue--en__generated-table-id-1__entry__1 getvalue--en__generated-table-id-1__entry__2 getvalue--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// returns target start date&#10;const targetStart = getFieldById("customfield_10022").getValue();  &#10;&nbsp;&#10;//example return value&#10;"2024-11-05"</code></pre>&#10;              </td></tr></tbody></table>

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

### isTransitionView

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

It is important to note that these methods are only accessible on the object returned by `getFieldById` and `getChange`.

Note: If you are setting a field value which is in Atlassian Doc Format, Atlassian provides a [tool](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) that allows you to generate the ADF. You can read more in Atlassian's [documentation](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/?_ga=2.116963205.265153314.1664180857-1688501704.1660815719).

Note: The usage of the [getValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#getvalue--en) and [setValue](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api#setvalue-value--en) methods has changed for several fields as the `displayName` property has been deprecated. The examples provided in the table below show how these now work.

For the assignee, userPicker and multiUserPicker fields, only accountIds are returned as the displayName property is no longer available. Scripts that rely on `displayName` information will break; instead, you will now have to make a request to `/rest/api/3/user?accountId=` $ `{accountId}` and/or `/rest/api/3/bulk?accountId==` $ `{idsToFetch.join("&accountId=")}`.

For single and multiselect, you must now use the `value` property instead of the deprecated `name` property.

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

### setOptionVisibility(options,isVisible)

Updates the values that are selectable in a field.

Parameter: `options`

Parameter type: `Array<string>` - Strings of the option value IDs

Parameter: `isVisible`

Parameter type: `boolean`

Note: setting `isVisible` to true shows the specified option values in the field only, whereas false hides the specified option values in the field.

```
getFieldById("priority").setOptionsVisibility(["1","2"], true)
```

 

```
getFieldById("issuetype").setOptionsVisibility(["12345","67890"], true)
```

### setReadOnly(readable)

Sets a field to read-only.

Parameter: `readable`

Parameter type: `boolean`

```
const summary = getFieldById("summary").setReadOnly(true)
```

Note: Hidden Fields

When the text (single), select list (single and multiple), checkbox, radio and number fields are set to read only but have no value in Issue View, they will be hidden.

### setRequired(required)

Updates a field as to whether or not it should be required.

Parameter: `required`

Parameter type: `boolean`

```
getFieldById("summary").setRequired(true)
```

### setValue(value)

Updates the field value.

Parameter: `value`

Parameter type: Depends on the field you're updating:

<table class="table" id="setvalue-value--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="setvalue-value--en__generated-table-id-1__entry__1">Field Name</th><th class="entry" id="setvalue-value--en__generated-table-id-1__entry__2">Return / Parameter Type</th><th class="entry" id="setvalue-value--en__generated-table-id-1__entry__3">Example setValue()</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Affects Versions</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(value: string[] ) // Strings of version ids</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("versions").setValue(["10000","10001"])</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Assignee</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(value: string | null)</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const assignee = getFieldById("assignee")assignee.setValue("5556634")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Cascading Select</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">&#10;                  (value: { parentId: string; childId: string | null <span class="ph b">;</span> } | null)&#10;                </code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("customfield_10054").setValue({&#10;  parentId: "1030",&#10;  childId: "1031"&#10;})</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Components</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(value: string[] ) // Strings of component Ids</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("components").setValue(["12345","56789"])</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Checkbox Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string[]</code> (option IDs)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const checkbox = getFieldById("customfield_02133").setValue(['10021','10022'])</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Date Picker Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> ( <code class="ph codeph">yyyy-mm-dd</code>)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const datePicker = getFieldById("customfield_02136").setValue('2023-11-14')</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Multiple Select Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(value: string[])</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const multipleSelect = getFieldById("customfield_01232")&#10;multipleSelect.setValue(["4", "5"])</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Multiple User Picker</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string[]</code> (accountIds)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const multiUserPicker = getFieldById("customfield_012322")&#10;multiUserPicker.setValue(["557058:db4467a5-32f3-48f9-be3b-687a1bc0468c", "712020:b81688df-0c5d-44cb-bc11-315f0e8e4390"])</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Number Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">number</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const numberField = getFieldById("customfield_02138").setValue(100')</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Paragraph Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | ADF</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>// Plain-text editor: | type ADF = {version: 1,  type: 'doc', content: Node[]} // Rich-text editor (ADF format)//</code></pre>&#10;                <a class="xref j-external-link" href="https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/" target="_blank">https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/</a>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Radio Buttons Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> (option ID)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const radioButtons = getFieldById("customfield_02135").setValue('10021')</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Single Select Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(id: string | null)</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const singleSelect = getFieldById("customfield_01231")&#10;singleSelect.setValue("3")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom Text Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 "></td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom URL Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const urlField = getFieldById("customfield_02134").setValue("https://www.adaptavist.com")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Custom User Picker Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> (accountId)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const singleUserPicker = getFieldById("customfield_012321")&#10;singleUserPicker.setValue("557058:db4467a5-32f3-48f9-be3b-687a1bc0468c")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Description</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string | ADF</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 "></td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Due Date</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> ( <code class="ph codeph">yyyy-mm-dd</code>)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const dueDate = getFieldById("duedate").setValue("2024-11-05")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Fix Versions</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(value: string[] ) // Strings of version Ids</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("fixVersions").setValue(["12345","56789"]) </code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Issue Type</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">( value: string | null) // String is the Issue Type ID</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("issuetype").setValue("12345")   </code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Labels</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string[]</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 "></td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Original Estimate</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(value: number | null)</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("timeoriginalestimate").setValue(4)</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Parent</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(id: string | null ) // String of parent Id</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("parent").setValue("10001")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Priority</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(value: string | null)</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const priority = getFieldById("priority")priority.setValue("2")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Space Picker Field</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(projectId: string | null)</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("customfield_10001").setValue("10899")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Reporter</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">(value: string | null)</td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("reporter").setValue("1234-3434-324234") </code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Status</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">(transitionId: string )</code>&#10;                <code class="ph codeph">// String of transition ID</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("status").setValue("10")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Summary</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>getFieldById("summary").setValue(&lt;FieldValue&gt;)</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Target End Date</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> ( <code class="ph codeph">yyyy-mm-dd</code>)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const targetEnd = getFieldById("customfield_10023").setValue("2024-11-05")</code></pre>&#10;              </td></tr><tr class="row"><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <span class="ph b">Target Start Date</span>&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <code class="ph codeph">string</code> ( <code class="ph codeph">yyyy-mm-dd</code>)&#10;              </td><td class="entry" headers="setvalue-value--en__generated-table-id-1__entry__1 setvalue-value--en__generated-table-id-1__entry__2 setvalue-value--en__generated-table-id-1__entry__3 ">&#10;                <pre class="pre codeblock"><code>const targetStart = getFieldById("customfield_10022").setValue("2024-11-05")</code></pre>&#10;              </td></tr></tbody></table>

### setVisible(visible)

Updates the visibility of the field.

Parameter: `visible`

Parameter type: `boolean`

```
getFieldById("summary").setVisible(false)
```

## Behaviours on screen tabs

Note: Demo video

You can watch our helpful [demo video](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour) highlighting how the Behaviours on Screen Tabs feature works.

It is important to note that all Behaviours on screen tabs methods are only accessible on the object returned by [`getScreenTabById`](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.193738413.1853332841.1732524211-477394109.1726125732#iterating-over-screen-tabs) `` . ` ``

```
type ScreenTab = {
    getId: () => string;
    isVisible: () => boolean;
    setVisible: (isVisible: boolean) => void;
    focus: () => void;
}
```

### getId

Returns the screen tab identifier.

Return type: `string`

```
getId(): string
```

### isVisible

Returns `true` if the tab is currently visible. Returns `false` otherwise.

Return type: `boolean`

```
isVisible(): boolean
```

### setVisible

Changes tab visibility.

Return type: `void`

```
setVisible(value: boolean): ScreenTabAPI
 
tab.setVisible(false);
```

Note: Do not hide in-focus tabs

Always ensure that you are not hiding the tab currently in focus. Doing so means your UIM won't be applied and the `onError` callback will receive a `SCREENTABS_VALIDATION_FAILED` error.

### focus

Switches the focus to a given screen tab. Automatically puts other visible tabs out of focus.

Return type: `void`

```
focus(): ScreenTabAPI
 
tab.focus();
```

Note:

The screen tab setter methods are grouped and applied after the completion of other Behaviours that run `on load` or `on change`. This means that reading the values using the getter methods will always return the screen tab's initial state.

You can refer to Atlassian's [UI Modifications documentation](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#querying-screen-tabs) for more details about screen tabs.

## Make REST requests

You can use `makeRequest` to hit the Jira Cloud REST API.

Parameters:

url: string of the rest endpoint

requestOptions: Optional request options of type RequestInit | typescript - v3.7.7

Return type: Promise<{status: number, body: JSON }>

For example:

```
const res = await makeRequest("/rest/api/2/myself");
if(res.body.accountId == "the accountId") {
logger.info("User is bob");
}
```

Some Jira REST APIs are not supported on Atlassian Forge and will, therefore, not work on the Behaviours feature. For example, requests with OAuth2 permission scopes generally work on Forge. Where this scope is absent, we expect that the API endpoint is not supported on Forge.

You can make a POST request that specifies request options and headers with the `makeRequest` method. You can also make other types of REST requests, including PUT or POST. The example below shows how to make a POST request to the Jira expression API to test if an issue has more than 25 characters in the description and if so, to set some text in the summary field.

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

A logger is available, which will allow admins to view logs on the log page. This can be accessed by using the logger object.

Using the logger allows you to read the logs from your scripts inside the [ScriptRunner Logs](../../manage-app/review-logs.md) page.

For example:

`[logger.info](http://logger.info/) ("hello world");`

Available functions - each method takes a string parameter:

-   warn(msg)
-   debug(msg)
-   info(msg)
-   trace(msg)
