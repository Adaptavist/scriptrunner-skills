# Show Parent Issue in Hierarchy

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-441364484
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/show-parent-issue-in-hierarchy

Use the Show Parent Issue in Hierarchy to create a custom script field that displays an issue’s _parent_, where you define what _parent_ means. This script field is particularly useful for [Advanced Roadmaps for Jira](https://confluence.atlassian.com/jirasoftwareserver/discover-advanced-roadmaps-for-jira-1044784153.html) users, although this feature is not limited to just Advanced Roadmaps. 

For example, we have the following Advanced Roadmaps [hierarchy](https://confluence.atlassian.com/jiraportfolioserver/configuring-initiatives-and-other-hierarchy-levels-802170489.html):

1.  Theme
    
2.  Initiative
    
3.  Epic
    
4.  Story
    
5.  Sub-task
    

You can use this script field to display the _Theme_ issue type in all issue types below it in the hierarchy. We provide detailed steps on this below when explaining how to [use this script field](http://docs.adaptavist.com#steps).

You can also query on this field, but it’s more effective to use [portfolioChildrenOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions).

## Target issue type

The target issue type is the parent whose children will become targets for the script field.

## Parent navigators

For each parent navigator chosen, this script field will attempt to find the current issue's parent using that method. We then continue to the next parent, and so on, until the desired issue type is found. For example, if we want every issue type below _Theme_, as shown in the hierarchy above, we would select the following _Parent navigators_:

-   The _Subtask Parent_ navigator for **Subtasks**. 
-   The _Epic-Story_ navigator for **Epics** and **Stories**. 
-   The Portfolio Parent extractor for **Themes** and **Initiatives**.

![Image of selected parent navigators](/sr4js/files/latest/441364484/441364488/1/1740415463000/Parent_navigators.png)

In cases where multiple navigators return a parent, the first one in the list will display.

## Using this script field

For the example below we use the hierarchy mentioned above. We want all issues to display the very highest parent issue in the hierarchy, which in this case is _Theme_. 

1.  From **ScriptRunner**, select the **Fields** tab.
2.  Select **Create Script Field**.
3.  Select **Show parent issue in hierarchy**.
4.  Enter the name for the script field. In this example we enter _Theme_. 
5.  Optional: enter a description. In this example we enter _Theme this issue belongs to_.
6.  Optional: add a field note. This is to help you identify your script field when viewing them all on the **Fields** tab.
7.  Select a **Target Issue Type**. In this example we select **Theme**. 
8.  Select relevant **Parent navigators**. In this example we select **Portfolio Parent**, **Links: Epic-Story Links**, and **Subtask Parent**.
9.  Optional: enter an issue key and select **Preview** to preview this script field.
10.  Select **Add**.  
     ![Example of this script field completed](/sr4js/files/latest/441364484/441364487/1/1740417183000/Show_parent_in_hierarchy.png)
11.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.  
     
     You can now test to see if this script field works as expected when added to your chosen project issues. 
     
     ![GIF showing all issues with a Theme field](/sr4js/files/latest/441364484/441364486/1/1740417659000/Show_parent_in_hierarchy_gif.gif)
     

  

* * *

## Related content

-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
-   [Built-In Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields)
-   [Script Field Tips](https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tips)
