# Display Last Comment in Wiki Rendered Styled Custom Field

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-convert-wiki-rendered-comment-onPrem
- Source: https://examples.scriptrunner.io/scripts/convert-wiki-rendered-comment-onPrem

## Overview

This script highlights the last comment posted on an issue in a script field. The field renders wiki formatting
(bold, italics, underline etc).

## Example

As a developer working on a new project with a large number of issues, I must ensure I'm working with the most
up-to-date information. Therefore, it's useful to have the latest comment highlighted, so I don't have to spend time
navigating the comment history and potentially work from out of date information. Using this script, I can display
the most recent comment in a script field where it is easily visible.

## Good to Know

* Use 'Text Field (Multi-line)' as the template for the custom script field and 'Free Text Searcher' as the searcher.
* This script is based on [Show Last Comment for an Issue](https://library.adaptavist.com/entity/show-last-comment-for-an-issue).

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.RendererManager
import com.atlassian.jira.issue.fields.renderer.IssueRenderContext
import com.atlassian.jira.issue.fields.renderer.wiki.AtlassianWikiRenderer

def rendererManager = ComponentAccessor.getComponent(RendererManager)
def renderContext = new IssueRenderContext(issue)
def commentManager = ComponentAccessor.commentManager
def comment = commentManager.getLastComment(issue)

if (comment) {
    rendererManager.getRenderedContent(AtlassianWikiRenderer.RENDERER_TYPE, comment.body, renderContext)
}
```

