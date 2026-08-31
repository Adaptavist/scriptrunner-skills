# Custom Script Field

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields
- Doc ID: doc-sr4js-442887881
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field

Use custom script fields to create custom fields from a Groovy script. Custom script fields are designed to calculate values based on other issue fields.

Possible examples of information that could be displayed using the custom script field include:

-   Link to another project
    
-   Due date based on the priority of the issue
    
-   Link to another platform based on a combination of the issue fields
    
-   Calculate priority based on a combination of issue fields
    

## Limitations to custom script fields

Script fields that use data external to the issue, such as stock prices or today's temperature, will change their value every time the issue is viewed (because they are recalculated when an issue is viewed). However, their values will not be stored in the JQL index unless the issue you are viewing is edited or transitioned. Therefore, **JQL searches that use the values of these types of script fields may be inaccurate**, as the index value can be out of sync with the live calculated value.

## Templates

When configuring your custom script field you need to choose which template to use. The template also determines which issue panel (for example, Dates, People, or the default main panel) the value will be shown in the _view issue_ screen.

Script fields using either user template can be used in notification schemes, which means you can dynamically generate the recipient of an email, eg based on component lead, priority, etc.

You can use the following table as a guideline for which template to use:

Your script returns…​

Template

Issue panel your script field displays in

A string

Text Field (multi-line)

Main (Details)

A date

Date

Dates

A date

Date Time

Dates

A date

Absolute Date Time

Dates

A period of time

Duration

Dates

A period of time

Duration (time tracking)

Dates

A number

Number Field

Main (Details)

A user

User Picker (single user)

People

List of users

User Picker (multiple users)

People

A group

Group Picker (single group)

Main (Details)

List of groups

Group Picker (multiple groups)

Main (Details)

A string

HTML 

Deprecated

This template is deprecated. If selected, it will behave the same way as the **Text Field**. 

Main (Details)

Any object or collection

Custom

Main (Details)

List of versions

Version Picker

Main (Details)

A project

Project Picker

Main (Details)

A single or multiple issues

Issue(s)

Main (Details)

Depending on the complexity of the script you will need to test with multiple issues and different inputs.

Searchers

You can run a search on your script fields provided it has a _Searcher_ associated with it. For most custom script fields you have to add your own searcher. See the [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields#searcher) page for more information on searchers. 

## Detailed example: Display linked issues

More examples

Check out our [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples) page for more examples. 

The following is a detailed example that guides you through setting up a custom script field. This field will display information from the issues linked to it. This field will be useful for JQL filters and overviewing linked issue information.

In order to create this field, we want to do all of the following:

-   Fetch all the issues that make up an Epic
-   Collect a certain set of information, such as the issue's Key, Summary, and Status
-   Display that information in a table within the issue in a Script field

In the end, you will have a script field that displays linked issues, for example:

![Example of the result of this script](/sr4js/files/latest/442887881/441364515/1/1741166244000/Example_script_fields_1.png)

This field will allow you to fetch this information in a filter:

![Example of this custom script field displayed in a jql](/sr4js/files/latest/442887881/441364514/1/1741166268000/Example_custom_script_2.png)

Below we describe how to **create this custom script field** and how to **set up this custom script field**.

### Creating the custom script field script

#### Final script

You can copy the following script example into a custom script field and it will display linked issues, as shown above:

Expand to show the final script...

**An error occured**

There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)

#### Steps for creating this script

Below are the steps we took to get to the final script above.

Expand to show steps...

##### 1) Get the linked issues

You can use the following code to get the necessary imports for our script to work, and to get the links to the other issues from our Epic:

```
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder

def issueLinkManager = ComponentAccessor.getIssueLinkManager()
def links = issueLinkManager.getOutwardLinks(issue.id)

def writer = new StringWriter()
def xml = new MarkupBuilder(writer)
```

In the above script we are doing the following:

-   Using `[IssueLinkManager](https://docs.atlassian.com/software/jira/docs/api/7.0.4/com/atlassian/jira/issue/link/IssueLinkManager.html)` to access issue links.
-   Utilizing the `[issue](https://docs.atlassian.com/software/jira/docs/api/7.2.2/com/atlassian/jira/issue/Issue.html)` variable to get links from the current issue.
-   Using `[MarkupBuilder](https://groovy-lang.org/processing-xml.html#_markupbuilder)` to generate HTML safely.  
    
    `MarkupBuilder` is used to avoid using HTML syntax in Groovy code, and to avoid possible injection attacks.
    

##### 2) Create the table with HTML templating

