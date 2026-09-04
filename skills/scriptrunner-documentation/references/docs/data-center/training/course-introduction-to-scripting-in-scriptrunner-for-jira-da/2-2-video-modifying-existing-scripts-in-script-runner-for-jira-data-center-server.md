# 2.2 Video: Modifying Existing Scripts in ScriptRunner for Jira Data Center/Server

- Platform: data-center
- Space: SR4JS
- Hierarchy: training > course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server
- Doc ID: doc-sr4js-443372229
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-2-video-modifying-existing-scripts-in-scriptrunner-for-jira-data-center-server

&amp;amp;amp;amp;lt;p&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;br/&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;/p&amp;amp;amp;amp;gt;

  

* * *

The scripts in the video above can be simplified with [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi). For example, using HAPI, the script to search for select issues and replace the custom field value is as follows:

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

* * *

  

[Downloadable Resources](https://app.box.com/s/4mu2h1pgv34q5fkp8928kwfklzjablyz)

[Previous](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-1-video-groovy-basics-for-scriptrunner-data-center-server) [Next](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-3-video-introduction-to-atlassian-java-api)
