# Warn on Issue Details Screen when Issue Is Unassigned

- Platform: data-center
- Feature: script-fragments
- Tags: extend, issue
- Language: groovy
- Doc ID: example-dataCenter-warn-on-issue-unassigned-onPrem
- Source: https://examples.scriptrunner.io/scripts/warn-on-issue-unassigned-onPrem

## Overview

Use the following script in a ScriptRunner *Show Web Panel* to display a warning message on the issue details screen
if the issue is unassigned.

## Example

I am a project manager. I want all issues have a assignee user who perform that issue. With this script I can see a
warning message when some issue is unassigned

## Good to Know

* The *Location* must be set as `atl.jira.view.issue.right.context`. You can see more information about location in this web:
    (https://developer.atlassian.com/cloud/jira/platform/issue-view-ui-locations/)
  * The *Condition* required on web panel config page is `!issue.assignee`

## Script

```groovy
writer.write ("""
    <div class="aui-message aui-message-error error shadowed" style="color: black;">
        <p class="title">Warning!</p>
        <p>This issue is not assigned to anyone.</p>
    </div>
""")
```

