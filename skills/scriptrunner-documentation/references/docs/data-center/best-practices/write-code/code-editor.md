# Code Editor

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442888122
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor

Use the _Code Editor_ to write scripts in ScriptRunner. The browser-based _Code Editor_ provides code completions, inline Javadoc lookups, inline find and replace, and error line indication.

## Completions

The code editor automatically displays suggestions as you type. Suggestions are filtered as you type, so only relevant options are displayed. Use the **arrow keys** and **Enter** or **Tab** to select a suggestion. You can manually trigger completions with **Control+Space**.

![](/sr4js/files/latest/442888122/442888151/1/1758746908000/Copmletions_1.png)

When referring to a class, the code editor will automatically add the required import.

![](/sr4js/files/latest/442888122/442888164/1/1758746909000/Completions_2.png)

To save typing, use camel case abbreviations. For example, type `ComAcc.issMan` to get `ComponentAccessor.issueManager`

![](/sr4js/files/latest/442888122/442888154/1/1758746908000/Completions_3.png)

### Smart completions

Press **Alt+Shift+Space** (**option+Shift+Space** on a mac) to show a list of completions that match the expected type of assignment or parameter type.

  

![](/sr4js/files/latest/442888122/442888150/4/1758746910000/Completions_4.png)

### Parameters

When typing method parameters, it is easy to forget the expected types. Parameter types, and where possible names, are shown for the given method. Use the up/down cursor keys to scroll through any available overloads.

Press **Control+Shift+Space** (**command+Shift+Space** on a mac) to view parameters when inside a method.

![](/sr4js/files/latest/442888122/442888161/1/1758746909000/Completions_5.png)

## Javadoc

The code editor can help you understand the purpose of classes, methods, and properties by loading the associated Javadoc. The Javadoc is shown in the editor as a pop-up. To view the Javadoc, press **Control+Space** with completions open. It will be displayed automatically from then on. To close it, press **Control+Space** again. 

![](/sr4js/files/latest/442888122/442888174/1/1758746910000/Completions_6.png)

## Find and replace

You can use find and replace in the code editor. To access find and replace, press **⌘+F** (mac) or **Ctrl+F** (windows).  
To search for text, enter it in the _Find_ field. To access find and replace, press **⌘+H** (mac) or **Ctrl+H** (windows).

![](/sr4js/files/latest/442888122/442888128/2/1758746911000/Completions_7.png)

## Error line indicator

Errors in your script are highlighted in the right-hand panel of the script editor. Errors are highlighted inline, on the scroll bar, and in the right-hand overview ruler. When you have located an error, hover over the error with the cursor to see a summary.

![](/sr4js/files/latest/442888122/442888129/3/1758746910000/Completions_8.png)

## Full screen editing

To open the script editor in full screen, select **![](/sr4js/files/latest/442888122/442888131/1/1758746907000/fullscreen.jpg) Fullscreen** or press **F11** when the cursor is in the editor. To exit the full screen, press **F11** or Esc twice when the cursor is in the editor. 

## Restrictions

There are some limitations to the code editor; work is ongoing to reduce these limitations. As mentioned, Javadoc for Bamboo APIs, and ScriptRunner’s API (e.g. Behaviours) is not available. However, completions and parameter hints are available for all.
