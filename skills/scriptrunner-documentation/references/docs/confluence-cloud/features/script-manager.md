# Script Manager

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-a831aa06-74f9-4ab1-9944-90dd2f696034-155d5ceacc83dc0f
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-manager

The Script Manager allows saved scripts and folders to be directly managed from the ScriptRunner front end.

## What is the Script Manager?

The Script Manager feature in ScriptRunner for Confluence Cloud allows you to manage saved `.groovy` scripts and folders directly from the ScriptRunner front-end. It enables you to create, edit, save, delete, and rename scripts and folders within your instance without relying on FTP services or server administrators.

With Script Manager, you can easily reuse and organize scripts in any of the Groovy code editors across your instance, making script management more efficient and accessible.

For example, if you had the same conditional code across multiple scripts and needed to update that condition, you previously had to make the change in several places. With Script Manager, you can write the code once and reuse it wherever needed. When it's time to update it, you modify it in one place, and the change is automatically reflected across all occurrences.

## Create scripts and folders

1.  Navigate to ScriptRunner > Script Manager.
2.  Click Add Folder or Add Script. Refer to [Script Manager Naming Rules](https://docs.adaptavist.com/sr4cc/latest/features/script-manager/script-manager-naming-rules) for details on rules, limitations, and more.
    
    Note: If a folder is selected, the new script or folder is created within that folder.
    
3.  Enter a name in the text box displayed. If you are adding code to a new script file, refer to [Add a new script](https://docs.adaptavist.com/sr4cc/latest/features/script-manager#script-manager-add-a-new-script--en).
4.  Click Save.
    
    A new `.groovy` script file or folder is added, as shown in the example below:
    
    You can reference the newly created script when using any of the code editors provided within many ScriptRunner for Confluence Cloud features.
    
    See [How to reuse scripts](https://docs.adaptavist.com/sr4cc/latest/features/script-manager#how-to-reuse-scripts--en) for details on reusing saved scripts.
    
    It's also possible to rename a script or saved folder within Script Manager.
    

## Add a new script

To add a new script:

1.  Navigate to ScriptRunner > Script Manager.
2.  Click Add Script.
3.  Enter a name for the new script in the text box displayed.
4.  Enter the script code for the new script within the code editor.
5.  Optional: (Optional) Click Example Scripts to view a list of example scripts.
    1.  Choose an example script from the list provided, and the code automatically appears. You also have the option to search for a particular script.
    2.  Click Copy Code and then Close.
    3.  Paste the copied code in the code editor.
6.  Click Save.
    
    A new `.groovy` script file is added which you can reuse in the Groovy code editors, as outlined in [Script Manager](script-manager.md).
    

## Edit existing scripts

To edit saved `.groovy` scripts:

1.  Navigate to ScriptRunner > Script Manager.
2.  Locate the `.groovy` script you wish to edit from the left-hand file navigator.
    
    The `.groovy` script displays in the code editor window.
    
3.  Edit the code within the code editor, as required.
    
    You can also rename the script, if needed, adhering to the [Script Manager Naming Rules](https://docs.adaptavist.com/sr4cc/latest/features/script-manager/script-manager-naming-rules).
    
    When editing code, Script Manager provides you with:
    
    -   Autocompletions, with suggested methods, classes, and variables appearing as you type.
    -   Real-time error checking and syntax highlighting for Groovy, making it easy to identify different code elements such as keywords, variables, and comments.
    
    Tip: If you are working on a script that you intend to reuse in a [Script Listener](script-listeners.md) or another feature that relies on script context variables, Script Manager has no way of knowing that, so some of the type checking may fail. In this case, you can declare the variable with a placeholder value at the top of the script and then replace it with the correct context variable before saving.
    
4.  Click Save when you have finished editing.
    
    Changes are not saved automatically. When there are unsaved changes, the Save button is displayed.
    

## Delete scripts and folders

To delete `.groovy` script files and folders:

1.  Navigate to ScriptRunner > Script Manager.
2.  Right click the script file or folder you want to delete.
3.  Click Delete from the pop-up menu.

Important: Things to remember when deleting scripts and folders

-   When a folder is deleted, all script files within it are also deleted, and it will be unavailable for reuse in all Groovy code editors.
-   If a script stored in Script Manager is used by another ScriptRunner feature, such as a Script Listener or Script Job, and the script is deleted from Script Manager, the dependent feature will fail to run.
-   Error logs will indicate that a file cannot be found. These logs reference the script's UUID, which does not directly indicate the original file path.

## How to reuse scripts

You can reuse scripts saved in _Script Manager_ in any of the Groovy code editors within ScriptRunner for Confluence Cloud. This includes:

-   [Script Console](script-console.md)
-   [Script Jobs](script-jobs.md)
-   [Script Listeners](script-listeners.md)
-   [Macros](macros.md)

As an example, let's choose to create a new Script Job.

1.  Navigate to ScriptRunner > Script Jobs.
2.  Click Create Script Job.
3.  Enter the details required to [create a new Script Job](script-jobs.md).
4.  Navigate to the code editor.
    
    You will see the Load button, as shown in the example below:
    
5.  Click the Load button.
    
    A new window opens displaying all saved scripts:
    
6.  Select the script you want to reuse.
7.  Click Load Script, and your chosen script is now available in the Script Jobs code editor.
    
    Note: As this is a saved script that is ready to be reused, you are automatically shown the script in read-only mode.
    
8.  Optional: Modify the saved script if necessary, as follows:
    
    1.  Change the newly loaded script by choosing either:
        
        -   Edit inline - make changes directly within the Scheduled Jobs code editor.
        -   Edit source - open the script in Script Manager and edit it there.
        
    2.  Click Save as and give the modified script a new name.
        
        This creates a new reusable script without overwriting the original.
        
    
    Tip: Check where your scripts are used
    
    In Script Manager, you can view your saved script files and identify exactly where they are configured in your ScriptRunner for Jira Cloud instance. This includes details on the location and number of configurations where your scripts are loaded.
    
    For example, say you have a file that you set up to be loaded within the configuration of two Script Listeners, you can review that file's usage details. Click the Script Usage drop-down list, and a summary of all configurations loading that script displays. Scroll through the feature categories showing where that file is in use and choose the Script Listeners, as shown below:
    

### Reuse scripts by importing reusable Groovy code

You can import reusable `.groovy` code into existing or new scripts, and you can create `.groovy` classes or scripts to organise shared logic. This allows you to structure your code into classes and packages, and to import scripts directly where needed.

ScriptRunner leverages [Groovy's program structure](https://docs.groovy-lang.org/4.0.28/html/documentation/core-program-structure.html#_scripts_versus_classes), which allows for importing and reusing code from classes and scripts. ScriptRunner treats the code stored in Script Manager as a `.groovy` codebase, and all Groovy scripts in ScriptRunner have contextual awareness of the code in Script Manager. This means that if you are writing the same function for two Script Listeners and duplicating the code in both places, you can instead place that logic in a utility script or class in Script Manager, then import and reuse it wherever you need it.

#### Example of code reuse using classes

LinkUtils.groovy

`package utils` - In Groovy, a package reflects the parent folder structure of the code's location. The package helps Groovy identify a class, and you need to reference it when importing code into your scripts. For example, you can see how we imported the code for reuse using the following statement: `import utils.LinksUtils`

Warning: If your reusable class or script is placed in the default package, the root of the Script Manager directory structure, as shown with the class `PrintFormatter.groovy` in the Script Manager codebase screenshot above, you cannot import and reuse that code in other scripts or classes that belong to named packages.

#### Example of code reuse using scripts

Groovy also allows us to [import and reuse scripts](https://docs.groovy-lang.org/4.0.28/html/documentation/core-program-structure.html#_scripts_versus_classes) without the need to declare classes. There are multiple options for doing this.

reusablescript.groovy

A simple Groovy script that defines a method that takes an argument called `name` and returns a greeting.

```
package com.myapp.simplescripts
 
println "Script loaded!"
def greet(name) { "Hello, $name!" }
```

Importing and reusing a part of the script:

```
import com.myapp.simplescripts.reusablescript
 
def script = new reusablescript()
script.greet('Admin')
```

Note: Package note

The package path must match your directory structure: `com/myapp/simplescripts/reusablescript.groovy`. You will need to provide the package structure when organizing scripts for reuse via imports. The original bolding that was applied to this entire note was dropped during conversion. Watch for other instances of missing bold that you may want to restore.

You can call specific methods declared in the script, or you can use Run to run the entire script. Using a script works similarly to using a class because, in the background, each `.groovy` file automatically becomes a class you can instantiate.
