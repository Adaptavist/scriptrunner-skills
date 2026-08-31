# Jira Agile

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-101624776
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/jira-agile

This page gives some guidance on how to use ScriptRunner to work with _Jira Agile_, or TAFKAG (the add-on formerly known as Greenhopper).

As well as @PluginModule, ScriptRunner provides an annotation specifically for retrieving a spring bean from Jira Agile…​ so, to get the [RapidViewService](https://docs.atlassian.com/greenhopper/6.3.2.1/com/atlassian/greenhopper/service/rapid/view/RapidViewService.html) (for finding and create boards), you would use:

```
@JiraAgileBean
RapidViewService rapidViewService
```

  

This works in a way very similar to _@WithPlugin_ in [Scripting Other Plugins](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps).

### Examples

#### List and Create Boards

Here is a more full example of using the rapid view service, which lists the names of the current boards, and creates a new one based on the "scrum" preset (the other preset you can use is _kanban_).

[https://gist.github.com/jechlin/9787666](https://gist.github.com/jechlin/9787666)

#### Adding Additional Column Info

A blog posting which details how to query columns on a board, in order to sum up an issue field: [https://community.atlassian.com/t5/Agile-articles/Adding-column-information-to-planning-boards/ba-p/619186](https://community.atlassian.com/t5/Agile-articles/Adding-column-information-to-planning-boards/ba-p/619186)

#### List Configured Projects

This was originally an AAC [question](https://answers.atlassian.com/questions/256352/how-to-use-the-groovy-script-runner-to-list-agile-projects), which asked how to programmatically list the projects that were enabled for Jira Agile. Here is the code, rewritten in the new style:

[https://gist.github.com/jechlin/9788064](https://gist.github.com/jechlin/9788064)

#### Add Issue to Current Sprint on Transition

This will add the current issue to the current active sprint on an action, say _Start Progress_. I do not necessarily recommend this as a good practice (scope of sprint should not change after it begins), but certainly it saves a lot of clicks.

Note: probably not production ready code. Also there is now a configurable [built-in post-function](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts) to add and remove from sprint.

[https://gist.github.com/jechlin/9789183](https://gist.github.com/jechlin/9789183)
