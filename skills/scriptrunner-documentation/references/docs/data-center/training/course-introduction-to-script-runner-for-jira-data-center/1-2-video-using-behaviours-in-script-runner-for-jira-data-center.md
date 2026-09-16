# 1.2 Video: Using Behaviours in ScriptRunner for Jira Data Center

- Platform: data-center
- Space: SR4JS
- Hierarchy: Training > Course: Introduction to ScriptRunner for Jira Data Center
- Doc ID: doc-sr4js-7abf9bc6-114a-4c74-83be-4f6a312dc40d-058b2d0381467f56
- Source: https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center/1.2-video-using-behaviours-in-scriptrunner-for-jira-data-center

Note: For a written tutorial on behaviours, see the [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial) page.

[Media](https://player.vimeo.com/video/622519189?h=173b5e84f1)

Initialiser script:

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

Add Field script:

```
def qaBrokenLinksField = getFieldByName("QA Broken Links")
def failReasonField = getFieldById(getFieldChanged())

def selectedOption = failReasonField.getValue() as String
def isBrokenLinksSelected = selectedOption == "broken links"

qaBrokenLinksField.setHidden(! isBrokenLinksSelected)
qaBrokenLinksField.setRequired(isBrokenLinksSelected)
```

[🇩🇪 Deutsche Version](https://www.youtube.com/watch?v=j8oVrtQizNs)

|  |  |  |
| --- | --- | --- |
| [Previous](1-1-video-introduction-to-script-runner-for-jira-data-center.md) |  | [Next](1-3-video-using-listeners-in-script-runner-for-jira-data-center.md) |
