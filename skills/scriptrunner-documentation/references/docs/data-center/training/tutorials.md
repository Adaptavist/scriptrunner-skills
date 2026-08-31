# Tutorials

- Platform: data-center
- Space: SR4JS
- Hierarchy: training
- Doc ID: doc-sr4js-442886800
- Source: https://docs.adaptavist.com/sr4js/latest/training/tutorials

## Who are these tutorials for?

These tutorials are for Jira administrators who don’t know how to write Groovy code, but want to use ScriptRunner to automate and improve their Jira instance. The goal of these tutorials is to break down the barrier-to-entry for ScriptRunner and help you see what it can do and how easy it is to use.

## About our tutorials

To make the most of these tutorials, you don’t need any scripting experience, but you should feel comfortable creating and managing issues, building workflows, and working with Jira administration functions. In these tutorials, you can learn about some of the main functions of ScriptRunner and how to use them.

## What we don’t cover

While we mention areas where you can use custom scripts, along with some tips on using custom script options, **we don’t teach any Groovy in this course.** This course focuses more on the business user or administrator who doesn’t have, or necessarily need, scripting knowledge, so **we don’t teach you how to write scripts**.

While available to ScriptRunner users, this course also doesn’t include using the [REST API](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints). For coverage on topics we can’t cover, we recommend visiting the dedicated [Features](https://docs.adaptavist.com/sr4js/latest/features) page in our documentation.

## Great Adventure

During these tutorials, you will notice a reference to Great Adventure.

### What is Great Adventure?

Great Adventure is the fictitious company we use to help provide use cases and examples of concepts covered. Great Adventure is a company that organizes specialized holidays for the discerning tourist.

Great Adventure has the same problems and issues faced by most companies. Great Adventure needs to automate more of its process using ScriptRunner, especially in their Virtual Tour and Finance teams. For instance, issues are sometimes raised that are not resolved in an appropriate time period. Obviously, management wishes to be able to identify these issues more readily and have them escalated. 

## Important things to remember

### Use a staging or test environment

You should avoid working in your production environment for testing because **ScriptRunner loosens the Jira reins just enough to be** **dangerous**. We recommend that you test ScriptRunner functionality in a staging or test environment until proven to work.

### Caution with recursive searches

You must also be careful with recursive searches, as they can stop Jira. To avoid this happening:

-   Provide a subquery in your search to help limit results.
    
-   Use a limited version of JQL functions to ensure you don’t go too far and can't find your way back.
    

### Caution with Groovy scripts

We recommend that you are careful when you use groovy scripts found on the Internet. Make sure your script comes from a reputable source, such as our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts).

Make sure you have a look at the rest of our documentation. It contains discussions regarding efficiency, performance, and comparisons between differing approaches. Read it carefully during the planning stage, before you attempt to run something you are not 100% sure of.

Not sure how to navigate to ScriptRunner? Visit the _[Navigation](https://docs.adaptavist.com/sr4js/latest/get-started/navigation)_ guide.

## Before you start

This initial tutorial guides you through creating a sample project, finding ScriptRunner within Jira, and creating resources you will need for later activities.

### Create a sample project

Walk through the following steps to create a sample project you can use for the rest of the tutorials:

You have the option to create a scrum software development project or a process management project.

1.  From the top ribbon, select **Projects**, and then select **Create Project**.
    
2.  In the _Create Project_ window, select **Create Sample Data** at the bottom of the window.
    
    ![The Create Sample Data option highlighted in the Create Project screen.](/sr4js/files/latest/442886800/442886803/1/1758746741000/CreateProject.png)
3.  Choose the type of project you want to create, and then select **Next**.
    
    We recommend you create a **Scrum software development** project or a **Project management** project for these activities.
    
4.  Enter your **Name**, **Key**, and **Project Lead** details.
    
5.  Select **Submit** to create your project.
    

Voila! You get a project created with sample data so you can work with different scenarios in the labs. In this example, we created a Scrum software development project called Demonstration Project Scrum, and we see issues in a sample sprint and the backlog of the project.

![An example Backlog for the newly created project.](/sr4js/files/latest/442886800/442886808/1/1758746741000/example.png)

### Review _Manage Apps_ page

In this quick activity, you access the ScriptRunner app to view information. Knowing where to go for this information is important if you are managing ScriptRunner or need to contact Adaptavist support for help with ScriptRunner.

1.  From the **Administration** menu, select **Add-ons**.
    
2.  On the _Manage Apps_ page, under _Atlassian Marketplace_, click **Manage Apps**.
    
3.  Under _User-Installed Apps_, click to expand **Adaptavist ScriptRunner for Jira**. Review information about ScriptRunner. This information includes versions, license details, links to documentation, and modules enabled.
    

### (Optional) Create resources for activities

This exercise ensures that you have the resources needed for different activities if you plan to complete all the tutorials. If you want to follow the instructions but use your own data, you can do so.

 

Activity

Resources Needed

Aggregate JQL Search

Create four issues with work logged and remaining estimates.

Script Condition - All Sub-Tasks Must be Resolved

Create an issue with a few sub-tasks. Example:

Main Issue: Upgrade Server Subtasks:

-   Identify current state and desired state on server
    
-   Perform upgrade
    
-   Test upgrade and confirm state is correct
    

Script Post-Function - Assign an Issue for Review

Create a workflow that includes:

-   _Upgraded_ as a status, replacing the _Resolved_ status before _Done_.
    
-   _Upgrade Issue_ transition
    

This workflow needs to be associated with the correct project as well. In our example, we use the Virtual Tour Server Management project.

Create a Simple Behaviour

Create a custom field called **Customer Type (Select List)** with the following options:

-   Small Business - For-Profit
    
-   Large Business - For-Profit
    
-   General Training License
    

Create a Select List with Other

Create a two custom fields:

1.  Favorite Fruit - Select List
    
    -   Apples
        
    -   Bananas
        
    -   Other
        
2.  Favorite Fruit (Other) - Single Line Text Field
    

Fast-track transition an issue

Create workflow that includes some type of review status. This could be:

-   Review
    
-   In Review
    
-   Waiting for Approval
    

## Let's get started!

After you have finished the activities above you are ready to get started with the rest of the tutorials:

-   [Built-in Scripts Tutorial](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/built-in-scripts-tutorial)
-   [Listeners Tutorial](https://docs.adaptavist.com/sr4js/latest/features/listeners/listeners-tutorial)
-   [Script Field Tutorial](https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tutorial)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
-   [Script Fragments Tutorial](https://docs.adaptavist.com/display/_PK/SR4JS/fragments-tutorial)
