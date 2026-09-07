# Work with Groups

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442887568
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups

![](/sr4js/files/latest/442887568/441364735/1/1750779939000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups)** **for more details.** 

With HAPI we've made it easy for you to create, modify, and delete groups. 

## Creating a new group

You can create a new group as follows:

```
            Groups.create('jira-admin')
```

![Image showing how to create a new group](/sr4js/files/latest/442887568/442887572/1/1758746825000/Groups_create_group.png)

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

![Image showing how to add a user to a group](/sr4js/files/latest/442887568/442887571/1/1758746825000/Groups_add_users.png)

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

![Image showing how to get members of a group](/sr4js/files/latest/442887568/442887574/1/1758746825000/Getting_members.png)

## Deleting a group

You can delete a group as follows:

```
            def group = Groups.getByName('jira-developers')
            group.delete()
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/groups/Groups.html)
-   [Work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users)
-   [Work with Epics, Stories and Sprints](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-epics-stories-and-sprints)
