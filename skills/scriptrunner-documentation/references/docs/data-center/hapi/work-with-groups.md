# Work with Groups

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-365d7901-15c8-4b1b-a016-3a7b9d44f05f-912ce3990413edb1
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#work-with-groups--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups) |

With HAPI we've made it easy for you to create, modify, and delete groups.

## Creating a new group

You can create a new group as follows:

```
Groups.create('jira-admin')
```

## Retrieving a group by name

You can retrieve a group by its name. You will need to retrieve a group when you wish to perform a change, for example, add or remove a user (as described in the following sections). You can retrieve a group as follows:

```
Groups.getByName('jira-developers')
```

## Adding and removing users from a group

### Add a user to a group

You can add users to a group as follows:

```
def group = Groups.getByName('jira-developers')
// user can be added to the group by username
group.add('bob')
            
// or using an ApplicationUser instance
def user = Users.getByName('joe')
group.add(user)
```

### Remove a user from a group

You can remove users as follows:

```
def group = Groups.getByName('jira-developers')
// user can be removed from the group by username
group.remove('bob')
            
// or using an ApplicationUser instance
def user = Users.getByName('joe')
group.remove(user)
```

## Getting all members of a group

You can get group members as follows:

```
def group = Groups.getByName('jira-developers')
group.getMembers()
```

## Deleting a group

You can delete a group as follows:

```
def group = Groups.getByName('jira-developers')
group.delete()
```

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/groups/Groups.html)
-   [Work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users)
-   [Work with Epics, Stories and Sprints](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-epics-stories-and-sprints)
