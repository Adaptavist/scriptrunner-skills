# Work with Groups

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-306811114
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups

With HAPI, we've made it easy for you to work with groups.

## Retrieve a group by name

You can retrieve a group by its name. You will need to retrieve a group when you wish to perform a change, for example, add or remove a user (as described in the following sections). You can retrieve a group as follows:

```
Groups.getByName('jira-developers')
```

## Retrieve a group ID

You can retrieve a group ID using the `getByName` function. 

```
Groups.getByName('jira-developers').getGroupId()
```

![](/sr4jc/files/latest/306811114/322830802/1/1736955475000/Retrieve+a+group+ID.png)

## Add users to a group

You can add users to a group as follows:

```
def group = Groups.getByName('jira-developers')

// user can be added to the group by their account id
group.add('user_account_id')
```

![](/sr4jc/files/latest/306811114/322830803/1/1736955475000/Add+users+to+a+group.png)

## Get all members of a group

You can get group members as follows:

```
def group = Groups.getByName('jira-developers')
group.getMembers()
```

![](/sr4jc/files/latest/306811114/322830801/1/1736955476000/Get+all+members+of+a+group.png)

## Check if a group contains users

You can check if a group contains a user of your choice as follows:

```
Groups.getByName('jira-developers').contains('user_account_id')
```

* * *

## Related content

-   [Work with Users](https://docs.adaptavist.com/spaces/HAPISRJC/pages/306808558/Work+with+Users)
-   [Javadocs methods summary (Groups)](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/groups/Groups.html#method_summary)
-   [Javadocs (Groovy) Class Groups](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/groups/Groups.html)
