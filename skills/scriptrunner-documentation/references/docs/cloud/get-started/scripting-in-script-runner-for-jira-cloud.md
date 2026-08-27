# Scripting in ScriptRunner for Jira Cloud

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started
- Doc ID: doc-sr4jc-106338456
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud

## Overview

ScriptRunner for Jira Cloud domain allowlist

We advise all customers with a Cloud firewall to ensure that access to the \*.[connect.product.adaptavist.com](http://connect.product.adaptavist.com/ "http://connect.product.adaptavist.com") wildcard URL is permitted. You can refer to [Use IP Addresses](https://docs.adaptavist.com/sr4jc/latest/manage-app/use-ip-addresses) for more details.

ScriptRunner for Jira Cloud allows you to extend the functionality of Jira Cloud, executing scripts to interact with Jira as [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules) or [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners). Scripts can be useful for automating regular actions, such as updating a work item during a transition or performing a calculation and storing the result in a custom field on the work item.

Outlined below are the various programming languages used for scripting and their associated [features](https://docs.adaptavist.com/sr4jc/latest/features) within ScriptRunner for Jira Cloud:

Feature

Groovy

Jira Expressions

Typescript/Javascript

JQL

HTML

CSS

[Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours)

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

[Built-in Scripts](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts)

  

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

[Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search)

  

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

[Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

  

[Script Console](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

  

[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

  

[Script Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments)

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

  

[Workflow Extension: Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

[Workflow Extension: Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

  

[Workflow Extension: Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

  

Script Variables

Scripting is not used for this [feature](https://docs.adaptavist.com/sr4jc/latest/features/script-variables); it utilises two fields to add a variable which you can call out in other scripts, such as password.

### Groovy

Utilising the [Groovy programming language](http://www.groovy-lang.org/), you can respond to events and transitions and manipulate Jira using the [REST API](https://docs.adaptavist.com/sr4jc/latest/manage-app/rest-apis). Additionally, you can use the [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) feature to run [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) in Jira Cloud and create filters for dashboards and scrum boards that use those functions.

Scripts using the [Groovy](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-intermediate-users/2-3-module-introduction-to-groovy-for-scriptrunner-cloud) language include [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields), [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), and [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs). Check out our [HAPI](https://docs.adaptavist.com/sr4jc/latest/hapi) section on updating your scripts to make them more manageable.

### Typescript/Javascript

ScriptRunner for Jira Cloud uses Typescript/Javascript for the [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) feature, and the [Script Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments) feature uses Javascript.

### Jira expressions

[Jira expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) are used for [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) along with some script execution conditions. Check out our [Example Restrict Transitions and Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators).

### JQL

A [JQL](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) query is required for the [bulk clone work items](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-clone-work-items) built-in script, and a filter (created from JQL) for the [bulk fix resolution](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-fix-resolutions) built-in script.

Example scripts

Check out our extensive list of ScriptRunner for Jira Cloud examples scripts on the [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

## HAPI

HAPI is an API used for carrying out common tasks in Jira. These can include managing or searching for work items, updating fields and more. HAPI s essentially plain Groovy, but it gives you a simpler alternative to Jira's regular API and you can mix and match HAPI calls with Jira API. 

HAPI **does not require** you to [rewrite existing scripts](https://docs.adaptavist.com/sr4jc/latest/hapi/rewrite-scripts-with-hapi). However, should you wish to make your current scripts more manageable then you might want to update them to use HAPI. Read all about it in our [HAPI](https://docs.adaptavist.com/sr4jc/latest/hapi) section.

## Code editor

Use the code editor to write scripts in ScriptRunner. The code editors use an intelligent code editor. The browser-based code editor provides code completions, inline Javadoc lookups, inline find and replace, and error line indication. This editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Automatically available variables

Keyboard shortcuts warning

Keyboard shortcuts may not work depending on other system-defined shortcuts.

### Completions

The code editor automatically displays suggestions as you type. Suggestions are filtered as you type, so only relevant options are displayed. Use the **arrow keys** and **Enter** or **Tab** to select a suggestion. You can manually trigger completions with **Control+Space**.

![](/sr4jc/files/latest/106338456/448136406/1/1760364461000/completions1.png)

When referring to a class, the code editor automatically adds the required import.

![](/sr4jc/files/latest/106338456/448136405/1/1760364511000/completions2.png)

To save typing, use camel case abbreviations.

#### Smart completions 

Press **Ctrl+Alt+Space** to show a list of completions that match the expected type of assignment or parameter type.

![](/sr4jc/files/latest/106338456/448136404/1/1760364573000/completions3.png)

### Parameters 

When typing method parameters, it is easy to forget the expected types. Parameter types and, where possible, names are shown for the given method. Use the up/down cursor keys to scroll through any available overloads.

Press **Control+Shift+Space** to view parameters when inside a method.

![](/sr4jc/files/latest/106338456/246186688/1/1711382594000/code_editor_5.png)

### Javadoc

The code editor can help you understand the purpose of classes, methods, and properties by loading the associated Javadoc. The Javadoc is shown in the editor as a pop-up. To view the Javadoc, press **Control+Space** with completions open. It will be displayed automatically from then on. To close it, press **Control+Space** again. 

![](/sr4jc/files/latest/106338456/246186689/1/1711382594000/code-editor-6.png)

### Find and replace

You can use the code editor to find and replace in the code editor. To access find and replace, press **⌘+F** (Mac) or **Ctrl+F** (Windows).  
To search for text, enter it in the _Find_ field. To access find and replace, press **Option+****⌘+F** (Mac) or either **Ctrl+H** or **Alt+Ctrl+F** (Windows). 

![](/sr4jc/files/latest/106338456/448136403/1/1760364627000/completions4.png)

### Error line indicator

Errors in your script are highlighted in the right-hand panel of the script editor. Errors are highlighted inline, on the scroll bar, and in the right-hand overview ruler. When you have located an error, hover over the error with the cursor to see a summary.

![](/sr4jc/files/latest/106338456/448136402/1/1760364670000/completions5.png)

### Full-screen editing

To open the script editor in full screen, click the icon ![](/sr4jc/files/latest/106338456/246186684/1/1711382595000/fullscreen.jpg) or press **F11** when the cursor is in the editor. To exit the full screen, press **F11** or Esc twice when the cursor is in the editor. 

### Restrictions

The code editor has some limitations; work is ongoing to reduce these limitations. As mentioned, Javadoc for Bamboo APIs and ScriptRunner’s API (e.g. Behaviours) are unavailable. However, completions and parameter hints are available for all.
