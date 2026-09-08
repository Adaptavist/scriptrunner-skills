# Portfolio

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-442889278
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio

The functions on this page are only available if [Advanced Roadmaps for Jira](https://confluence.atlassian.com/jirasoftwareserver/discover-advanced-roadmaps-for-jira-1044784153.html) (previously known as _Portfolio for Jira)_ is installed. 

A full reindex is required after first installing the version of ScriptRunner containing Advanced Roadmaps. If you do not reindex, the functions on this page will only show results for issues updated from that point.

Before you try the JQL functions on this page you may want to try [searching for issues using Advanced Roadmaps details](https://confluence.atlassian.com/advancedroadmapsserver/searching-for-issues-using-advanced-roadmaps-details-940678957.html?_ga=2.85822041.1122233798.1684742643-1501883802.1680605612). 

## portfolioChildrenOf

```
portfolioChildrenOf(Subquery)
```

Get the portfolio/roadmaps child issues matched by the subquery.

### portfolioChildrenOf examples

For the examples below the following [hierarchy](https://confluence.atlassian.com/jirasoftwareserver/configure-your-jira-software-instance-1044784156.html#ConfigureyourJiraSoftwareinstanceforAdvancedRoadmaps-CustomHierarchyLevelsARJ) is assumed:

1.  Themes
    
2.  Initiative
    
3.  Epic
    
4.  Story
    

`portfolioChildrenOf(Subquery)` finds all children in a portfolio/roadmap hierarchy. This function does not bridge the gap from _Epic_ to _Story,_ so, with the above hierarchy, it only finds initiatives and epics that have a parent with the status of 'To Do.'

Please note that the status of the child issues could be anything; due to the subquery, this search is only looking at the status of the parent issue type.

#### Find all initiatives that belong to _Themes_ with the status 'To Do'

```
issueFunction in portfolioChildrenOf("status = 'To Do'") and issuetype = Initiative
```

#### Find all children of parents with the status 'To Do'

```
issueFunction in portfolioChildrenOf("status = 'To Do'")
```

To also find stories you could combine multiple functions:

1.  Create and save the above function as a _Children of Themes_ filter_._
2.   Use the `[issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuesInEpics)` function to also find the stories of the epics:
    
    ```
filter = "Children of Themes" or issueFunction in issuesInEpics('filter = "Children of Themes"')
```
    

#### **Find high-level issue types that have not been properly placed in a structure**

To search for initiatives that don't belong to any _Themes_:

```
issueFunction not in portfolioChildrenOf("issuetype = Theme") and issuetype = Initiative
```

## portfolioParentsOf

```
portfolioParentsOf(Subquery)
```

Get the portfolio/roadmaps parent issues matched by the subquery.

### portfolioParentsof examples

For the examples below the following [hierarchy](https://confluence.atlassian.com/jirasoftwareserver/configure-your-jira-software-instance-1044784156.html#ConfigureyourJiraSoftwareinstanceforAdvancedRoadmaps-CustomHierarchyLevelsARJ) is assumed:

1.  Themes
    
2.  Initiative
    
3.  Epic
    
4.  Story
    

Like `portfolioChildrenOf`, `portfolioParentsof` does not cross the boundary from Story to Epic, this is due to conflicting feature functionality. If you performed a search of `issueFunction in portfolioParentsOf("status = 'To Do'")` using the hierarchy above, the results would display themes and initiatives that have a child issue with the status of 'To Do.' If you added another issue type between _Themes_ and _Initiative_, then issues of this type would also display if they have child issues with the status of 'To Do'.

#### **Find all themes of unresolved epics**

```
issueFunction in portfolioParentsOf("issuetype = Epic and resolution is empty") and issuetype = Themes
```

#### **Find issue types that have no children**

To search for any _Themes_ that have no children (notice the **not in**)**:**

The following query looks for all _Themes_ that are not the parent of an _Initiative_.

```
issueFunction not in portfolioParentsOf("issuetype = Initiative") and issuetype = Themes
```

If you want to start from _Stories_, you need to create a combination of queries and use the `[epicsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#epicsOf)` ScriptRunner JQL query. For example, to search for open _Initiatives_ of closed _Stories_:

```
issueFunction in portfolioParentsOf('issueFunction in epicsOf("issuetype = Story and status = Done")') and issuetype = Initiative and resolution is empty
```

For complex subqueries, you may want to [save a seperate search as a filter](https://confluence.atlassian.com/jirasoftwareserver/saving-your-search-as-a-filter-939938748.html?_ga=2.24030842.1122233798.1684742643-1501883802.1680605612) and then use [Jira's filter field](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html#Advancedsearchingfieldsreference-filterFilter) to reference it. For example:

```
issueFunction in portfolioParentsOf('filter = "Your Saved Filter"') and issuetype = Initiative and resolution is empty
```
