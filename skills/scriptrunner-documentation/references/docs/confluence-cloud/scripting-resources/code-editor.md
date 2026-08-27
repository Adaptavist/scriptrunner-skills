# Code Editor

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: scripting-resources
- Doc ID: doc-sr4cc-246186023
- Source: https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor

Use the code editor to write scripts in ScriptRunner. The browser-based code editor provides code completions, inline Javadoc lookups, inline find and replace, and error line indications. This editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Automatically available variables

Keyboard shortcuts warning

Keyboard shortcuts may not work depending on other system-defined shortcuts.

## Completions

The code editor automatically displays suggestions as you type. Suggestions are filtered as you type, so only relevant options are displayed. Use the **arrow keys** and **Enter** or **Tab** to select a suggestion. You can manually trigger completions with **Control+Space**.

![](/sr4cc/files/latest/246186023/288523571/1/1725043350000/code-editor-example-01.png)

When referring to a class, the code editor will automatically add the required import.

![](/sr4cc/files/latest/246186023/288523569/1/1725043467000/import-class.png)

To save typing, use camel case abbreviations.

Smart Completions 

Press **Ctrl+Alt+Space** to show a list of completions that match the expected type of assignment or parameter type.

![](/sr4cc/files/latest/246186023/288523568/1/1725043711000/smart-completions.png)

### Parameters 

When typing method parameters, it is easy to forget the expected types. Parameter types, and where possible names, are shown for the given method. Use the up/down cursor keys to scroll through any available overloads.

Press **Control+Shift+Space** to view parameters when inside a method.

![](/sr4cc/files/latest/246186023/288523563/1/1725470923000/Screenshot+2024-09-04+at+10.49.17%E2%80%AFAM+%281%29.png)

## Javadoc

The code editor can help you understand the purpose of classes, methods, and properties by loading the associated Javadoc. The Javadoc is shown in the editor as a pop-up. To view the Javadoc, press **Control+Space** with completions open. It will be displayed automatically from then on. To close it, press **Control+Space** again. 

![](/sr4cc/files/latest/246186023/288523565/1/1725052105000/java-pop-up.png)

## Find and replace

The code editor allows you to use find and replace in the code editor. To access find and replace, press **⌘+F** (Mac) or **Ctrl+F** (Windows).  
To search for text, enter it in the _Find_ field. To access find and replace, press **Option+****⌘+F** (Mac) or either **Ctrl+H** or **Alt+Ctrl+F** (Windows). 

## Error line indicator

Errors in your script are highlighted in the right-hand panel of the script editor. Errors are highlighted inline, on the scroll bar, and in the right-hand overview ruler. When you have located an error, hover over the error with the cursor to see a summary.

![](/sr4cc/files/latest/246186023/288523566/1/1725052001000/error.png)

## Full-screen editing

To open the script editor in full screen, click the icon ![](/sr4cc/files/latest/246186023/246186032/1/1684352373000/fullscreen.jpg) or press **F11** when the cursor is in the editor. To exit the full screen, press **F11** or Esc twice when the cursor is in the editor. 

## Restrictions

There are some limitations to the code editor; work is ongoing to reduce these limitations. As mentioned, Javadoc for Bamboo APIs, and ScriptRunner’s API (e.g. Behaviours) is not available. However, completions and parameter hints are available for all.

## Example scripts

ScriptRunner has a number of [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) for you to use. To access them, select this button in the _Script_ field: 

![](/sr4cc/files/latest/246186023/288523561/1/1726000103000/click-example-scripts.png)
