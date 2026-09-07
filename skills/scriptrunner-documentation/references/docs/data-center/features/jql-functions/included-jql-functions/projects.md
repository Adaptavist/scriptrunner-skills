# Projects

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-101624222
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects

## myProjects

Selects only issues from projects in which you are a member. Being a member means being in any role, except where that is by virtue of being in a group with a global permission. That is, many projects will have the group jira-users in the Users role. These won’t be included in myProjects, as generally you will not be interested in them.

Usage:

```
project in myProjects()
```

## recentProjects

Projects you have viewed recently.

```
project in recentProjects()
```

## projectsOfType

Allows to find issues in projects of a given type.

```
project in projectsOfType("service_desk")
```
