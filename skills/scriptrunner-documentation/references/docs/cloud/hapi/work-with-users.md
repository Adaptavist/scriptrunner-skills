# Work with Users

- Platform: cloud
- Space: SR4JC
- Hierarchy: HAPI
- Doc ID: doc-sr4jc-95b7ffb5-f88f-4ad1-8d8d-7703fa4fa88a-a940853e5e80122d
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi#work-with-users--en

With HAPI, we've made it easy for you to work with users.

## Retrieve users from Jira and use them in scripts

In Jira Cloud, APIs discourage the use of personal information, so account IDs are used to reference users.

You can look up user account IDs in Jira using the user directory page, which can be found at https: [atlassian.net/people](http://atlassian.net/people)

```
def user = Users.getByAccountId('613b226ac425a20068240gpp').displayname()
```

## Get the current user

You can work with role memberships as follows:

```
def user = Users.getLoggedInUser()
WorkItems.getByKey('TEST-1').update {
    setAssignee(user) 
}
```

## Get the user's email address

You can get a user's email address as follows:

```
def userMail = Users.getByAccountId('user_account_id').getEmailAddress()
```

Users must allow their email address to be visible to 3rd parties.

## Work with group membership

You can work with group memberships as follows:

```
//get Groups where the user is a member
User user = Users.getLoggedInUser()
user.groups 
 
//check if a user is a member of a group
Groups.getByName('org-admins').contains("613b226ac425a20068240gpp")
 
//alternatively, you can pass a User to the check
Groups.getByName('org-admins').contains(user)
```

## Related content

-   [Work With Groups](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups)
-   [Javadocs \[Groovy\] Class Users](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/users/Users.html)
-   [Javadocs methods summary (User)](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/users/User.html)
