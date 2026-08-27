# AI Assistant

- Platform: connect
- Space: SRC
- Hierarchy: get-help
- Doc ID: doc-src-322832818
- Source: https://docs.adaptavist.com/src/latest/get-help/ai-assistant

ScriptRunner Connect has an AI assistant feature based on the ChatGPT 4o model to help you write scripts, answer questions about how the app works, and find useful templates for your use cases. The AI assistant can be used with a monthly credit allotment.

Bring your own AI

If you wish to bring tour own AI tool, use agentic AI driven development, or entirely [vibe code](https://en.wikipedia.org/wiki/Vibe_coding) integrations, [you can do that too](https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents).

## Demo

## Meet the new assistant

You can find the AI assistant in the left-side navigation. 

![](/src/files/latest/322832818/322832820/1/1737664848000/ai-assistant-new.png)

## Code generation

The primary purpose of the AI assistant is to help you write code by asking various questions about how to achieve the tasks you need for your integration. The experience is similar to how other LLM-based chatbots work, like ChatGPT, meaning you can chat and converse with the AI assistant. ScriptRunner Connect's chatbot is specially trained with the API surface of the [ScriptRunner Connect runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) and its [managed APIs](https://docs.adaptavist.com/src/latest/managed-apis).

**Communication tips 💬**

For best results, keep your questions to the AI assistant as brief and specific as possible. You can ask the generated output to be corrected with follow-up questions.

### Suggest improvements

Having trouble with a section of code? Not getting the output you were expecting? Try having the AI Assistant give you some suggestions for improvement!  
With your desired script open in the editor, click the **AI Assistant actions** button, then select **Suggest improvements**.  
![](/src/files/latest/322832818/368510467/1/1746639363000/2025-05-07_12-35-10.png)  
The AI Assistant will then chat back with a suggestion and an explanation of the improvement. 

### Explain code

The explain code option can be used in the AI Assistant window to gather context and aid in iteration. To use this function, highlight the code in question, right click, and select **(AI) Explain Code** from the dropdown options. After your selection, the AI Assistant will chat with you, giving you a detailed explanation of your selected code.

### Explain script

If you'd like a whole script explained instead of a snippet, we've got you! Click the **AI Assistant actions** button and then select **Explain script**.   
The AI Assistant will then provide detailed information about the script and its function. 

### Explain error

Did you get an error message in the log after triggering a script? The AI Assistant can help!   
Click the **AI Assistant icon** in your error message to _Ask the AI Assistant to explain the error_.  
![](/src/files/latest/322832818/368510466/1/1746817836000/click-AI-error-icon.png)  
The AI Assistant will then chat back with you, explaining the error and how to potentially fix it.

### Falling back on public domain knowledge

If the AI assistant cannot find a solution that uses ScriptRunner Connect's [managed APIs](https://docs.adaptavist.com/src/latest/managed-apis), it will try to _combine_ knowledge from the public domain with the app's APIs. In other words, it will use public domain knowledge to call the API and combine that with the app's [Fetch API](https://docs.adaptavist.com/src/latest/scripting/fetch-api). 

There are generally two main reasons why the AI assistant may take the public-domain route to the solution it offers:

-   Support for the API call that was deemed necessary does not yet exist at the managed API level.
-   The question is phrased in a manner that doesn't match official terminology, meaning a matching managed API method did exist but was not found. For example, "Create a ticket in Jira Cloud with summary XYZ" may cause the AI assistant to generate a script that uses [Fetch API](https://docs.adaptavist.com/src/latest/scripting/fetch-api) with knowledge of how to make the API pulled from the public domain, even though a managed API method exists to complete that specific task. The reason is that the question used the word "ticket" instead of "issue." Officially, tickets are called "issues" in Jira, and the corresponding method for creating the issue in Jira using the managed API is called `createIssue`. Rephrasing the question with the official Jira terminology should return an answer using the correctly managed API method.

## General questions about ScriptRunner Connect

You can ask the AI assistant questions about ScriptRunner Connect features. The AI assistant will reference the app's documentation and provide an answer and a link to the original documentation page. This approach is arguably faster than manually searching the documentation for answers.

### Searching for templates

The AI assistant knows all the app's [templates](https://templates.scriptrunnerconnect.com/), so you can ask it to find a relevant template for your use case.

### Monthly use and credit system

The AI assistant's use is available according to monthly credit allotments. Each question you ask the assistant consumes a single credit, and your credits fully renew at the beginning of each monthly payment cycle.

![](/src/files/latest/322832818/322832819/1/1737670355000/tokens.png)

See [Limits and Quotas](https://docs.adaptavist.com/src/latest/limits-and-quotas) to determine the eligible credits for your tier.
