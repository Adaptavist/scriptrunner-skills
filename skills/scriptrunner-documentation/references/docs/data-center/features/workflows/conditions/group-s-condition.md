# Group(s) Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Conditions
- Doc ID: doc-sr4js-3529040a-ddc4-48d0-b07c-7b0a750eda64-cc96693113f33d2f
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#conditions--en#groups-condition--en

Use the _Group(s)_ condition to control whether or not a user can transition an issue based on their [group memberships](https://confluence.atlassian.com/adminjiraserver/managing-groups-938847035.html).

There are two ways to use this condition, depending on whether you choose to invert the condition or not:

-   Normal: The transition is allowed if the current user is a member of any group(s) specified.
-   Inverted: The transition is allowed if the current user is not a member of any group(s) specified.

For example:

-   You only want members of the _Finance Team_ group to be able to transition a ticket to _Account Paid._
-   You do not want members of the _Finance Team_ to be able to transition a ticket to _Approved for Payment._

## Use this condition

You can add this condition to any transition except the _Create_ transition.

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a condition to.
3.  Select the transition to which you wish to add a condition.
4.  Under Options, select Conditions.
    
5.  On the _Transition_ page, select Add condition.
6.  Select Group(s) condition.
    
7.  Optional: Enter a note that describes the condition.
8.  Select the Groups you want to use to restrict the transition.
    
    Tip: Users who are members of at least one of these groups can transition the issue unless the Invert condition option has been selected. If the condition is inverted, all users apart from those who are members of at least one of these groups can transition the issue.
    
9.  Optional: Select Invert Condition.
    
    CAUTION: For Jira servers and projects which allow anonymous users to view and transition issues:
    
    -   If the condition is not inverted, anonymous users are always blocked from transitioning the issue.
    -   If the condition is inverted, anonymous users are allowed to transition the issues.
    
10.  Select Update.
11.  Select Publish and choose if you want to save a backup copy of the workflow.
     

## Security breach review example

You can use this condition to ensure separation of duties, for example, when reviewing a security breach.

In this task force are three teams: _DevOps, Stakeholders,_ and _Security_. The review has four workflow statuses:

1.  To investigate
2.  Under investigation
3.  In review
4.  Closed

You could use this workflow condition to restrict the transition of issues as follows:

To investigate > Under investigation - Restricted to _DevOps_ team.

Under investigation > In review - Restricted to _DevOps_ and _Security_ teams.

In review > Closed - Restricted to _Security_ team.

Closed > any state - Restricted to _Stakeholders_ and _Security_ teams.

In review > Under investigation - Not allowed by _DevOps_ team.

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Project Role(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-roles-condition)
-   [Simple Scripted Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)
