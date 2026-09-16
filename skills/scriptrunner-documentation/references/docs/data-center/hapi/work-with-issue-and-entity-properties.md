# Work with Issue and Entity Properties

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-59d44f85-5a68-43ef-8a9a-85b692fc2f2a-e70e13a714ce2d3b
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#work-with-issue-and-entity-properties--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-entity-properties) |

Entity properties allow you to add key/value stores to issues, projects, users, and comments. Your scripts can use these properties for automations, for example, to store a user's department name on the user object.

There are two different mechanisms you can use to create these data stores. Check out the table below to compare the two mechanisms:

<table class="table" id="work-with-issue-and-entity-properties--en__generated-table-id-2"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1" colspan="1"><a class="xref j-external-link" href="https://developer.atlassian.com/server/jira/platform/entity-properties/" target="_blank">Entity properties</a> (more modern)</th><th class="entry" id="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2" colspan="1"><a class="xref j-external-link" href="https://docs.atlassian.com/DAC/javadoc/opensymphony-propertyset/1.5/reference/com/opensymphony/module/propertyset/PropertySet.html" target="_blank">Property sets</a> (can be applied to any Jira entity)</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Permissions are respected, for example, you can only write properties on an issue if you can edit that issue (<a class="xref" href="../uncategorized/h/hapi.md">HAPI</a> provides you with a way to override security).</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Have no permissions model.</td></tr><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Are accessible through a REST API—if the user can view the issue, they can access all the properties through this REST API.</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Are not accessible through the out-of-the-box REST API.</td></tr><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Are limited to 32k.</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Effectively unlimited size for strings.</td></tr><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">As well as simple data types, you can serialize your own classes and store them on entities.</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">-</td></tr><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">Issue properties can be indexed and searched with JQL.</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">-</td></tr><tr class="row"><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">-</td><td class="entry" headers="work-with-issue-and-entity-properties--en__generated-table-id-2__entry__1 work-with-issue-and-entity-properties--en__generated-table-id-2__entry__2 ">HAPI only enables property sets for <code class="ph codeph">ApplicationUser</code> objects currently.</td></tr></tbody></table>

## Entity properties

### Setting and getting issue properties

The following is a simple example of setting and getting an issue property:

```
def issue = Issues.getByKey('ABC-1')

// setting the property
issue.entityProperties.setString('my first property', 'Hello World!')

// retrieving the property value
issue.entityProperties.getString('my first property') // returns 'Hello World!'
```

Note: Permissions Setting a property requires that you have permission to edit the entity in question (issue, user, comment, etc.). Retrieving a property requires you have _view_ permissions, for example, you can view the issue on which the property is stored. You can [overwrite security restrictions](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-and-entity-properties#concept-8773--en) as described below.

You can also set and get several other property types:

Note: Use the corresponding _getter_ to retrieve the property value.

```
import groovy.json.JsonOutput
import java.time.LocalDate

def entityProperties = Issues.getByKey('ABC-1').entityProperties

entityProperties.setString('foo', 'bar')
entityProperties.setBoolean('onboarded', true)
entityProperties.setInteger('meaning of life', 42)
entityProperties.setLong('birth year', 1972L)
entityProperties.setLocalDate('my date', LocalDate.now())
```

In addition to the property types listed above, you can store maps, lists, or your own classes. For example, to store a map you could use the following:

```
entityProperties.setAsActualType('tasks', [
    content: 'complete design work',
    estimateInDays: 2,
])

// retrieve the properties as a Map
entityProperties.getAsActualType('tasks', Map)
```

You can store instances of your own classes. Check out the [Searchable entity properties](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-and-entity-properties#searchable-entity-properties--en) section to find out how.

#### Overwriting security restrictions

To read and write properties overriding the security restrictions, use `getEntityPropertiesOverrideSecurity()` :

```
 def entityProperties = Projects.getByKey('ABC').entityPropertiesOverrideSecurity
entityProperties.setString('foo', 'bar')
```

#### Searchable entity properties

You can store your own instances of your own class and have it as a searchable entity property.

Note: The property is serialized and deserialized with Jackson 2.x. If you want to handle the serialisation and deserialisation of the property yourself, use `setJson` and `getJson:`

```
entityProperties.setJson('my json', JsonOutput.toJson([foo: 'bar', qux: 3]))
```

##### Creating a searchable entity property

It is possible to have Jira index the property data of your own class, and then you can query on it with JQL. To do this, you can register a new plugin module, specifying which properties to extract.

1.  Register a plugin module using code similar to the following:
    
    Note: Plugin modules registered as follows will be removed when Jira restarts. Use the code in a script inside the `startup` directory, to ensure it executes on every restart.
    
    ```
    import com.onresolve.licensing.DynamicModulesComponent
    import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
    
    def dynamicModulesComponent = ScriptRunnerImpl.getPluginComponent(DynamicModulesComponent)
    def pluginXml = """
    <index-document-configuration
        entity-key="IssueProperty"
        key="jira-issue-tasklist-indexing">
    <key property-key="task">
        <extract path="content" type="text"/>
        <extract path="estimateInDays" type="number"/>
    </key>
    </index-document-configuration>
    """
    def writer = new StringWriter()
    writer.write(pluginXml)
    dynamicModulesComponent.register(writer)
    ```
    
2.  Add the issue property as follows:
    
    ```
    class IssueTask {
        String content
        Integer estimateInDays
    }
    
    entityProperties.setAsActualType('task', new IssueTask(content: 'complete design', estimateInDays: 3))
    
    // if you need to retrieve the property programmatically:
    entityProperties.getAsActualType('task', IssueTask)
    ```
    
3.  Execute the JQL as follows:
    
    ```
    'issue.property[task].content ~ "design" AND issue.property[task].estimateInDays = 3'
    ```
    
    Consult Atlassian documentation on [making entity properties searchable](https://developer.atlassian.com/server/jira/platform/entity-properties/#how-do-i-make-the-properties-of-an-entity-searchable-) for more information.
    

## Property sets

### Reading and writing user properties

As discussed in the table above, property sets are an older form of storing key/value pairs. Use the following to read and write user properties:

```
 def user = Users.loggedInUser
def propertySet = user.propertySet
                
propertySet.setString('foo', 'bar')
propertySet.getString('foo')
```

Note: Consult the javadoc for [PropertySet](https://docs.atlassian.com/DAC/javadoc/opensymphony-propertyset/1.5/reference/com/opensymphony/module/propertyset/PropertySet.html) to see the different types of properties you can set and get.

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/properties/EntityProperties.html)
-   [Work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users)
-   [Work with Permission Schemes](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-permission-schemes)
