# 1.2 Video: Using Behaviours in ScriptRunner for Jira Data Center/Server

- Platform: data-center
- Space: SR4JS
- Hierarchy: training > course-introduction-to-scriptrunner-for-jira-data-center-server
- Doc ID: doc-sr4js-442886836
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server

For a written tutorial on behaviours, see the [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial) page. 

&amp;amp;amp;amp;lt;p&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;br/&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;/p&amp;amp;amp;amp;gt;

The scripts in this video can be found in the tabs below:

```
def desc = getFieldById("description")
  
def defaultValue = """\
        h3. Depending on the tour type, don't forget to use the type specifics below:
        * Use tour type specific assets
        * Use tour type specific filter
        * Highlight tour type specific ambience
        * Use tour type specific text templates
         
        h3. Don't forget to update your Dev Playbook after each QA Failure.
       
    """.stripIndent()
  
if (!desc.formValue) {
    desc.setFormValue(defaultValue)
}
```

```
def qaBrokenLinksField = getFieldByName("QA Broken Links")
def failReasonField = getFieldById(getFieldChanged())
 
def selectedOption = failReasonField.getValue() as String
def isBrokenLinksSelected = selectedOption == "broken links"
 
qaBrokenLinksField.setHidden(! isBrokenLinksSelected)
qaBrokenLinksField.setRequired(isBrokenLinksSelected)
```

[Downloadable Resources](https://app.box.com/s/47f30js565h3w4n0nib2j6smopjyneqr) [🇩🇪 Deutsche Version](https://www.youtube.com/watch?v=j8oVrtQizNs)

[Previous](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-1-video-introduction-to-scriptrunner-for-jira-data-center-server) [Next](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-3-video-using-listeners-in-scriptrunner-for-jira-data-center-server)
