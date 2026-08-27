# Update Jira Announcement Banner

- Platform: data-center
- Feature: script-console
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-update-jira-announcement-banner-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-jira-announcement-banner-onPrem

## Overview

System Administrators have access to edit [Announcement Banner](https://confluence.atlassian.com/adminjiraserver/configuring-an-announcement-banner-938846985.html).
This script allow the system admin to automatically set the Announcement banner.

## Example

As a system admin, I would like to automatically apply the Announcement banner for our monthly patch every month.

## Good to Know

* If you need to remove the Announcement Banner, you can simply run the script with empty string for the 'announcementText' variable.

## Script

```groovy
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.web.action.admin.EditAnnouncementBanner

def applicationProperties = ComponentAccessor.applicationProperties

def announcementText = """
<div style="background-color: lightyellow; border: 3px solid darkred; margin: 4px; padding: 2px; font-weight: bold; text-align: center;">
Maintenance Notification: This Jira environment will be offline today Wed Jan 21 from 12:15 to 12:30 GMT for a monthly patch.
</div>
"""

applicationProperties.setText(APKeys.JIRA_ALERT_HEADER, announcementText)
applicationProperties.setString(APKeys.JIRA_ALERT_HEADER_VISIBILITY, EditAnnouncementBanner.PRIVATE_BANNER)
```

