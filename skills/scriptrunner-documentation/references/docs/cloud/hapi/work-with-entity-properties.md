# Work with Entity Properties

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-339512207
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-entity-properties

With HAPI, you can easily set and retrieve entity properties. 

Entity properties are **key-value pairs** that can be stored against Jira entities, such as [Spaces (Projects)](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-spaces), [Work Items (Issues)](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items), [Users](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-users) and [Comments](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-comments). They can tag information to such entities, and they can be stored, read or deleted programmatically. You can refer to Atlassian's Jira Cloud platform [documentation](https://developer.atlassian.com/cloud/jira/platform/jira-entity-properties/) to find out more.

The key of an entity property is always a string. The value can be a string, an integer, a long, a Boolean, or a JSON. We've provided some examples below that demonstrate how the value of an entity property can be a String, a boolean, a simple JSON, a number (long or integer), or a JSONArray.

```
{
  "key": "testProperty",
  "value": "the value of the property"
}
```

```
{
  "key": "testProperty",
  "value": true
}
```

```
{
  "key": "testProperty",
  "value": {
    "firstEntry": "one",
    "secondEntry": "two"
  }
}
```

```
{
  "key": "testProperty",
  "value": 5
}
```

```
{
  "key": "testProperty",
  "value": [
    {
      "propertyOne": 1,
      "propertyTwo": 2
    },
    {
      "propertyA": "A",
      "propertyB": "B"
    }
  ]
}
```

## Set and retrieve entity properties

**HAPI** equips entities like Spaces (Projects), WorkItems (Issues), Users and Comments with a Groovy object called `EntityProperties`. This provides methods to set and retrieve properties stored against the specific entity that made the object available.

To use the `EntityProperties` object:

1.  Choose the entity (space/user/workItem/comment) whose properties you want to interact with.
2.  Extract the `EntityProperties` object.
3.  Call the methods provided by the `EntityProperties` object to set or get properties.

### Example use of EntityProperties

Here's an example of how to use `EntityProperties` for a space:

```
def mySpace = Spaces.getByKey("TEST")                                       // Obtain the entity
def entityProperties = mySpace.getEntityProperties()                        // Extract the EntityProperties object from the entity

entityProperties.setString("testProperty", "the value of the property")     // Call the methods provided by the EntityProperties object
                                                                            // to set or get properties 
entityProperties.getString("testProperty")
```

`EntityProperties` objects are entity-specific. When obtained from a certain entity (such as a space, user, work item, or comment), an `EntityProperties` object will interact only with the properties of that particular entity.

For example:

```
Spaces.getByKey("TST1").getEntityProperties()                      // will interact with properties stored against Space TST1
Spaces.getByKey("TST2").getEntityProperties()                      // will interact with properties stored against Space TST2
Users.getByAccountId("aaaaa-11111").getEntityProperties()          // will interact with properties stored against User aaaaa-11111
Users.getByAccountId("bbbbb-22222").getEntityProperties()          // will interact with properties stored against User bbbbb-22222
WorkItems.getByKey("CCC-1").getEntityProperties()                  // will interact with properties stored against Work Item CCC-1   
WorkItems.getByKey("CCC-2").getEntityProperties()                  // will interact with properties stored against Work Item CCC-2

List<Comment> comments = WorkItems.getByKey("CCC-1").getComments()
Comment firstComment = comments.getAt(0)                           // assuming the list of comments is not empty
firstComment.getEntityProperties()                                 // will interact with properties stored against that comment
```

## Methods of the EntityProperties object

The `EntityProperties` object provides various methods that allow you to interact with an entity's properties. Setters and getters will allow you to set and retrieve entity properties based on the specified property type.

Calling a setter method with the key of an existing property will overwrite with a new value. Calling a getter method with a specific return type should only be done if the property's type is known.

For example, if a property has been set using the s`etLocalDate` method,  the `getLocalDate` method can be expected to function correctly.

