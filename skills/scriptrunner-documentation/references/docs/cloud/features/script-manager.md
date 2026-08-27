# Script Manager

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-433029520
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-manager

![](/sr4jc/files/latest/433029520/480378909/1/1763375027000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#behaviours)** **overview.**

## Before you start

![](/sr4jc/files/latest/433029520/480378908/1/1763375194000/Copy+of+sr-icon-mortar-board.png)

[Watch Script Manager Videos](https://www.youtube.com/embed/v9wPmA8nVVY?si=fy9uyEAIU1bkq8Kf)

## What is the Script Manager?

The Script Manager feature in ScriptRunner for Jira Cloud allows you to manage saved `.groovy` and `.jel` scripts and folders directly from the ScriptRunner front-end. It enables you to create and manage scripts and folders within your instance without relying on FTP services or server administrators.

With Script Manager, you can easily reuse and organize scripts in any of the Groovy and Jira Expression Language code editors across your instance, making script management more efficient and accessible.

For example, if you had the same logic across multiple scripts and needed to update such scripts, you previously had to make the change in several places. With Script Manager, you can write the code once and reuse it wherever needed. When it’s time to update it, you modify it in one place, and the change is automatically reflected across all occurrences.

## Create folders

To add a new folder, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
    
2.  Click **Create Folder**. 
    
    If an existing folder is selected, the new folder is created within that folder. 
    
3.  Enter a name for the new folder in the text box, as prompted. Refer to [Script Manager Naming Rules](https://docs.adaptavist.com/sr4jc/latest/features/script-manager/script-manager-naming-rules) for details on rules, limitations, and more.
    
4.  Click **Save,** and the new folder is added, as shown in the example below:
    
    ![](/sr4jc/files/latest/433029520/585204094/1/1784726480000/create+folder+SM.png)

## Create scripts

To add a new script, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
    
2.  Click **Create Script**. 
    
3.  Select from either the `.goovy` or `.jel` options, as required.
4.  Enter a name for the new script in the text box, as prompted. Refer to [Script Manager Naming Rules](https://docs.adaptavist.com/sr4jc/latest/features/script-manager/script-manager-naming-rules) for details on rules, limitations, and more.
5.  Enter the script code for the new script within the code editor.
6.  **(Optional)** Click **Example Scripts** to view a list of example scripts.
    1.  Scroll through the list provided, or search for a particular script.
    2.  Choose an example script, and the code automatically appears. 
    3.  Click **Copy Code** and then **Close**.
    4.  Paste the copied code in the code editor.
7.  Click **Save**. A new script file is added, which you can reuse in the Groovy and Jira Expression Language code editors, as outlined in [How to reuse scripts](#id-.ScriptManagervCurrent-reusescripts).

## Edit existing scripts 

To edit saved `.groovy` or `.jel` scripts, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
2.  Locate the `.groovy` or `.jel` scripts you wish to edit from the left-hand file navigator. Once selected, the script displays in the code editor window.
3.  Edit the code within the code editor, as required. When editing code, Script Manager provides you with:
    
    -   Autocompletions, with suggested methods, classes, and variables appearing as you type.
        
    -   Real-time error checking and syntax highlighting making it easy to identify different code elements such as keywords, variables, and comments. 
        
        If you are working on a script that you intend to reuse in a [Script Listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) or another feature that relies on [script context](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/bindings-and-parameters) variables, Script Manager has no way of knowing that, so some of the type checking may fail. In this case, you can declare the variable with a placeholder value at the top of the script and then replace it with the correct context variable before saving.
        
4.  **(Optional)** [Rename](#id-.ScriptManagervCurrent-renamescript) the modified script, if needed, adhering to the [Script Manager Naming Rules](https://docs.adaptavist.com/sr4jc/latest/features/script-manager/script-manager-naming-rules).
5.  Click **Save** when you have finished editing. Changes are not saved automatically. When there are unsaved changes, the **Save** button is displayed.

## Rename existing scripts and folders

To rename an existing script or folder, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
2.  Locate the `.groovy` or `.jel` script or folder you wish to rename from the left-hand file navigator.
3.  Right-click the chosen script file or folder.
4.  Click **Rename** from the pop-up menu. You are prompted to read and confirm the conditions associated with renaming scripts and folders. Shown below is an example of the script renaming dialog:  
    ![](/sr4jc/files/latest/433029520/545427744/1/1776852853000/rename+script.png)
5.  Enter the new name. Ensure that you adhere to the [Script Manager Naming Rules](https://docs.adaptavist.com/sr4jc/latest/features/script-manager/script-manager-naming-rules).
6.  Check the **I Understand** tickbox and click **Rename**. You will see a message informing you that your renamed script or folder has successfully saved.

## Move existing scripts and folders

To move an existing script and/or folder, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
2.  Locate the `.groovy` or `.jel` script or folder you wish to move from the left-hand file navigator.
3.  Right-click the chosen script file or folder.
4.  Click **Move** from the pop-up menu. Shown below is an example of the script moving dialog:  
    ![](/sr4jc/files/latest/433029520/545427743/1/1776853090000/move+script.png)
5.  Choose the new location for the script or folder. Ensure that you note the warning message associated with moving scripts and folders.
6.  Click **Move script** or **Move folder**. You will see a message informing you that the move has successfully saved.

## Duplicate existing scripts

To duplicate an existing script, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
2.  Locate the `.groovy` or `.jel` script you wish to make a copy of from the left-hand file navigator.
3.  Right-click the chosen script file.
4.  Click **Duplicate** from the pop-up menu. A confirmation message appears informing you that your script has been copied, noting the following:  
    1.  The duplicated script is added to the left-hand navigator.
    2.  The new copy has _\_Copy_ added to the script name.
    3.  You have the option to click **Undo** from the confirmation message, if required. 

## Delete scripts and folders

To delete script files and/or folders, follow these steps:

1.  Navigate to **ScriptRunner > Script Manager**.
2.  Locate the `.groovy` or `.jel` script or folder you wish to delete from the left-hand file navigator.
3.  Right-click the chosen script file or folder.
4.  Click **Delete** from the pop-up menu.
    

-   When a folder is deleted, all script files within it are also deleted, and it will be unavailable for reuse in all Groovy and Jira Expression Language code editors.
-   If a script stored in Script Manager is used by another ScriptRunner feature, such as a Script Listener or Scheduled Job, and the script is deleted from Script Manager, the dependent feature will fail to run.
-   Error logs will indicate that a file cannot be found. These logs reference the script’s UUID, which does not directly indicate the original file path.

## How to reuse scripts

### Reuse scripts in the UI

You can reuse scripts saved in _Script Manager_ in the Groovy and Jira Expression Language code editors within ScriptRunner for Jira Cloud. This includes the following features:

Feature

.groovy scripts

.jel scripts

[Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) (conditions only)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

[Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Workflow Rules (Perform Actions)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

[Workflow Rules (Validate Details)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

[Workflow Rules (Restrict Transition)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) 

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) 

The Script Manager feature is not available for use with Behaviours.

As an example, let's choose to create a new Scheduled Job.

1.  Navigate to **ScriptRunner > Scheduled Jobs**.
2.  Click **Create Scheduled Job**.
3.  Enter the details required to [create a new Schedule Job](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs#id-.ScheduledJobsvCurrent-createscheduledjob).
4.  Navigate to the code editor. You will see the **Load** button, as shown in the example below:  
    ![](https://docstest.adaptavist.com/download/attachments/422707893/load%20button.png?version=1&modificationDate=1762428855000&api=v2)
5.  Click the **Load** button. A new window opens displaying all saved scripts:  
    ![](https://docstest.adaptavist.com/download/attachments/422707893/load%20script.png?version=1&modificationDate=1762429055000&api=v2)
6.  Select the script you want to reuse.
7.  Click **Load Script,** and your chosen script is now available in the Scheduled Jobs code editor.  
    
    As this is a saved script that is ready to be reused, you are automatically shown the script in read-only mode.
    
8.  **(Optional)** Modify the saved script if necessary, as follows:
    1.  Change the newly loaded script by choosing either:
        1.  **Edit inline** - make changes directly within the Scheduled Jobs code editor.
        2.  **Edit source** - open the script in Script Manager and edit it there.
    2.  Click **Save as** and give the modified script a new name. This creates a new reusable script without overwriting the original.
        
        Script usage: check where your scripts are used
        
        In Script Manager, you can view your saved script files and identify exactly where they are configured in your ScriptRunner for Jira Cloud instance. This includes details on the location and number of configurations where your scripts are loaded.
        
        For example, say you have a file that you set up to be loaded within the configuration of two Script Listeners, you can review that file's usage details. Click the **Script Usage** drop-down list, and a summary of all configurations loading that script displays. Scroll through the feature categories showing where that file is in use and choose the Script Listeners, as shown below:
        
        ![](/sr4jc/files/latest/433029520/578720220/1/1786617906000/loaded+by+groovy+configs.jpg)
        
        You can check scripts that have been loaded for the following features: [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs), [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service), and [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields). 
        

### Reuse scripts by importing reusable Groovy code

You can import reusable `.groovy` code into existing or new scripts, and you can create `.groovy` classes or scripts to organise shared logic. This allows you to structure your code into classes and packages, and to import scripts directly where needed.

ScriptRunner leverages [Groovy’s program structure](https://docs.groovy-lang.org/4.0.28/html/documentation/core-program-structure.html#_scripts_versus_classes), which allows for importing and reusing code from classes and scripts. ScriptRunner treats the code stored in Script Manager as a `.groovy` codebase, and all Groovy scripts in ScriptRunner have contextual awareness of the code in Script Manager. This means that if you are writing the same function for two Script Listeners and duplicating the code in both places, you can instead place that logic in a utility script or class in Script Manager, then import and reuse it wherever you need it.

#### Example of code reuse using classes

##### LinkUtils.groovy

This class contains a utility method that will search all work items in a given space and summarize the key and number of blockers against each work item that is blocked.

```
package utils 
class LinksUtils {
    static Map<String, Integer> getBlockedItemsByProject(String project) {
        Issues.search("project = ${project}").collectEntries {
            def blockers = it.getLinks().findAll {  it.type.inward == 'is blocked by'}.collect()
            return [(it.key) : blockers.size()]
        }.findAll {
            key, value -> value as int > 0
        }
    }
}
```

**![](/sr4jc/files/latest/433029520/480378906/1/1763981127000/linkutils.groovy.png)**

We can use the above code in a script as follows:

```
import utils.LinksUtils

LinksUtils.getBlockedItemsByProject('DEMO')
```

![](/sr4jc/files/latest/433029520/480378905/1/1763981310000/script+manager+import.png)

`package utils` - In Groovy, a package reflects the parent folder structure of the code's location. The package helps Groovy identify a class, and you need to reference it when importing code into your scripts. For example, you can see how we imported the code for reuse using the following statement: `import utils.LinksUtils`

If your reusable class or script is placed in the default package, the root of the Script Manager directory structure, as shown with the class `PrintFormatter.groovy` in the Script Manager codebase screenshot above, you cannot import and reuse that code in other scripts or classes that belong to named packages.

#### Example of code reuse using scripts

Groovy also allows us to [import and reuse scripts](https://docs.groovy-lang.org/4.0.28/html/documentation/core-program-structure.html#_scripts_versus_classes) without the need to declare classes. There are multiple options for doing this.

##### reusablescript.groovy

A simple Groovy script that defines a method that takes an argument called `name` and returns a greeting.

```
package com.myapp.simplescripts

println "Script loaded!"
def greet(name) { "Hello, $name!" }
```

![](/sr4jc/files/latest/433029520/480378904/1/1763981461000/reusable.png)

Importing and reusing a part of the script:

```
import com.myapp.simplescripts.reusablescript

def script = new reusablescript()
script.greet('Admin')
```

![](/sr4jc/files/latest/433029520/480378903/1/1763981624000/import+and+reuse.png)

Package note

The package path must match your directory structure: `com/myapp/simplescripts/reusablescript.groovy`. You will need to provide the package structure when organizing scripts for reuse via imports.

You can call specific methods declared in the script, or you can use `.run()`to run the entire script. Using a script works similarly to using a class because, in the background, each `.groovy` file automatically becomes a class you can instantiate.
