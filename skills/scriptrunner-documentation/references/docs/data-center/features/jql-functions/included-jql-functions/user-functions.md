# User Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-101624217
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions

## memberOfRole

Returns issues where the value of a user field is a member of the given role.

For example, to find issues where the _Reporter_ is a member of the _Administrators_ role:

```
issueFunction in memberOfRole("Reporter", "Administrators")
```

If you want to find issues where the value may be a member of several roles, you can add multiple role arguments:

```
issueFunction in memberOfRole("Reporter", "Administrators", "Developers", "Agents")
```

  

This is equivalent to using separate clauses joined with **OR**, but will be more performant.

You can use this function with all _User_ fields, e.g. reporter, creator, assignee, single or multiple user custom fields, and script fields that return users.

You should include a clause that will restrict the number of projects. For example:

```
project = SUP and issueFunction in memberOfRole('Approvers', 'Service Desk Team')
```

  

If you do not include project clauses, there is a possibility that if you have a large number of projects each having a large number of role memberships, the function will fail.

If this is the case, add project clauses like `project = SUP` or `project in (SUPA, SUPB)` to restrict the number of projects.

## inactiveUsers

Returns users that have been marked _Inactive_. For example, to find issues that have been assigned to users that have left the organization:

```
assignee in inactiveUsers()
```

  

(This assumes you have a working "leavers" process).

You can use this function with all _User_ fields, e.g. reporter, creator, assignee, single or multiple user custom fields, and script fields that return users.

If you want find issues assigned to active users, you can just invert the query above:

```
assignee not in inactiveUsers()
```

  

## jiraUserPropertyEquals

```
jiraUserPropertyEquals(property name, property value)
```

This function returns active and inactive users with a matching property value. For example, to find all issues assigned to users in the _AMER_ region:

```
assignee in jiraUserPropertyEquals("region", "AMER")
```

  

This assumes you have set properties on users. This can be done either programmatically, or via the UI at Admin → Users, then click on the user, then Actions → Edit Properties.

So the example from the query above would return this user (and others):

![](/sr4js/files/latest/101624217/101628610/1/1601034911000/edit-user-props.png)

If you set properties programmatically, note that only _string_ properties are supported.

Also, unfortunately, only administrators can view user properties - vote for: [JRA-11990](https://jira.atlassian.com/browse/JRA-11990).

The intention was originally that one could query users by LDAP attributes, for example _office_, _location_ or _manager_ etc. However Jira cannot sychronize arbitrary attributes from LDAP, vote for [JRA-24332](https://jira.atlassian.com/browse/JRA-24332).

As part of a fix in ScriptRunner 6.42.0, the behaviour of the jiraUserPropertyEquals() JQL function has changed. Previously, only active users would match when jiraUserPropertyEquals() was used, now both active and inactive users are returned. If you depend on the old behaviour of only matching active users,  add a `not in inactiveUsers()` condition to your query. For example:

```
 reporter in jiraUserPropertyEquals('region', 'EMEA') and reporter not in inactiveUsers()
```
