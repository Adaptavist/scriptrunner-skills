# A listener to monitor for project role changes and notify users via a Slack message

- Platform: data-center
- Feature: listeners
- Tags: automate, administer
- Language: groovy
- Doc ID: example-dataCenter-project-role-monitoring-slack-listener-onPrem
- Source: https://examples.scriptrunner.io/scripts/project-role-monitoring-slack-listener-onPrem

## Overview

Use this listener with the 'ProjectRoleUpdatedEvent' to send a Slack message when someone adds a certain group name or a group with more than a given number of users to a project role.

## Example

When a user adds a group to a project role I want to check the group name and the number of users in that group.
If the name matches a certain group or the number of users in that group is over a specific threshold, send a message to a Slack channel to make users aware of these changes so they can validate them before any notifications are sent out.

**NOTE**

The `userThreshold`, `groups`, `slackConnectionName` and `slackChannelName` variables must be populated.

You must add a Slack connection within the ScriptRunner resources section before using this script.

## Description

#### Overview

Use this listener with the 'ProjectRoleUpdatedEvent' to send a Slack message when someone adds a certain group name or a group with more than a given number of users to a project role.

#### Example

When a user adds a group to a project role I want to check the group name and the number of users in that group.
If the name matches a certain group or the number of users in that group is over a specific threshold, send a message to a Slack channel to make users aware of these changes so they can validate them before any notifications are sent out.

**NOTE**

The `userThreshold`, `groups`, `slackConnectionName` and `slackChannelName` variables must be populated.

You must add a Slack connection within the ScriptRunner resources section before using this script.

## Script

```groovy
import com.atlassian.crowd.embedded.api.Group
import com.atlassian.jira.security.roles.ProjectRoleActor
import com.atlassian.jira.security.roles.actor.GroupRoleActorFactory.GroupRoleActor
import com.onresolve.scriptrunner.parameters.annotation.GroupPicker
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
import com.onresolve.scriptrunner.slack.SlackUtil

@ShortTextInput(label = 'Group users threshold', description = 'Enter alert threshold for number of users in a group')
final String userThreshold

@GroupPicker(label = 'Groups', description = 'Select the groups you want to alert on', multiple = true)
final List<Group> groups

@ShortTextInput(label = 'Slack connection', description = 'Enter the name of your slack connection')
final String slackConnectionName

@ShortTextInput(label = 'Slack channel name', description = 'Enter the name of the slack channel to send to')
final String slackChannelName

def newGroupRoleActors = (event.roleActors.roleActors - event.originalRoleActors.roleActors).findAll {
    it.type == ProjectRoleActor.GROUP_ROLE_ACTOR_TYPE
} as List<GroupRoleActor>

newGroupRoleActors.each {
    if ((it.users.size() >= Integer.parseInt(userThreshold)) || (it.group.name in groups*.name)) {
        def slackMessage = """
            Project Role Change Violation!
            Group '${it.group.name}' was added to the '${event.projectRole.name}' role in the '${event.project.name}' project.
        """.stripIndent()

        SlackUtil.message(slackConnectionName, slackChannelName, slackMessage)
    }
}
```

