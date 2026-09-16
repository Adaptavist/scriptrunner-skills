# Work with Projects

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-1577a7bc-1c9b-42cc-859d-5803ee8c1e09-e10a71f36dcd3dfc
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#work-with-projects--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-spaces) |

With HAPI we've made it easy for you to create, modify, and archive projects.

## Creating a new project

### Creating a project with default values

You can create a new project as follows:

```
Projects.create("TIS", "Teams in Space")
```

### Setting details when creating a new project

When you create a project, some assumptions are made about fields such as the project lead (set to the current user), the project type (set to `business`), and the default assignee for the project (set to `Unassigned`). You can set these values, as well as optional values such as the `description` or the `URL`, when you create the project. For example:

```
Projects.create("TIS", "Teams in Space") {
    projectLead = 'admin'
    projectType = "business"
    description = "This is a new project!"
    url = "https://google.com"
    setDefaultAssigneeToProjectLead()
    avatarId = 10001
}
```

### Creating a project using a template

You can create a new project using a template as follows:

```
 Projects.create("TIS", "Teams in Space") {
	projectLead = 'admin'
	projectTemplateKey = "com.pyxis.greenhopper.jira:basic-software-development-template"
}
```

The project templates available to you are provided through completions. You'll notice the names are the same as those you see when you create a project through Jira.

## Retrieving a project by key

You can retrieve a project by key as follows:

```
Projects.getByKey("TIS")
```

## Updating a project

You can update a project as follows:

Note: In this example we're updating the project key, name, description, project category, and setting the default assignee to unassigned.

```
Projects.getByKey("TIS").update {
    key = "TEAM"
    name = "Team project"
    description = "This is an updated project!"
    setDefaultAssigneeToUnassigned()
    projectCategory = "Backend projects"
}
```

## Updating the project type

You can update the project type as follows:

```
Projects.getByKey("TIS").update {
	projectType = "service_desk"
}
```

## Archiving a project

Note: This action is only available in Data Center.

You can archive a project as follows:

```
def project = Projects.getByKey("TIS")
project.archive()
```

## Deleting a project

You can delete a project as as follows:

Note: This also deletes any issues, components and versions related to the project.

```
Projects.getByKey("TIS").delete()
```

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/projects/Projects.html)
-   [Work with Epics, Stories and Sprints](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-epics-stories-and-sprints)
-   [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)
