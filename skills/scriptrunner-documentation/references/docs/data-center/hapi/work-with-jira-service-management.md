# Work with Jira Service Management

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888210
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-jira-service-management

You can easily set Jira Service Management fields such as **Customer Request Type**, **Request participants**, and **Organizations**. They are standard _custom fields_ pre configured by the JSM app. You can modify these fields by setting custom field values on an issue, as previously discussed on the [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields) page:

```
Issues.create('JSD', 'Service Request') {
    setSummary('help me!')
    setRequestParticipants('anuser', 'otheruser')
    setRequestType('New employee')
    setOrganizations('Acme Corp', 'Other Corp')
    setRequestChannel('api')
}
```

![Image showing you how to work with JSM](/sr4js/files/latest/442888210/442888226/1/1758746921000/Work_with_JSM.png)

## Adding comments in Jira Service Management

By default all comments created in Jira Service Management projects are **publicly** visible, meaning they will be visible in the customer portal view.

### Adding an internal comment to an issue

To create an internal comment, call the `internal()` method within the comment creation closure:

```
Issues.getByKey('SR-100').addComment('An internal comment') {
    internal()
}
```

### Adding an internal comment while updating an issue

Internal comments can also be added when transitioning or updating an issue:

```
Issues.getByKey('SR-100').transition('Start progress') {
    setComment('An internal comment') {
        internal()
    }
}
```

![Image showing you how to add an internal comment while updating an issue](/sr4js/files/latest/442888210/442888213/1/1758746921000/Adding_internal_comment_while_updating_issue.png)

### Checking the visibility of comments

An extension method `isPublic()` is provided for checking the comment visibility of existing comments:

In this example we're checking the public visibility of the last comment of an issue.

```
Issues.getByKey('SR-100').comments.last().isPublic()
```

## Retrieving the customer request type

You can access the customer request type using the `requestType` extension method:

```
Issues.getByKey('SR-100').requestType
```

The `requestType` extension method will return a [com.atlassian.servicedesk.api.requesttype.RequestType](https://docs.atlassian.com/jira-servicedesk/4.9.0/com/atlassian/servicedesk/api/requesttype/RequestType.html) instance that allows you to retrieve more properties of the request type. For example, if you want to retrieve the name of the request type:

```
Issues.getByKey('SR-100').requestType.name
```

## Working with approvals

Workflows in Jira Service Management may use [approvals](https://confluence.atlassian.com/servicemanagementserver/5-add-approvals-to-your-workflow-1082527843.html). You can programatically mark items as approved or rejected using HAPI, through extension methods on `Issue`.

### Adding approvers to an issue

Using HAPI you can add approvers to an issue. 

In the following example we create an issue with two approvers. We previously updated the workflow so all approvers are required to approve the issue before it can be transitioned.

```
            def issue = Issues.create('SR', 'Service Request with Approvals') {
                setRequestType('Purchase over $100')
                
                // note: in this case ALL approvers are required to approve
                setCustomFieldValue('Approvers', 'admin', 'anuser') 
                setSummary('I want to buy a...')
                setDescription('... Colin the Caterpillar cake')
            }
```

 

![Image showing how to add approvers to an issue using HAPI](/sr4js/files/latest/442888210/442888228/1/1758746921000/Approvals_add_approvers.png)

### Approving an issue

You can approve an issue as follows:

```
            issue.approve()
```

After executing this code, one user (current logged in user) has approved.

#### Approving an issue as another user

To execute an approval as another user, you need to run in the customer context and `runAs` that user:

```
            ServiceDesk.runAsCustomer {
                Users.runAs('anuser') {
                    issue.approve()
                }
            }
```

### Rejecting an issue

You can reject an issue as follows:

```
            issue.reject()
```

### Checking if an issue can be approved or rejected

The same user cannot approve if they have already approved. Additionally you can't approve or reject an issue when it's current status doesn't require an approval decision.

To check if an issue can be approved or rejected, you can use the following: 

The following script considers the current user and returns `true` or `false` depending on whether the user can currently approve or reject the issue.

```
            issue.canAnswerApproval()
```

If this script returns `false` and you attempt to approve or reject anyway, an exception is thrown.

### Retrieving approvals

Let's say you want to retrieve the approval decision for an issue, and for that decision whether each approver has accepted or rejected. You can access the [Approval](https://docs.atlassian.com/jira-servicedesk/5.5.0/com/atlassian/servicedesk/api/approval/Approval.html) list from any `Issue`. 

You can look at the last approval for an issue as follows:

You may have multiple approval steps in your workflow, which is why `issue.getApprovals()` returns a `List<Approval>` . Typically however, you will have only one approval step.

```
            import com.atlassian.servicedesk.api.approval.ApprovalDecisionType
            
            def approval = issue.approvals.last()
            def approvers = approval.approvers

            assert approvers*.approverUser*.name == ['anuser', 'admin']
            assert approvers*.approverDecision.every { it.orElse(null) == ApprovalDecisionType.APPROVED }
```

If you don't want the last approval, then you can look up the correct approval by [status ID](https://docs.atlassian.com/jira-servicedesk/5.5.0/com/atlassian/servicedesk/api/approval/Approval.html#getStatusId--).

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/implementation/JiraServiceDeskExtensionsImpl.html)
-   [Work with Epics, Stories and Sprints](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-epics-stories-and-sprints)
-   [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)
