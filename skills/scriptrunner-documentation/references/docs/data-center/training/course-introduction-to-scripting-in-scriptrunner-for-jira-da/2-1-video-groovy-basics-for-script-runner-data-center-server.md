# 2.1 Video: Groovy Basics for ScriptRunner Data Center/Server

- Platform: data-center
- Space: SR4JS
- Hierarchy: training > course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server
- Doc ID: doc-sr4js-443372231
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-1-video-groovy-basics-for-scriptrunner-data-center-server

For more information on scripting, check out the [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi) documentation and our [Best Practices](https://docs.adaptavist.com/sr4js/latest/best-practices) section.

&amp;amp;amp;amp;lt;p&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;br/&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;/p&amp;amp;amp;amp;gt;

  

* * *

The script in the video above can be simplified with [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi). For example, using HAPI, the script to return the value of a custom field in an issue is as follows:

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

See the HAPI documentation for more information on [reading custom fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields#customfields). 

* * *

  

[Downloadable Resources](https://app.box.com/s/tcqftm1j33b71sdx2hozqwh5x5dlu6of)

[Previous](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server) [Next](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-2-video-modifying-existing-scripts-in-scriptrunner-for-jira-data-center-server)
