# Script Editor

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-101624782
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-editor

## What is the Script Editor?

Manage your .groovy script files and folders using the ScriptRunner _Script Editor_. Reuse and share scripts across an instance without the need for FTP services or server administrators. 

## How to use the Script Editor

With the _Script Editor_, you can create, edit, move, save, rename, and delete .groovy script files and folders in root folders from the ScriptRunner front-end.

For example, a script in your _Script Roots_ folder needs updating to include a new condition. Before, you would need to contact the server administrator to update the script. Depending on backlog, this update could take weeks.

With _Script Editor_, you can add the condition into the .groovy file yourself, saving time, and removing the need for a third party.

_Script Editor_ only supports the creation, editing, moving, saving, renaming, and deletion of .groovy script files and folders.

To access _Script Editor_, navigate to ScriptRunner, and select **Script Editor** from the left-hand menu (or ScriptRunner tab).

## Create Files and Folders

1.  Navigate to the script folder to which you wish to add a new .groovy file or folder.
    
2.  Click the **Create New File** or **Create New Folder** icon in the _Script Editor_ heading, or right-click on the folder where you want to add the new file/folder and select **Add File** or **Add Folder**.
    
    You can also right-click on a file within a folder to create a new file/folder in the same location as the selected file.
    
    ![](/files/123734347/230982813/1/1707322819000/Script_editor_image_1.png)
    
3.  Enter a file/folder name in the _Add Groovy File_/_Add Folder_ window.
    
    If you have a folder selected, the new file/folder is created within the selected folder. Alternatively you can specify the file path in the folder name field. For example, ../../newfolder.
    
4.  Click **Add**. A new .groovy file or folder is added.
    
    Created your file/folder in the wrong place? Drag and drop the file to the required location in the left-hand navigation.
    
    ![](/files/123734347/230982812/1/1707322819000/Script_editor_image_2.png)
    

## Edit Files

1.  Select the .groovy file you wish to edit from the left-hand file navigator.
    
2.  Make any changes necessary to the file in the right-hand script field.
    
3.  Select the **Save** button when you have finished editing.
    
    ![](/files/123734347/230982811/1/1707322819000/Script_editor_image_3.png)
    
    Changes are not saved automatically. When there are unsaved changes to your script, the **Save** button is present. When all changes are saved, the **Saved** button replaces the **Save** button. To delete a .groovy file, click the **Delete** button.
    

## Rename and Delete

The _Script Editor_ also allows you to rename and delete .groovy files and folders.

1.  Right-click on the file/folder in question.
    
2.  From the drop-down, choose to either delete or rename the file/folder.
    

When a folder is deleted all files within it are also deleted.

## Expand and Collapse Folders 

**Expand/collapse all**

To expand or collapse all script folders, use the **Expand All** and **Collapse All** buttons in the _Script Editor_ heading. This expands/collapses all folders and sub-folders in your root folder(s).

![](/files/123734347/123734454/1/1634740746000/image2021-10-20_11-7-59.png)

**Expand single folder**

To expand a single folder, right-click on the selected folder and select **Expand All**. This expands the selected folder and all sub-folders. 

![](/files/123734347/123734455/1/1634740746000/expand-all.jpg)

## Referring to classes in the script root

For information on script roots and how to refer to classes in the script root, see the [Script Roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) page.
