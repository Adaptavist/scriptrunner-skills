# Show Last Comment for an Issue

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-show-last-comment-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/show-last-comment-issue-onPrem

## Overview

This script displays the last comment posted on an issue in a script field.

## Example

As a developer working on a new project with a large number of issues, I must ensure I'm working with the most up-to-date information. 
Therefore, it's useful to have the latest comment highlighted, so I don't have to spend time navigating the comment 
history and potentially work from out of date information. 
Using this script, I can display the most recent comment in a script field where it is easily visible.

## Good to Know

* Use `Text Field (Multi-line)` as the template for the custom script field and 'Free Text Searcher' as the searcher.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def comments = issue.comments
if (comments) {
    def rendererManager = ComponentAccessor.getRendererManager()
    def fieldLayoutManager = ComponentAccessor.getFieldLayoutManager()
    def fieldLayoutItem = fieldLayoutManager.getFieldLayout(issue).getFieldLayoutItem('comment')
    def renderer = rendererManager.getRendererForField(fieldLayoutItem)
    renderer.render(comments.last().body, null)
}
```

