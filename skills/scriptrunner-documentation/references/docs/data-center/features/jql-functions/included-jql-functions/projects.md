# Projects

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions > Included JQL Functions
- Doc ID: doc-sr4js-ce9cd7c8-5340-451d-828e-57ca2e54995d-1208d1af240efad8
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#included-jql-functions--en#projects--en

## myProjects

Selects only issues from projects in which you are a member. Being a member means being in any role, except where that is by virtue of being in a group with a global permission. That is, many projects will have the group jira-users in the Users role. These won't be included in myProjects, as generally you will not be interested in them.

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
