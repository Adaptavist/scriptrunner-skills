# The Linked Issues Field

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889008
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/the-linked-issues-field

You can use Behaviours to work with the _Linked Issues_ field, similar to how you work with other fields. However, as it’s a _composite_ field consisting of two fields you must set the value differently from other fields.

## Reading the _Linked Issues_ field value

To get the value of the _Linked Issues_ field, you can do the following:

```
// Return a String, for example, blocks or is caused by
getFieldById("issuelinks-linktype")

// Return an array, even an empty one
getFieldById("issuelinks-issues")
```

## Setting the _Linked Issues_ field value

To set the value of the _Linked Issues_ field you need to set the two values separately, for example:

```
        getFieldById("issuelinks-linktype").setFormValue("is blocked by")
        getFieldById("issuelinks-issues").setFormValue(["SSPA-1", "SSPA-2"])
```

### Other operations

You can perform operations on the entire _Linked Issues_ field or its individual components, for example:

```
// Make the entire Linked Issues field read-only
getFieldById('issuelinks').setReadOnly(true)

// Or operate on individual components
getFieldById('issuelinks-linktype').setReadOnly(true)
getFieldById('issuelinks-issues').setReadOnly(true)

// You can also make fields required, hidden, etc.
getFieldById('issuelinks').setRequired(true)
getFieldById('issuelinks-linktype').setHidden(false)
```

## Example: Limit the available issue link types for issues in a project

In the following example we want to limit the available issue link types for issues in a specific project so that we can easily create and maintain JQL filters to find issues with certain link types. We can use the following script to restrict the link type options to only those we have approved in the Create or Update form of an issue. 

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889008/441364127/1/1732554102000/Restricting_issue_type_2.png)  
    
10.  Copy the following code into the inline code editor:  
     
     You can also find this script when you select **Example scripts** in the code editor.  
     
     ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.link.IssueLinkTypeManager
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

def linkTypesField = getFieldById("issuelinks-linktype")

def allowedOutwardTypesNames = ["blocks", "relates to", "causes"]
def allowedInwardTypesNames = ["is blocked by", "relates to", "is caused by"]

def issueLinkTypeManager = ComponentAccessor.getComponent(IssueLinkTypeManager)
def allLinkTypes = issueLinkTypeManager.getIssueLinkTypes(false)

// Get the outward link names you want
def outwardAllowedLinks = allLinkTypes.findAll { linkType ->
    linkType.outward in allowedOutwardTypesNames
}.collectEntries { linkType ->
    [(linkType.outward): linkType.outward]
}
// Get the inward link names you want
def inwardAllowedLinks = allLinkTypes.findAll { linkType ->
    linkType.inward in allowedInwardTypesNames
}.collectEntries { linkType ->
    [(linkType.inward): linkType.inward]
}

// Combine maps of allowed link direction names
def allowedLinks = outwardAllowedLinks + inwardAllowedLinks as Map<String, String>
log.debug("Allowed Links = $allowedLinks")

// The options for the 'issuelinks-linktype' field have to be set in this structure: [blocks:blocks, relates to:relates to]
// because the html structure of the field uses the actual link direction name as the value property.
linkTypesField.setFieldOptions(allowedLinks)
```
     
11.  Select **Save Changes**. 
     
     You can now test your behaviour works by creating or updating an issue and seeing the limited linked issue options.
     
     ![](/sr4js/files/latest/442889008/441364126/1/1732621329000/LInked_issues.png)
     
       
     

  

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
