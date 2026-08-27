# Comment Selected Linked Issues

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, workflow
- Language: groovy
- Doc ID: example-dataCenter-comment-linked-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/comment-linked-issues-onPrem

## Overview

Automatically leave comments on specified linked issues. Also, filter the issues by issue type, linked issue type, or link type.

## Example

I have a workflow set up with multiple issues. However, I have set this up, so certain issues must be completed before work on other issues can be started. I need to notify the assignees when they can begin working on their issues, so this script automatically comments on the issues when they can be started.

## Good to Know

* You can choose the author of the comment.
* You can select the user group or project role visibility of the comment.
* You can decide whether to trigger a comment notification or not.  
* You can install this script in a custom listener or a post function.
* If the script is used as `post-function` or `listener` the line `def issue = ComponentAccessor.issueManager.getIssueByCurrentKey("JRA-1")`
  can be removed, as the `issue` variable is implicit in both environments.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.link.IssueLink
import com.atlassian.jira.security.roles.ProjectRoleManager

def issue = ComponentAccessor.issueManager.getIssueByCurrentKey("JRA-1")

boolean filterIssueTypes = true //Set this to false if you want this script to run on every Issue Types
List<String> issueTypes = ["Story", "Task"] //The List of Issue Types we want to work to get a comment from
boolean filterLinkedIssueTypes = true //Set this to false to leave a comment on any Linked Issue Types
List<String> linkedIssueTypes = ["Story", "Task"] //The list of the Linked Issue Types we want to leave a comment on
boolean filterLinkTypes = true //Set this to false to leave a comment on any Link Types
List<String> linkTypes = ["Blocks", "Relates"] //The list of Link Type you want this script to work on
String visibilityGroup = null //The visibility of the comment using Group name. Leave null for public. Valid Example: "jira-administrators"
String visibilityRole = null //The visibility of the comment using ProjectRole name //Leave null for public. Valid Example : "Administrators"
String commentBody = "This is a comment from ${issue.key}" //The Body of the comment that will be left
String commentAuthor = "currentUser" //currentUser will be the current user, But you can enter any username if you want to select a service account here
boolean dispatchEvent = true //Set this to false if you do not want your comment to generate a notification

if (issue.issueType.name in issueTypes || !filterIssueTypes) {
    def issueLinkManager = ComponentAccessor.issueLinkManager
    issueLinkManager.getOutwardLinks(issue.id).each { IssueLink issueLink ->
        if (issueLink.issueLinkType.name in linkTypes || !filterLinkTypes) {
            def destinationIssue = issueLink.destinationObject
            if (destinationIssue.issueType.name in linkedIssueTypes || !filterLinkedIssueTypes) {
                createComment(destinationIssue, commentAuthor, commentBody, visibilityGroup, visibilityRole, dispatchEvent)
            }
        }
    }
}

void createComment(Issue linkedIssue, String author, String body, String visibilityGroup, String visibilityRole, boolean dispatchEvent) {
    try {
        def roleLevelId
        def authorUser = (author == "currentUser") ? ComponentAccessor.jiraAuthenticationContext.loggedInUser : ComponentAccessor.userManager.getUserByName(author)
        if (visibilityRole) { //Getting the Role Level id for the Selected ProjectRole if any
            def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
            roleLevelId = projectRoleManager.getProjectRole(visibilityRole)?.id
        }
        def commentManager = ComponentAccessor.commentManager
        commentManager.create(linkedIssue, authorUser, body, visibilityGroup, roleLevelId, dispatchEvent)
    }
    catch (e) {
        log.error("Error in creating a comment with message ${e.message}")
    }
}
```

