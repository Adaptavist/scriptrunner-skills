# Work with Users

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-306811107
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-users

With HAPI, we've made it easy for you to work with users. 

## Retrieve users from Jira and use them in scripts

In Jira Cloud, APIs discourage the use of personal information, so account IDs are used to reference users.

You can look up user account IDs in Jira using the user directory page, which can be found at **https:<your-domain>.[atlassian.net/people](http://atlassian.net/people)**

```
def user = Users.getByAccountId('613b226ac425a20068240gpp').displayname()
```

Your browser does not support the HTML5 video element

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

* * *

## Related content

-   [Work With Groups](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups)
-   [Javadocs \[Groovy\] Class Users](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/users/Users.html)
-   [Javadocs methods summary (User)](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/users/User.html)
