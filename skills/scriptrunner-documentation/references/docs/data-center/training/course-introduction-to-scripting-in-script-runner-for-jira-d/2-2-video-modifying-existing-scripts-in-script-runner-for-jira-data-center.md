# 2.2 Video: Modifying Existing Scripts in ScriptRunner for Jira Data Center

- Platform: data-center
- Space: SR4JS
- Hierarchy: Training > Course: Introduction to Scripting in ScriptRunner for Jira Data Center
- Doc ID: doc-sr4js-f4d6a1be-ce08-4015-8bb7-d60cc72e7a67-373a404f44d21b5b
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center/2.2-video-modifying-existing-scripts-in-scriptrunner-for-jira-data-center

[Media](https://player.vimeo.com/video/622521090?h=8c8b3e5abd)

The scripts in the video above can be simplified with [HAPI](../../uncategorized/h/hapi.md). For example, using HAPI, the script to search for select issues and replace the custom field value is as follows:

```
Issues.search("project = GAV AND issuetype = 'Tour Build D' AND 'VT Type D' = 'Deep Sea'").each { issue ->
    issue.update {
        setCustomFieldValue('VT Type D') {
            replace('Deep Sea', 'Special')
        }
    }
    log.warn(issue.key)
}
```

See the HAPI documentation for more information on [searching for issues](https://docs.adaptavist.com/sr4js/latest/hapi/search-for-issues) and [updating fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields).

|  |  |  |
| --- | --- | --- |
| [Previous](2-1-video-groovy-basics-for-script-runner-data-center.md) |  | [Next](2-3-video-introduction-to-atlassian-java-api.md) |
