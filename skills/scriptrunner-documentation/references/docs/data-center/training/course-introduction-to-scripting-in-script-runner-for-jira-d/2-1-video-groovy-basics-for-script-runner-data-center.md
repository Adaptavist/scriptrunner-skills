# 2.1 Video: Groovy Basics for ScriptRunner Data Center

- Platform: data-center
- Space: SR4JS
- Hierarchy: Training > Course: Introduction to Scripting in ScriptRunner for Jira Data Center
- Doc ID: doc-sr4js-16b80333-b705-465b-af9f-aaf9b5fa8335-5c892e9e7bfe022d
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center/2.1-video-groovy-basics-for-scriptrunner-data-center

Note: For more information on scripting, check out the [HAPI](../../uncategorized/h/hapi.md) documentation and our [Best Practices](../../uncategorized/b/best-practices.md) section.

[Media](https://player.vimeo.com/video/622520706?h=3d5b8e0d98)

The script in the video above can be simplified with [HAPI](../../uncategorized/h/hapi.md). For example, using HAPI, the script to return the value of a custom field in an issue is as follows:

```
def issue = Issues.getByKey('GAV-15')

issue.getCustomFieldValue('Reason for QA Fail')

def value = issue.getCustomFieldValue('Reason for QA Fail')

if (value) {
    return value
}
else {
    return "There is no value in this field on the chosen issue"
}
```

See the HAPI documentation for more information on [reading custom fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields#custom-fields--en).

|  |  |  |
| --- | --- | --- |
| [Previous](../course-introduction-to-scripting-in-script-runner-for-jira-data-center.md) |  | [Next](2-2-video-modifying-existing-scripts-in-script-runner-for-jira-data-center.md) |
