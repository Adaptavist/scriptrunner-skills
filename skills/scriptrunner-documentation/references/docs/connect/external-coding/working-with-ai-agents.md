# Working with AI agents

- Platform: connect
- Space: SRC
- Hierarchy: external-coding
- Doc ID: doc-src-432570719
- Source: https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents

With the ability to expose your [workspace file system to external tooling](https://docs.adaptavist.com/src/latest/external-coding), you can also use your favorite AI tools to build integrations, even [vibe code](https://en.wikipedia.org/wiki/Vibe_coding) (have the AI agent build the entire solution without writing a single line of code yourself).

## Demo

## AI development files

To support AI-assisted coding, your workspace file system comes with the following (README) files:

-   `AI.md` - Contains condensed instructions for everything the AI agent should know about the structure of the remote workspace file system and how ScriptRunner Connect works in general. This can also be a good read for anyone who wants a concise overview of everything they need to know about ScriptRunner Connect without having to go through the official documentation. AI generates this file for AI and is highly technical, making it suitable for those who are comfortable learning from code examples.
-   `AI_TESTING.md` - Contains instructions for building local tests. This is a dedicated file because the AI is instructed not to write local tests for you by default. However, if you explicitly ask for tests, the AI will look up additional instructions from this file.

## Get started

To start external coding with an AI agent:

1.  Hook up a local development environment with our [remote workspace file system](https://docs.adaptavist.com/src/latest/external-coding "https://docs.adaptavist.com/src/latest/external-coding").
    
2.  Use your favourite AI tool.
    
3.  Ask it to build something for you and point the tool to read instructions from the `AI.md` file.
    
4.  Watch the magic happen.
    

We have tested this to work well with [Cursor](https://cursor.com/) and the non-thinking version of the Claude 4 Sonnet model. Thinking models should yield more accurate results, but can be more expensive.

## Add your own instructions

To support AI-assisted coding, your workspace file system comes with the following (README) files:

-   `[AGENTS.md](https://agents.md/)` \- Contains condensed instructions for everything the AI agent should know about the structure of the remote workspace file system and how ScriptRunner Connect works in general. This can also be a good read for anyone who wants a concise overview of everything they need to know about ScriptRunner Connect without having to go through the official documentation. AI generates this file for AI and is highly technical, making it suitable for those who are comfortable learning from code examples.
-   `[AGENTS_TESTING.md](http://AGENTS_TESTING.md)` \- Contains instructions for building local tests. This is a dedicated file because the AI is instructed not to write local tests for you by default. However, if you explicitly ask for tests, the AI will look up additional instructions from this file.

## Tips and tricks

### Starting new conversations

When starting a new thread with the AI, it's worth appending "`Start by reading [AGENTS.md](http://AGENTS.md)`" to your request to ensure the AI gets the correct context from the start. However, newer models and tools should be able to automatically find the [AGENTS.md](http://AGENTS.md) file in your system.

### Workspace setup

The AI is instructed to direct you back to our web app to set up any missing workspace resources needed for your request, as it can only assist with writing scripts at this time. This can be tedious and consume AI usage needlessly because the initial version the AI generates is a placeholder implementation that needs to be swapped out later.

Recommendation ❇️

Set up your workspace as much as possible before using the AI so that everything it needs is already configured when it starts working. This also includes environment variables ([parameters](https://docs.adaptavist.com/src/latest/workspaces/parameters)). The AI is instructed to reuse existing environment variables for configurability and security (not having to hardcode API keys into the code directly when connectors cannot be used).

Ask to refactor

When you follow AI instructions to set something up in the web app, make sure you ask the AI to refactor the code after downloading the changes so that it can swap out the initially provided placeholder code.

### Download the latest AI files

When you make structural changes to your workspace ([API Connections](https://docs.adaptavist.com/src/latest/workspaces/api-connections), [Event Listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners) or [Scheduled Triggers](https://docs.adaptavist.com/src/latest/workspaces/scheduled-triggers)), make sure to download the latest version of the `AI.md` and `AI_TESTING.md` files from the remote file system. This information is included in the `AI.md` file to help AI agents better understand the setup of your workspace. The file includes a timestamp indicating when it was last updated, making it easy to check if the AI README files have been updated. When in doubt, you can compare the timestamp of the latest changes with the timestamp of your local file. If there is a difference, a new version is available, and you should download it.

Check updates periodically

We recommend checking that timestamp periodically, even when you haven't made structural changes to your workspace. The ScriptRunner Connect team continuously improves the AI instructions. When a new version is published, we'll generate a new file for you with a new timestamp.

### Manage AI attention span

AI models still have limited attention spans, and when they are asked to follow numerous instructions, they often fail to follow all of them. At the end of your request, you can ask, "Did you follow all requirements?" - most likely, you will find more improvements to make. You can ask this question as many times as you like.

Due to its limited attention span and internal memory, the AI will likely forget initial instructions if a thread gets too long: consider starting a new thread after a while.

There is still hope

Attention span/consistency-related issues are expected to improve with newer models.

### Troubleshooting

If the AI-generated code doesn't work as expected or returns an error, inform the AI about the issue or copy and paste the error message back into the chat. AI models are good at identifying errors and providing solutions.

### Linting

The AI is instructed to run the [linter](https://eslint.org/) at the end of every request, which it usually does, but sometimes forgets to do so. If this happens, instruct the AI to run the linter, as it provides valuable feedback that the AI can then iterate on if any issues are found. Some models may attempt to resolve linting issues without running the linter, but can become stuck in a loop of perpetual refinement. If this happens, stop the AI and run the command manually by running `npm run lint:fix`, or when following our [recommended setup](https://docs.adaptavist.com/src/latest/external-coding/recommended-setup), simply press COMMAND/CTRL+K+C in VS Code or COMMAND/CTRL+R+C in Cursor on the files that need re-formatting. This won't resolve any compilation issues, but it's a quick way to reformat the file.

### Testing

If you want [local tests](https://docs.adaptavist.com/src/latest/external-coding/test-and-run-scripts-locally) written, ask for them explicitly. Also, specify the type of tests you want, as the AI is instructed to write tests either by mocking API requests or running them as integration tests.

### API usage

The AI often gives up on using [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis "https://docs.adaptavist.com/src/latest/managed-apis") or outright ignores this instruction, defaulting to using [managed fetch API](https://docs.adaptavist.com/src/latest/managed-apis/managed-api-abstractions#managed-fetch-api) instead. While this works fine, we recommend encouraging the AI to try harder at figuring out how to use our Managed APIs since they are strongly typed and offer better feedback for the AI to ensure it constructs API calls correctly.

### Generate AI README files

If you are an early user and already have a remote file system enabled for your workspace, and you don't see `AI.md` and `AI_TESTING.md` files, add a new [API Connection](https://docs.adaptavist.com/src/latest/workspaces/api-connections), [Event Listener](https://docs.adaptavist.com/src/latest/workspaces/event-listeners), or [Scheduled Trigger](https://docs.adaptavist.com/src/latest/workspaces/scheduled-triggers) to your workspace, then delete them if needed. This will force the AI readme files to be generated in your remote file system. This trick can also be used if you accidentally deleted AI README files from the remote file system and want to recover them. Disabling and re-enabling the SFTP server also works, but it will result in re-generating the file system for the entire workspace, which should be used more carefully.

## Feedback

We'd love to hear your feedback on how you're getting along with AI agents, or if you have instructions you think should be included in the baseline instructions. Please feel free to post your feedback in the [Loop integration forum](https://loop.scriptrunnerhq.com/c/integration-forum/).
