# Work with Assets / Insight

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442887470
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight

Assets (formerly Insight) is a database of objects, and objects are a digital representation of your assets. An asset/object can be anything from hardware to software to people. You can find out more about Assets in [Atlassian's documentation](https://confluence.atlassian.com/servicemanagementserver/managing-your-assets-with-assets-1044784300.html). With HAPI you can easily work with asset objects, create attachments and search for assets, all from your ScriptRunner script console.

## Key terms

If you are familiar with Assets then you will be familiar with the terms on this page. If you are relatively new to Assets, the following table will help you understand some key terms used.

Term

Description

**Object schema**

A database of object types and assets. All assets have an object type, and object types are grouped into schemas. Find out more about object schemas in [Atlassian's documentation](https://confluence.atlassian.com/servicemanagementserver/working-with-object-schemas-1044784448.html). 

**Object schema key**

The key given to your object schema. This key is typically a set of letters, for example, AAA or IAS.

**Object type**

A group that contains assets of the same type. For example, you can have a Team Member object type that contains a list of your employees where each team member is an individual asset. Find out more about object types in [Atlassian's documentation](https://confluence.atlassian.com/servicemanagementserver/working-with-object-types-1044784515.html).

**Asset object**

A digital representation of your asset. For example a team member. An asset and an object are the same thing.

**Asset object key**

The key given to your asset. An object key typically consists of the object schema key followed by a number, for example, AAA-1 or IAS-1.

**Attributes**

These are what define your object types (and subsequently your object assets). If you are creating or updating an object asset using HAPI, and at the same time setting an attribute, you must make sure that the attribute is configured to the object type that the object is grouped to. Find out more about attributes in [Atlassian's documentation](https://confluence.atlassian.com/servicemanagementserver/adding-attributes-to-object-types-1044784524.html).

**References**

References can be associated with an object type. References are typically used to link one object to another.

### ![Image describing assets page](/sr4js/files/latest/442887470/442887508/1/1758746814000/Assets_description.png)

## Working with Assets

To set an Assets custom field there must be an Assets custom field available. See [Atlassian's documentation](https://confluence.atlassian.com/servicemanagementserver/default-assets-custom-field-1044784428.html) to create an Assets custom field. The purpose of this custom field is to link your Assets with your Jira instance. 

You can set Assets custom fields by using the key of the Asset object, or an `ObjectBean`. For example, if your custom field is associated with an object schema with key `AAA`, you might use:

In this example we're setting a multiple Assets custom field, to multiple Asset objects.

```
issue.update {
    setCustomFieldValue('My asset custom field') {
        set('AAA-1', 'AAA-2')
    }
}
```

![Image showing how you assign an issue to an asset object with HAPI](/sr4js/files/latest/442887470/442887511/1/1758746814000/Assets_set_asset_object_to_issue.png)

## Working with Assets objects

You can easily create and update Assets objects using HAPI.

### Completions

With HAPI we provide completions for Assets. So when you're when creating or editing an object, you can select from a list of choices. The required attributes also display for each object type, meaning there's less chance of you missing an attribute and subsequently having errors. 

![GIF showing completions](/sr4js/files/latest/442887470/442887534/1/1758746816000/Assets_completions.gif)

### Creating a new Assets object

You can create a new Assets object with multiple attributes as follows:

In this example we're creating a new **object**. You can try this exact example if you create a sample "IT Assets Schema". Make sure the object schema key is **`IAS`**. 

```
            Assets.create('IAS', 'Host') {
                setAttribute('Name', 'Sales Web Server')
                setAttribute('Hostname', 'salesweb')
                setAttribute('FQDN', 'sales.acme.com')
                setAttribute('Status', 'In Service')    // status
                setAttribute('RAM', 32_000)             // integer  
                setAttribute('Virtual', true)           // boolean
            }
```

Using IDs

You can use the ID of an object or attribute instead of the name. For example instead of the following:

```
Assets.create('Host') {
    setAttribute('Operating System', 'Operating System Name')
}
```

You could use:

```
Assets.create(2) {
    setAttribute(71, Assets.getById(7))
}
```

Using IDs is useful if you want to preserve the usability of your script, as names can change but the ID stays the same.

### Retrieving an Assets object by key

You can retrieve an Assets object by key as follows:

```
Assets.getByKey('AAA-1')
```

**Video**

Your browser does not support the HTML5 video element

 

### Retrieving an Assets object by ID

You can retrieve an Assets object by **ID** as follows:

Replace the id number in the following example with the relevant asset ID.

```
Assets.getById(1)
```

For example, you can use the following to retrieve a specific Assets object from a custom _Assets Object_ field on an issue:

```
def issue = Issues.getByKey("TEST-123")
def assetsObjectValue = issue.getCustomFieldValue("Assets Object Custom Field")
def assetsObjectId = assetsObjectValue[0].id
def assetsObject = Assets.getById(assetsObjectId)
```

### Retrieving an Assets object on an issue

You can retrieve Assets objects that are associated with an issue. 

#### Single-select Assets object field

You can use the following example to retrieve single select Assets objects on an issue:

```
// retrieve the issue object using its key
def issue = Issues.getByKey("TEST-123")

// get the value of a single-select assets object custom field
// returns a single object wrapped in an ArrayList 
// example output: [Apple (KEY-1)]
def singleSelectAssetsObjectValue = issue.getCustomFieldValue("Single-select Assets Object Custom Field")

// access the first (and only) assets object in the ArrayList
def assetsObject = singleSelectAssetsObjectValue[0]
```

#### Multi-select Assets object field

You can use the following example to retrieve multi-select Assets objects on an issue:

```
// retrieve the issue object using its key
def issue = Issues.getByKey("TEST-123")

// get the value of a multi-select assets object custom field
// returns an ArrayList containing multiple selections
// example output: [Apple (KEY-1), Banana (KEY-2), Cherry (KEY-3), Durian (KEY-4)]
def multiSelectAssetsObjectValue = issue.getCustomFieldValue("Multi-select Assets Object Custom Field")

// iterate over each assets object
multiSelectAssetsObjectValue.each { assetsObject ->
    log.info("Asset Object: $assetsObject")
}
```

### Retrieving attribute values

You can retrieve attribute values in a type-safe way by using getters. For example, if the attribute value is a string field (**Text**, **Textarea**, or **Select**) you can use `getString`.

The following demonstrates examples of the different getters available for retrieving attribute values. Choose the correct one based on the attribute type.

```
            def asset = Assets.create('IAS', 'Host') {
                setAttribute('Name', 'Web Server')
                setAttribute('RAM', 32_000)
                setAttribute('Virtual', true)
                setAttribute('Status', 'In Service')    
                setAttribute('Operating System', 
                    Assets.create('IAS', 'Operating System') {
                        setAttribute('Name', 'Linux')                    
                    }
                )
                setAttribute('Network Interfaces', 
                    Assets.create('IAS', 'Network Interface') {
                        setAttribute('Name', 'net1')                    
                    },
                    Assets.create('IAS', 'Network Interface') {
                        setAttribute('Name', 'net2')                    
                    },
                )
            }

            assert asset.getString('Name') == 'Web Server'
            assert asset.getInteger('RAM') == 32_000
            assert asset.getBoolean('Virtual') == true
            assert asset.getReferences('Network Interfaces')*.getString('Name') == ['net1', 'net2']
            assert asset.getReference('Operating System').getString('Name') == 'Linux'
            assert asset.getStatus('Status') == 'In Service'
            assert asset.getDate('Created').before(new Date())
```

For retrieving references, `ObjectBeans` are returned rather than the IDs of the referenced objects. 

#### Retrieving attribute values using dot notation

You can use dot notation to retrieve attributes, in the [same way you can use it in IQL and AQL](https://confluence.atlassian.com/servicemanagementserver/advanced-searching-aql-assets-query-language-1044784588.html#Advancedsearching:AQLAssetsQueryLanguage-Dotnotation). You can join together as many attribute names as required. 

A flattened, unsorted list is returned. This list may contain duplicates or nulls.

```
            asset.getString('Operating System.Name') == 'Linux'
            asset.getStrings('Network Interfaces.Name') == ['net1', 'net2']
```

If you are not using dot notation, we recommend you use `getReference` and `getReferences` to retrieve references, as shown above. However, you can use `getAttributeValues` which always returns a `Collection<? extends ObjectAttributeValueBean>` , for example:

```
            assert asset.getAttributeValues('Name')*.textValue == ['Web Server']
            assert asset.getAttributeValues('RAM')*.integerValue == [32_000]
```

You should use the correct method to retrieve the underlying value. For example you can use `textValue`, `integerValue`, etc. for a **Default** attribute type. The correct method depends on the attribute type.

### Setting references

You can set references by using an object bean reference. Alternatively, you can use the object key e.g. "AIS-152".

In this example we're creating and setting the operating system.

```
            def operatingSystem = Assets.create('IAS', 'Operating System') {
                setAttribute('Name', 'Linux')
            }
            
            Assets.create('IAS', 'Host') {
                setAttribute('Name', 'File Server')
                
                // pass in the ObjectBean
                setAttribute('Operating System', operatingSystem)
            }
```

![Image showing how you set a reference object using HAPI](/sr4js/files/latest/442887470/442887509/1/1758746814000/Assets_set_reference_objects.png)

### Setting attributes that reference Jira properties

You can set attributes which are references to Jira projects, groups, users etc. as follows:

In this example we're setting project, group and user attributes.

```
            Assets.create('IAS', 'CPU') {
                setAttribute('CPU Type', 'Quantum')
                setAttribute('Project', 'JRA')                  // Jira project 
                setAttribute('Group', 'jira-administrators')    // Jira group
                setAttribute('User', 'anuser')                  // Jira user 
            }
```

### Updating attributes

You can update assets as follows:

In this example we're creating an attribute and setting the name, while at the same time updating the name attribute.

```
            def asset = Assets.create('IAS', 'Host') {
                setAttribute('Name', 'Web Server')
            }
            
            asset.update {
                setAttribute('Name', 'Sales Web Server')
                setAttribute('FQDN', 'sales.acme.com')
            }
```

You can update attribute values using `add()`, `remove()`, `clear()`, and `replace()`. 

#### Adding values to an attribute

If you have attributes that allow for multiple values, you can add values to attributes using `add()`.

For example, to add to the existing values of the **CPUs** attribute:

```
            asset.update {
                setAttribute('CPUs') {
                    add('IAS-999')
                }
            }
```

Similarly, you can also use a reference to the object itself:

```
            def cpuAsset = Assets.getByKey('IAS-999')
            
            asset.update {
                setAttribute('CPUs') {
                    add(cpuAsset)
                }
            }
```

#### Removing values from an attribute

If you have attributes with multiple values, you can remove existing values from attributes using `remove()`.

For example, to remove the existing values of the **CPUs** attribute:

```
            asset.update {
                setAttribute('CPUs') {
                    remove('IAS-999')
                }
            }
```

You can use the same approach for an Jira type attributes, such as user, group, project and so on.

### Clearing the value of an attribute

You can clear the value of an attribute as follows:

In this example we're clearing the "FQDN" attribute.

```
            asset.update {
                clearAttribute('FQDN')
            }
```

![Image showing how you clear the value of an attribute with HAPI](/sr4js/files/latest/442887470/442887510/1/1758746814000/Assets_clear_attribute.png)

You can also clear attributes using the methods described under [Updating attributes](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight#updateattributes).

## Working with Assets in Behaviours

When you're working in Behaviours with an Assets object custom field that has multiple values, you need to handle the return type of the Assets field carefully. The return type can vary depending on the number of selected values. To ensure consistent handling, we recommend you check the the Assets value type and create a List to wrap single items that may be returned, as shown in the following example: 

```
def assetsValue = getFieldByName("Assets field (multiple)").getValue()

if (assetsValue !instanceof List) {
    // Assets values are sometimes returned as an Object instead of a list with 1 item in them.
    // So we catch these cases and wrap them into a List to ensure we're always dealing with the same
    // type of object
    assetsValue = [assetsValue]
}

log.warn("Value returned: $assetsValue, class: ${assetsValue.class}")
```

This approach guarantees that `assetsValue` is always a list, regardless of whether the Assets field contains a single value or multiple values.

## Working with attachments

### Creating attachments

You can create attachments on Assets objects by specifying a File object. If you wish to set an attachment comment or override the mime type, use the form that accepts a closure. An example is provided in the following script:

```
            def asset = Assets.create('IAS', 'Host') {
                setAttribute('Name', 'Web Server')
            }
            
            asset.addAttachment(new File('/tmp/myfile.txt'))
            
            asset.addAttachment(new File('/tmp/otherfile.txt')) {
                // use whichever you need to override. Sensible defaults are provided
                setFilename('report.html')
                setMimeType('text/html')
                setComment('Asset report')            
            }
```

![](/sr4js/files/latest/442887470/442887512/1/1758746814000/Assets_create_attachments.png)

### Reading attachments

You can read attachments by using the extension method `com.riadalabs.jira.plugins.insight.services.model.ObjectBean.getAttachments()` .

We deliberately do not give you access to the underlying File object (because you should not manipulate it directly), instead there is an extension method to read the file's contents. 

```
            asset.attachments.find { 
                it.filename == 'report.html' 
            }.withInputStream { is ->
                // do something with the content:
                is.text
            }
```

### Deleting attachments

You can delete attachments using the following extension method:

```
            asset.attachments.each { it.delete() }
```

## Working with comments

You can add, retrieve and delete comments as shown below.

```
            import com.riadalabs.jira.plugins.insight.services.model.CommentBean
            
            // add a comment
            asset.addComment("my comment")
            
            // add a comment specifying the security level
            asset.addComment("visible only to admins", CommentBean.ACCESS_LEVEL_ADMINISTRATORS)
            
            // retrieve comments
            asset.comments.each {
                // do something with comment text or author:
                // it.comment 
                // it.author
            }
            
            // delete comments
            asset.comments.findAll {
                it.author == 'admin'
            }.each {
                it.delete()
            }
```

![Image showing how to add a comment to assets with HAPI](/sr4js/files/latest/442887470/442887530/1/1758746815000/Assets_add_comment.png)

## Executing an AQL query

This works similarly to `JQL.search()`, in that an `Iterator` is returned, to avoid using too much memory. See the [Search for Issues](https://docs.adaptavist.com/sr4js/latest/hapi/search-for-issues) page for details on how to run a JQL query.

You can execute an AQL query as follows:

```
            Assets.search("objectType = Host order by Name asc").each {
                // ...            
            }
```

![](/sr4js/files/latest/442887470/442887535/1/1758746819000/AQL_query_screen.png)

If you only want to get the count of matching objects, use the `.count` method as follows:

```
            Assets.count("objectType = Host")
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/assets/Assets.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Work with Comments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments)
-   [Work with Attachments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments)