You can check out this tutorial to learn more about [HTML tables](https://www.w3schools.com/html/html_tables.asp). For the examples below we developed our tables using HTML and then wrote them using `[MarkupBuilder](https://groovy-lang.org/processing-xml.html#_markupbuilder)`.

You can use the following code to define basic CSS for table styling:

```
xml.style(type: "text/css",
    '''
         #scriptField, #scriptField *{
                border: 1px solid black;
            }
          
            #scriptField{
                border-collapse: collapse;
            }
        ''')
```

To this styling, you can add our table layout. The headers are **Key**, **Summary** and **Status:**

```
xml.table(id: "scriptField") {
    tr {
        th("Key")
        th("Summary")
        th("Status")
    }
```

##### 3) Get the relevant information, and place a new row into the table

You can update the current table using [MarkupBuilder](https://groovy-lang.org/processing-xml.html#_markupbuilder) to get the relevant information, as follows:

```
xml.table(id: "scriptField") {
    tr {
        th("Key")
        th("Summary")
        th("Status")
    }
    links.each { issueLink ->
        def linkedIssue = issueLink.destinationObject
        tr {
            td(linkedIssue.key.toString())
            td(linkedIssue.summary.toString())
            td(linkedIssue.status.getName().toString())
        }
    }
}
```

In the above script we are doing the following:

-   Using a [Closure](http://groovy-lang.org/closures.html) to go through every link that is collected within the variable `links` in our script, and getting the relevant information that we want to display
-   Getting the issue object by calling the property `destinationObject`.
-   Extracting issue key, summary and status information. 

##### 4) Return of the html element and edge cases

When crafting a script, you should always take into consideration your edge cases, the cases that would make your script break. For example, what happens when an epic has no links? If you analyze the flow of the code, you will be able to tell that if we leave the script as is, when our epic task has no links, this script will just output a header, which will not look very well on its own.

You can use the following to evaluate our variable `links` right at the very beginning of our code, to check if it contains anything before we add the header. If it doesn’t, we will simply return null and finish the script early:

```
if (!links) {
    return null
}
```

In addition, all of this time, the `xml` variable has been linked to the `writer`. To return this HTML, you can use the following:

```
return (writer.toString())
```

All of these examples make the above [final script](#id-.CustomScriptFieldv9.x-final). 

### Setting up the custom script field

1.  From **ScriptRunner**, select the **Fields** tab.
2.  Select **Create Script Field**.
3.  Select **Custom Script** **Field**.
4.  Enter the name for the custom script field. In this example, we enter _Linked issues_. 
5.  Optional: enter a description. In this example, we enter _Show all linked issues_. 
6.  Optional: add a field note. 
7.  Select the **Text Field (multi-line)** template.
8.  Enter the following script into the script editor:  
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder

def issueLinkManager = ComponentAccessor.getIssueLinkManager()
def links = issueLinkManager.getOutwardLinks(issue.id)

def writer = new StringWriter()
def xml = new MarkupBuilder(writer)


if (!links) {
    return null
}

xml.style(type: "text/css",
    '''
         #scriptField, #scriptField *{
                border: 1px solid black;
            }
          
            #scriptField{
                border-collapse: collapse;
            }
        ''')

xml.table(id: "scriptField") {
    tr {
        th("Key")
        th("Summary")
        th("Status")
    }
    links.each { issueLink ->
        def linkedIssue = issueLink.destinationObject
        tr {
            td(linkedIssue.key.toString())
            td(linkedIssue.summary.toString())
            td(linkedIssue.status.getName().toString())
        }
    }
}

return (writer.toString())
```
    
9.  Optional: enter an issue key and select **Preview** to preview this custom script field
10.  Select **Add**.  
     ![Image showing this custom script field filled in](/sr4js/files/latest/442887881/441364513/1/1741166474000/Example_custom_script_3.png)
11.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.  
     
     Test your script field
     
     You can now test your script field displays as expected in your issues. 
     
     ![](/sr4js/files/latest/442887881/441364515/1/1741166244000/Example_script_fields_1.png)
     
       
     
12.  The _Searcher_ for this example is automatically set to the _Free Text Searcher_. For most custom script fields you have to add your own searcher. See the [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields#searcher) page for more information on searchers. 

## Understanding inward and outward links

If you check the script field, you will notice the following line:

```
...
issueLinkManager.getOutwardLinks(issue.id)
...
```

This line retrieves the **Outward** links of the issue, not the **Inward** links. Understanding this distinction is crucial in Jira, as links between issues are categorized as **Inward** or **Outward** based on the link's origin.

-   **Outward link:** Created from within the issue you're referencing, indicating the link originates from that issue.
-   **Inward link:** Created from another issue, indicating the link originates from outside the issue you're referencing.

For example, if stories were linked to an epic from the stories themselves, rather than from the epic, the table above would display nothing because the links would be Inward, not Outward.

  

* * *

## Related content

-   [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields)
-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
-   [Built-In Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields)
