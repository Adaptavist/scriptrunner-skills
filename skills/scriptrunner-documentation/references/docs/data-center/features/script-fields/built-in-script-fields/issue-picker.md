# Issue Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-442887115
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker

Use the Issue Picker script field to create a field that allows you to pick an issue, or issues, from a pre-defined JQL query. For example, you could use this script field to create a field that links _Incident_ issues records to _Problem_ issues. 

## Advantages of this script field

This feature offers several advantages over standard issue links:

-   Controlled issue selection: Unlike standard issue links, the Issue Picker field enables you to limit the subset of issues that can be linked by specifying a JQL query.
    
-   Workflow integration: As a field, it can be integrated into your workflow, allowing you to enforce linking or hide the field at specific workflow states.
    
-   Customize with Behaviours: You can control all aspects of this field using [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours). For example, you can set it to read-only, required, hidden, or set a default value.
    
    Example of customizing the JQL with Behaviours
    
    You can [change the JQL](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference) that controls which issues can be selected. For example, you have created an Issue Picker field called _Every Issue In TSP_ that returns every issue in a project:
    
    ```
project = TSP
```
    
    However, for a separate project, you may want to override the JQL to display issues that are a bug and where there is no assignee. You create a new Behaviour, map it to the new project, and add the following as an initialiser script:
    
    ```
def allTsp = getFieldById('customfield_10102')
allTsp.setConfigParam('currentJql', 'issuetype = Bug AND assignee is EMPTY')
```
    
-   Specificity without global impact: You can create specific link types between issues without making them globally available, unlike standard link types.

## Limitations of this script field

There are a few limitations to using this script field:

-   There is no reciprocal link available. In order to find issues linking to an issue you would need to execute [a JQL query](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-issuepickerfield).
-   Sorting is not an included functionality within an issue picker list. For more information about why we haven't included this as a function see the [Script Fields FAQ](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-fields-faq#order-by) page. 

## Advanced use of this script field

For advanced use of this script field, including customisation of the JQL, the drop-down behaviour and how the displayed value is rendered, see [Issue Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations).

## Using this script field

1.  From **ScriptRunner**, go to **Fields**. 
2.  Select **Create Script Field** **\> Issue(s) picker > Create Script Field**.
    
3.  Enter a **Field Name**. 
4.  Optional: Enter a **Field Description**.
5.  Optional: Enter a **Field Note**. 
6.  Enter a **JQL** query. You can leave this field blank to allow any issue to be selected. 
7.  Select the **Multiple** checkbox if you want to allow multiple options to be selected. 
8.  Optional: Add **Placeholder text**. This is the default text that displays when no issues are selected.
9.  Select **Fields to search**. These are the fields that the issue picker searches and displays by default.  
    
    Removing the issue key may make the issue picker harder to use. We recommend you include Issue Key + Summary, or Issue Key + one other short text custom field. If using a field other than summary, ensure this field has a value by adding "XYZ is not empty" to your JQL query above. [See more about this option below](#id-.IssuePickerv9.x-fields-to-search). 
    
10.  Optional: Enter a **Configuration Script**. This allows you to modify all aspects of the configuration. See [Issue Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations) for more details.  
     ![Example of issue picker form filled in](/sr4js/files/latest/442887115/441364492/1/1739900054000/Issue_picker_example.png)
11.  Enter a **Preview Issue Key** and select **Preview** to view the drop-down. This is useful to verify that the picker is only displaying the correct candidate issues.
     
     You can select an issue, or issues, in the drop-down, to view how the result will be displayed when viewing an issue.
     
12.  Select **Add**.
13.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this script field.  
     
     You can now test to see if this script field works as expected.   
     ![Image showing the issue picker working as expected](/sr4js/files/latest/442887115/441364491/1/1739900301000/Issue_picker_result.png)
     

### Fields to search option

The **Fields to search** option provides default values that allow users to search for an issue by typing terms from the **Summary** or the **Issue Key**. Then, when viewing an issue, a user can see the **Issue** **Key**, **Summary**, **Status** and **Priority**.

It is possible however, to show information from other fields in your issue picker alongside the **Issue Key**. For example, you may want to show details of a custom field. Any field added to the display can also be searched in the drop-down menu, enhancing the search functionality. If you would like to further customize the display value, then see [Issue Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations).

Recommendations

-   If you use multiple fields, they are separated with a hyphen (-). Always preview the results and test with various target issues to ensure the desired outcome.
-   Keep the **Issue Key** in the list of **Fields to Search** for quick selection when users know the specific key.

#### Best practices

Ensure that custom or system fields chosen for search have non-empty and unique values, at least in combination with other selected fields. To guarantee non-empty values, add a clause to your JQL query for each field (except Issue Key and Summary). For example: `IncidentID is not empty`.

## Tips

### Searching

You can search for issues linking to a particular issue, example:

```
"Related Problem" = "MSD-5"
"Related Problem" in ("MSD-5", "MSD-6")
```

You can also use the `IN`, `!=`, `NOT IN` operators, or the basic search mode.

To find issues based on a search of the issues they link to, see [issuePickerField](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-issuepickerfield) function.

### Programmatic updates

In this example we have an issue created via `IssueService`:

```
        def issue = Issues.create('SR', 'Bug') {
            setSummary('Help me!')
            setCustomFieldValue('Related Problem', 'MSD-1')
        }
```

If we retrieve or set the value directly on the issue, the result will be an [`Issue`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/Issue.html) object, or if we have chosen a **multiple** issue picker, a `Collection<Issue>`.

```
        // single issue picker
        assert issue.getCustomFieldValue('Related Problem') instanceof Issue

        // multiple issue picker
        assert issue.getCustomFieldValue('Related Problem') instanceof Collection
        assert issue.getCustomFieldValue('Related Problem').every { it instanceof Issue }
```

### REST

Setting a multiple issue picker:

```
fields: {
    customfield_12345: ["MSD-5", "MSD-6"]
```

Adding to a multiple issue picker:

```
update: {
    customfield_12345: [
        {"add" : "MSD-5"}
    ]
}
```

  

* * *

Related content

-   [Issue Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations)
-   [Issue Links](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links)
-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
