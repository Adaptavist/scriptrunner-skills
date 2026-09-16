# Show Parent Issue in Hierarchy

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Script fields > Built-In Script Fields
- Doc ID: doc-sr4js-350a6d04-9857-469e-8999-98454a58fed4-72d46c6967362e1a
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-fields--en#built-in-script-fields--en#show-parent-issue-in-hierarchy--en

Use the Show Parent Issue in Hierarchy to create a custom script field that displays an issue's _parent_, where you define what _parent_ means. This script field is particularly useful for [Advanced Roadmaps for Jira](https://confluence.atlassian.com/jirasoftwareserver/discover-advanced-roadmaps-for-jira-1044784153.html) users, although this feature is not limited to just Advanced Roadmaps.

For example, we have the following Advanced Roadmaps [hierarchy](https://confluence.atlassian.com/jiraportfolioserver/configuring-initiatives-and-other-hierarchy-levels-802170489.html):

1.  Theme
2.  Initiative
3.  Epic
4.  Story
5.  Sub-task

You can use this script field to display the _Theme_ issue type in all issue types below it in the hierarchy. We provide detailed steps on this below when explaining how to [use this script field](https://docs.adaptavist.com/sr4js/latest/features#using-this-script-field--en).

Note: You can also query on this field, but it's more effective to use [portfolioChildrenOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio#portfoliochildrenof--en).

## Target issue type

The target issue type is the parent whose children will become targets for the script field.

## Parent navigators

For each parent navigator chosen, this script field will attempt to find the current issue's parent using that method. We then continue to the next parent, and so on, until the desired issue type is found. For example, if we want every issue type below _Theme_, as shown in the hierarchy above, we would select the following _Parent navigators_:

-   The _Subtask Parent_ navigator for Subtasks.
-   The _Epic-Story_ navigator for Epics and Stories.
-   The Portfolio Parent extractor for Themes and Initiatives.

In cases where multiple navigators return a parent, the first one in the list will display.

## Using this script field

For the example below we use the hierarchy mentioned above. We want all issues to display the very highest parent issue in the hierarchy, which in this case is _Theme_.

1.  From ScriptRunner, select the Fields tab.
2.  Select Create Script Field.
3.  Select Show parent issue in hierarchy.
4.  Enter the name for the script field. In this example we enter _Theme_.
5.  Optional: Enter a description. In this example we enter _Theme this issue belongs to_.
6.  Optional: Aadd a field note. This is to help you identify your script field when viewing them all on the Fields tab.
7.  Select a Target Issue Type. In this example we select Theme.
8.  Select relevant Parent navigators. In this example we select Portfolio Parent, Links: Epic-Story Links, and Subtask Parent.
9.  Optional: Enter an issue key and select Preview to preview this script field.
10.  Select Add.
     
11.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

You can now test to see if this script field works as expected when added to your chosen project issues.

## Related content

-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
-   [Built-In Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields)
-   [Script Field Tips](https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tips)
