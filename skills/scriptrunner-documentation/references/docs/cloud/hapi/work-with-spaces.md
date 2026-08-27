# Work with Spaces

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-288524096
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-spaces

With HAPI, we've made it easy for you to create, modify, and archive spaces. 

## Create a new space with default values

You can create a new space as follows:

```
Spaces.create("TIS", "Teams in Space")
```

### Set details when creating a new space

When you create a space, some assumptions are made about fields such as the space lead (set to the `current user`), the space type (set to `business`), and the default assignee for the space (set to `Unassigned`). You can set these values, as well as optional values such as the `description` or the `URL` when you create the space. For example:

```
Spaces.create("TIS", "Teams in Space") {
    setLeadAccountId('user account id')
    setSpaceTypeKey('business')
    setDescription("This is a new space!")
    setUrl("https://google.com")
    setDefaultAssigneeToProjectLead()
    setAvatarId(10001)
}
```

  

![](/sr4jc/files/latest/288524096/524224170/1/1774348421000/create+new+space.png)

### Create a space using a template

You can create a new space using a template as follows:

```
Spaces.create("TIS", "Teams in Space"){
    setSpaceTemplateKey('Kanban')
}
```

The space templates available to you are provided through completions. You'll notice the names are the same as those you see when you create a space through Jira.

![](/sr4jc/files/latest/288524096/524224169/1/1774348509000/create+space+template.png)

## Retrieve a space by key

You can retrieve a space by key as follows:

```
Spaces.getByKey("TIS")
```

## Update a space

In this example, we're updating the space key, name, description, and space category and setting the default assignee to unassigned. You can update a space as follows:

```
Spaces.getByKey("TIS").update {
    setKey("TEAM")
    setName("Team space")
    setDescription("This is an updated space!")
    setDefaultAssigneeToUnassigned()
    setSpaceCategory("Backend spaces")
}
```

![](/sr4jc/files/latest/288524096/524224168/1/1774348601000/update+space.png)

## Delete a space

You can delete a space as follows:

```
Spaces.getByKey("TIS").delete()
```

This also deletes any work items, components, and versions related to the space.

* * *

## Related content

-   [Javadocs (Groovy) Class Projects](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/projects/Projects.html)
-   [Javadocs methods summary (Projects)](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/projects/Projects.html#method_summary)
