# Show Assignee History on Issue Details Page

- Platform: data-center
- Feature: script-fragments
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-show-assignee-history-onPrem
- Source: https://examples.scriptrunner.io/scripts/show-assignee-history-onPrem

## Overview

Use a ScriptRunner *Web Panel* to display a record of all users who were assigned to the issue.

## Example

I am a team leader. There is an issue in the 'in progress' status for a long period of time, and I want to see which
team members have participated in it. With this script, I can see which members have been assigned to the issue.

## Good to Know

* The *Location* must be set as `atl.jira.view.issue.right.context`

## Script

```groovy
import com.atlassian.jira.avatar.AvatarService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.issue.Issue
import groovy.xml.MarkupBuilder

import java.time.format.DateTimeFormatter
import static com.atlassian.jira.issue.IssueFieldConstants.ASSIGNEE

// the upper limited on the assignees to be displayed
final historyDepth = 5

def issue = context.issue as Issue
def counter = 0

def baseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)
def avatarService = ComponentAccessor.getComponent(AvatarService)
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

new MarkupBuilder(writer).table {
    ComponentAccessor.changeHistoryManager.getChangeHistories(issue).reverseEach {
        def changeItems = it.changeItems

        if (changeItems.field.first() == ASSIGNEE && changeItems.newstring.first() && counter < historyDepth) {
            def user = ComponentAccessor.userManager.getUserByKey(changeItems.newvalue[0] as String)
            def format = DateTimeFormatter.ofPattern('dd/MMM/yyyy')
            def date = it.timePerformed.toLocalDateTime().toLocalDate()

            tr {
                td(
                    style: 'width: 90px;', date.format(format)
                )
                td(
                    class: 'jira-user-name user-hover jira-user-avatar jira-user-avatar-small',
                    rel: 'admin', 'id': 'project-vignette_admin',
                    style: 'margin: 1px 0px 1px 0px; height: 24px;',
                    href: "$baseUrl/secure/ViewProfile.jspa?name=$user.name"
                ) {
                    span(
                        class: 'aui-avatar aui-avatar-small'
                    ) {
                        span(
                            class: 'aui-avatar-inner'
                        ) {
                            img(
                                src: avatarService.getAvatarURL(loggedInUser, user),
                                alt: user.name
                            )
                        }
                    }
                }
                td(
                    user.displayName
                )
            }
        }

        counter++
    }
}
```