-   `[setString(String key, String value)](#id-.EntityPropertiesvCurrent-string)`
-   [`getString(String key)`](#id-.EntityPropertiesvCurrent-string) 
-   [`setInteger(String key, Integer value)`](#id-.EntityPropertiesvCurrent-integer) 
-   [`getInteger(String key)`](#id-.EntityPropertiesvCurrent-integer) 
-   [`setLong(String key, Long along)`](#id-.EntityPropertiesvCurrent-long) 
-   [`getLong(String key)`](#id-.EntityPropertiesvCurrent-long) 
-   [`setBoolean(String key, Boolean bool)`](#id-.EntityPropertiesvCurrent-boolean) 
-   [`getBoolean(String key)`](#id-.EntityPropertiesvCurrent-boolean) 
-   [`setLocalDate(String key, LocalDate localDate)`](#id-.EntityPropertiesvCurrent-localDate) 
-   [`getLocalDate(String key)`](#id-.EntityPropertiesvCurrent-localDate) 
-   [`setLocalDateTime(String key, LocalDateTime localDateTime)`](#id-.EntityPropertiesvCurrent-localDateTime) 
-   [`getLocalDateTime(String key)`](#id-.EntityPropertiesvCurrent-localDateTime) 

Whilst setting a JSON gives you options, it's important to note that the JSON string for the property value must be correctly formatted.

-   [`setJson(String key, String json)`](#id-.EntityPropertiesvCurrent-json) 
-   [`getJson(String key)`](#id-.EntityPropertiesvCurrent-json) 

An object can be set as a property value as long as it is serializable to a JSON. The resulting JSON value can then be deserialized into the original class using a getter method.

-   `[setAsActualType(String key, Object value)](#id-.EntityPropertiesvCurrent-actualType)` 
-   [`getAsActualType(String key, Class<T> class)`](#id-.EntityPropertiesvCurrent-actualType) 

The `EntityProperties` object can return the full property in the form of an `EntityProperty` object (singular), which is an original Jira class with two fields: _key_ and _value_.

-   `[getEntityProperties(String key)](#id-.EntityPropertiesvCurrent-entityProperties)`

The `EntityProperties` object owns a method to retrieve a list of all keys of the properties stored against an entity.

-   [`getKeys()`](#id-.EntityPropertiesvCurrent-keys) 

The `EntityProperties` object provides a method to allow you to verify whether a property exist or not:

-   [`propertyExists(String key)`](#id-.EntityPropertiesvCurrent-propertyExists) 

The `EntityProperties` object provides the functionality to delete a property:

-   [delete(String key)](#id-.EntityPropertiesvCurrent-delete)

### `setString, getString`  [](#id-.EntityPropertiesvCurrent-string)

setString(String key, String value)

getString(String key)

![](/sr4jc/files/latest/339512207/524224221/1/1774277388000/image-2026-3-23_15-49-48.png)

![](/sr4jc/files/latest/339512207/524224220/1/1774277449000/image-2026-3-23_15-50-48.png)

### `setInteger,` `getInteger`

setInteger(String key, Integer integer)

getInteger(String key)

![](/sr4jc/files/latest/339512207/524224219/1/1774278889000/image-2026-3-23_16-14-49.png)

![](/sr4jc/files/latest/339512207/524224218/1/1774278922000/image-2026-3-23_16-15-21.png)

### `setLong,` getLong

setLong(String key, Long along)

getLong(String key)

![](/sr4jc/files/latest/339512207/524224217/1/1774278994000/image-2026-3-23_16-16-33.png)

![](/sr4jc/files/latest/339512207/524224216/1/1774279028000/image-2026-3-23_16-17-7.png)

### `setBoolean,` getBoolean

setBoolean(String key, Boolean bool)

getBoolean(String key)

![](/sr4jc/files/latest/339512207/524224215/1/1774279066000/image-2026-3-23_16-17-45.png)

![](/sr4jc/files/latest/339512207/524224214/1/1774279142000/image-2026-3-23_16-19-1.png)

### `setLocalDate,` getLocalDate

setLocalDate(String key, LocalDate date)

getLocalDate(String key)

![](/sr4jc/files/latest/339512207/524224213/1/1774279206000/image-2026-3-23_16-20-5.png)

![](/sr4jc/files/latest/339512207/524224212/1/1774279234000/image-2026-3-23_16-20-33.png)

### `setLocalDateTime,` getLocalDateTime

setLocalDateTime(String key, LocalDate dateTime)

getLocalDateTime(String key)

![](/sr4jc/files/latest/339512207/524224211/1/1774279262000/image-2026-3-23_16-21-1.png)

![](/sr4jc/files/latest/339512207/524224208/1/1774279300000/image-2026-3-23_16-21-39.png)

### `setJson,` getJson

setJson(String key, String json)

getJson(String key)

![](/sr4jc/files/latest/339512207/524224207/1/1774279332000/image-2026-3-23_16-22-11.png)

![](/sr4jc/files/latest/339512207/524224206/1/1774279370000/image-2026-3-23_16-22-50.png)

### `setAsActualType,` getAsActualType

setAsActualType(String key, Object value)

getAsActualType(String key, Class<T> class)

![](/sr4jc/files/latest/339512207/524224205/1/1774279546000/image-2026-3-23_16-25-45.png)

![](/sr4jc/files/latest/339512207/524224204/1/1774279577000/image-2026-3-23_16-26-16.png)

### getEntityProperty

getEntityProperty(String key)

![](/sr4jc/files/latest/339512207/524224202/1/1774279617000/image-2026-3-23_16-26-56.png)

### getKeys 

getKeys()

![](/sr4jc/files/latest/339512207/524224201/1/1774279685000/image-2026-3-23_16-28-4.png)

### propertyExists

propertyExists(String key)

![](/sr4jc/files/latest/339512207/524224200/1/1774279736000/image-2026-3-23_16-28-55.png)

### delete

delete(String key)

![](/sr4jc/files/latest/339512207/524224199/1/1774279782000/image-2026-3-23_16-29-41.png)

  

* * *

Related content

-   Javadoc for [EntityProperties](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/entityproperties/EntityProperties.html) (interface)
-   Javadoc for [ProjectEntityProperties](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/entityproperties/ProjectEntityProperties.html) (Project-specific implementation)
-   Javadoc for [UserEntityProperties](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/entityproperties/UserEntityProperties.html) (User-specific implementation)
-   Javadoc for [IssueEntityProperties](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/entityproperties/IssueEntityProperties.html) (Issue-specific implementation)
-   Javadoc for [CommentEntityProperties](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/entityproperties/CommentEntityProperties.html) (Comment-specific implementation)
