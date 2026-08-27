# Editor

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-194676340
- Source: https://docs.adaptavist.com/src/latest/scripting/editor

ScriptRunner Connect comes bundled with an embedded editor for writing code in JavaScript/TypeScript. It is based on the same technology that is powering the extremely popular [VS Code](https://code.visualstudio.com/ "https://code.visualstudio.com/") product. Our editor will be very familiar if you have used VS Code before. Most default features and key bindings should remain the same, although certain features are removed; for example, you won't have access to your local file system.

## Demos

Here's a ten-minute overview of the ScriptRunner Connect editor's features, including some tips and tricks. The UI has been updated since the creation of the video, but the content is still relevant. 

## Toggle auto-complete suggestions

As you write code, the editor assists you by providing [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense "https://code.visualstudio.com/docs/editor/intellisense") with suggestions, when available. You can expect full support for suggestions when using our [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis).

Sometimes you may lose the suggestions list or find that it doesn't display when you need to ask for suggestions. Manually call it using **CTRL + SPACE**:

**![Code editor displaying JavaScript code with an import statement for 'JiraCloud' and an async function. A dropdown suggests Jira issue methods like 'getIssue'.](/src/files/latest/194676340/194676316/1/1695219641000/Screenshot+2022-08-11+at+15.53.37.png)**

By default, suggestions are not displayed for object fields. In this case, pressing **CTRL + SPACE** can help you view all the possible fields, which can be very helpful when working with our Managed APIs. For example, pressing **CTRL + SPACE** while your cursor is within the options object reveals all possible fields you can use:

![Code editor screenshot showing an import statement for 'JiraCloud' and an async function. A dropdown suggests method parameters for 'getIssue', with options like 'issueIdOrKey'.](/src/files/latest/194676340/194676317/1/1695219641000/Screenshot+2022-08-11+at+15.50.32.png)  

Also, an additional popup containing documentation not shown by default can be toggled, opened, and closed by pressing **CTRL + SPACE**:

![Code editor screenshot showing a TypeScript function importing 'JiraCloud' module and calling 'getIssue'. Dropdown menu lists parameters options, highlighting 'issueIdOrKey'.](/src/files/latest/194676340/194676318/1/1695219641000/Screenshot+2022-08-11+at+15.51.57.png)

The same behavior applies not only to object fields but also to functions:

![Code editor showing JavaScript import statement for JiraCloud, with a dropdown menu highlighting ](/src/files/latest/194676340/194676319/1/1695219641000/Screenshot+2022-08-11+at+15.45.36.png)

Press **Escape** to close suggestions.

## Toggle import suggestions

Right now, import suggestions won't work if the caret is positioned after the last character of the import you're trying to get suggestions for. This is a [known issue](https://github.com/microsoft/monaco-editor/issues/2682).

VS Code displays various auto-import suggestions under the same UI as regular suggestions. However, our editor works slightly differently. When you need to import something, just write the name of the import you are looking for, make sure the caret is positioned before the last character, and then a lightbulb should appear if the editor can find anything to import. If you tap on that lightbulb, a list of suggestions will appear, you can also toggle import suggestions by pressing **COMMAND + .** on Mac or **CTRL + .** on Windows.

![Code snippet with underlined text in JavaScript editor. Shows a function setup and a suggestion to import a module for conversion, conveying a development context.](/src/files/latest/194676340/194676320/1/1695219641000/Screenshot+2022-08-11+at+17.22.15.png)

For example, if you want to structure your code and create additional functions, you're recommended to specify types for your arguments for the functions you create, but it can be difficult to know where to import these types from. This is where import suggestions can be helpful.

In the following example, we're creating a function that does something with the Jira issue we just fetched. However, by not passing along the type for the issue argument, we're losing [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense#:~:text=IntelliSense%20is%20a%20general%20term,%2C%20and%20%22code%20hinting.%22) support as the type is implicitly inferred as any, which literally means it can be anything. In this case, we'll also lose TypeScript's compiler support to check if we're not making any syntactical mistakes. Also, when we try to access the issue object, we won't receive any suggestions that we otherwise could get if we were still in the scope of the (main) default function, since the type inference is still working. If we force the editor to give us suggestions by pressing **CTRL + SPACE**, we would get back gibberish, a random suggestion that the editor thinks might be there but, in reality, almost never is.

![Code snippet showing a TypeScript function importing JiraCloud. It uses asynchronous methods to fetch an issue. Autocomplete suggestions are visible.](/src/files/latest/194676340/194676321/1/1695219641000/Screenshot+2022-08-11+at+16.16.11.png)

To fix this situation, we can hover over the issue assignment to find the type and then specify that type for the argument of our new functions:

![Code editor screenshot showing a warning message: “issue is declared but its value is never read.” Code snippet involves JiraCloud API functions.](/src/files/latest/194676340/194676322/1/1695219641000/Screenshot+2022-08-11+at+16.19.25.png)

Or we can hover over the function we're calling (technically, it's a method, but let's keep things simple):

![Code snippet showing how to fetch an issue from Jira using Node.js. It includes an async function call and method details with a tooltip describing parameters and permissions.](/src/files/latest/194676340/194676323/1/1695219639000/Screenshot+2022-08-11+at+16.21.18.png)

We can see the entire function/method signature using this method, but we can still see the same response type returned as a generic type of the Promise as we saw before.

Now, knowing the type that is returned from the Managed API call, `GetIssueResponseOK`, we can specify it as the type for our new function's argument:

![Code snippet showing an error in TypeScript with red underline on ](/src/files/latest/194676340/194676324/1/1695219640000/Screenshot+2022-08-11+at+16.23.53.png)

However, before we can use the type, we have to import it; this is where the import suggestions feature comes to the rescue. We can easily ask the editor to import this type for us:

![Code snippet showing an async function in JavaScript, importing \`JiraCloud\` to get an issue by ID. A TypeScript error highlights missing import \`GetIssueResponseOK\`.](/src/files/latest/194676340/194676325/1/1695219640000/Screenshot+2022-08-11+at+16.27.24.png)

While using TypeScript's types is optional, knowing how they work and how to use them correctly can greatly help reduce your cognitive load by offloading many of the things you usually have to memorize into the editor. You also get the benefit of TypeScript's compiler, which, especially if your code uses type information, can ensure you're not making typos in your code. Learning some [basics of TypeScript](https://www.typescriptlang.org/docs/handbook/) can greatly improve your productivity and reduce bugs.

Import suggestions not only work for types but also for other functions that are pulled into your workspace. In the following case, we can see a handy conversion function import suggestion:

![Code snippet with an error underlined in red for ](/src/files/latest/194676340/194676326/1/1695219640000/Screenshot+2022-08-11+at+16.32.15.png)

It can even help you with your own functions that you may have defined in some other script you may want to reuse. As an example, if we created a _utils_ script and declared and exported the following function:

![JavaScript code snippet showing an export function named ](/src/files/latest/194676340/194676327/1/1695219640000/Screenshot+2022-08-11+at+16.35.22.png)

We can then import it into some other script in our workspace and use it:

![Code snippet showing an async function with a suggestion to import ](/src/files/latest/194676340/194676328/1/1695219640000/Screenshot+2022-08-11+at+16.35.32.png)

## Leverage type inference

TypeScript is exceptionally good at type inferencing, meaning it can infer type information in many cases without you specifying types explicitly. Knowing how to take advantage of this system can greatly help you get the most out of the editor regarding suggestions.

For example, when we ask for suggestions for an options object in one of the Managed API calls, TypeScript can infer the type and let the editor display these suggestions for us:

![Code snippet showing an async function to get a Jira issue. A dropdown menu suggests parameters like ](/src/files/latest/194676340/194676329/1/1695219640000/Screenshot+2022-08-11+at+16.40.18.png)

However, you might be tempted to construct the options object manually and pass it into the Managed API call. Since you're creating this object without any explicit type, TypeScript doesn't know anything about it, so the editor won't be able to provide you with suggestions. If we explicitly ask for suggestions (**CTRL + SPACE**), we'll get nothing useful:

![Code snippet showing a TypeScript function with code completion for importing ](/src/files/latest/194676340/194676330/1/1695219640000/Screenshot+2022-08-11+at+16.42.47.png)

However, if we pass this object into the Managed API call, TypeScript can figure out that the object is not compatible and let us know through the editor:

![Code snippet showing a TypeScript error. The error message indicates a missing 'issueIdOrKey' property. The editor suggests no quick fixes, implying a coding issue.](/src/files/latest/194676340/194676331/1/1695219640000/Screenshot+2022-08-11+at+16.44.03.png)

If you construct your options object manually, you can specify the explicit type for the options object. First, we'd have to find out which type represents the object. We can do the same trick that we did before and hover over the function:

![Code snippet showing asynchronous JavaScript function for fetching issue details using Jira API. Includes comments and a link to documentation.](/src/files/latest/194676340/194676332/1/1695219640000/Screenshot+2022-08-11+at+16.46.34.png)

We can then see that the option is typed as `GetIssueRequest`. We can then specify the type for the options object:

![Code snippet showing a TypeScript error: ](/src/files/latest/194676340/194676333/1/1695219640000/Screenshot+2022-08-11+at+16.47.38.png)

Obviously, we also have to import that type, and for that we can use the import-suggestions feature. When we import the type and then ask for suggestions, the editor displays valid options to consider:

![Code snippet showing a TypeScript function importing Jira APIs. A dropdown suggests options like ](/src/files/latest/194676340/194676334/1/1695219640000/Screenshot+2022-08-11+at+16.49.20.png)

In this case, the editor also highlighted an error for options because it was missing a required field, which it was only able to figure out when type information was added:

![Code editor screenshot shows a TypeScript error, highlighting a missing 'issueIdOrKey' in 'GetIssueRequest'. Includes an import statement and a function definition.](/src/files/latest/194676340/194676335/1/1695219640000/Screenshot+2022-08-11+at+16.51.17.png)

## Renaming

You can use the **F2** key to rename things and refactor the code.

**Don't confuse the editor**

Only rename things that are local to the script you are working with. When you rename something that is imported, it will confuse the editor into thinking that it managed to rename the source file, which it cannot do. If you do this by mistake, save all your work and refresh the browser to force the editor to reload.

## Peeking

**Shift + F12** allows you to peek at code without having to navigate to that code manually.

In the following example, we can peek at a function that we have declared in a separate file that we have imported:

![Screenshot of a code editor displaying TypeScript code. The top pane shows a function importing and using 'add'. The bottom pane defines 'add(a, b)' to sum two numbers.](/src/files/latest/194676340/194676336/1/1695219640000/Screenshot+2022-08-11+at+17.01.46.png)

You can also peek at code that you didn't write yourself, but in this case, you'd only be seeing TypeScript type definitions:

![Screenshot of a code editor displaying JavaScript code involving Jira API functions. The focus is on the \`getIssue\` function and its references. A sidebar shows related code files and references, emphasizing issue handling in Jira software integration.](/src/files/latest/194676340/194676337/1/1695219641000/Screenshot+2022-08-11+at+17.06.15.png)

## More options

Press **F1** to reveal all the actions you can take, but remember, all of the options won't be functional:

![A dropdown menu with programming command options, such as ](/src/files/latest/194676340/194676338/1/1695219641000/Screenshot+2022-08-11+at+17.07.54.png)

A right-click reveals even more common actions:

![Context menu with text editing commands like ](/src/files/latest/194676340/194676339/1/1695219641000/Screenshot+2022-08-11+at+17.08.53.png)
