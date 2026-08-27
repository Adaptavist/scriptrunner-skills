# Console Log

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-281116717
- Source: https://docs.adaptavist.com/src/latest/workspaces/console-log

At the bottom of the workspace, you'll see the console log, where all log messages are displayed. Whenever you perform an action in the workspace, run a script manually, or trigger a script through a scheduled or external event, the related logs will appear in the console log.

![The Console Log, highlighted at the bottom of the Resource Manager screen.](/src/files/latest/281116717/281116722/1/1723833981000/full-console.png)

## Expand/Collapse console log panel

You can resize the console log panel by using the splitter between the console log and the rest of the workspace. To expand the console log to full screen, click the first button in the console log header. 

![The Expand option shown in the console log.](/src/files/latest/281116717/281116724/1/1723825451000/expand-console-log.png)

Click the same button again to collapse it back from full screen.

![The Collapse option shown in the console log.](/src/files/latest/281116717/281116723/1/1723826355000/collapse-console-log.png)

## Expand/Collapse log messages

If a log message contains multiline text, a caret will appear in front of it. Click the caret to expand the message into a multiline view, which is useful for reading structured logs, such as JSON data.

![The expand option shown for a log message.](/src/files/latest/281116717/281116719/1/1723838544000/expand-collapse-console.png)

Click the caret again to collapse the message back to single-line format.

## Information display options

By default, the following fields are displayed at the top of each log message:

-   **Date**: The date when the message was received.
-   **Time**: The time when the message was received.
-   **Source**: Where the message originated from (e.g., `Workspace` for actions you took, or the script name for triggered scripts).
-   **Environment Name**: The name of the environment where the script was invoked.
-   **Invocation ID**: A unique ID for the script invocation.

**Customize the log fields** 🪵

Use the second button in the console log header to select which of these fields you want to display.

![The log filter option highlighted.](/src/files/latest/281116717/281116721/1/1723835197000/console-selector.png)

### Filter by log-message type

Each log message has a type: Debug, Information, Warning, Error, or Success. Use the third button in the console log header to filter logs by type. If no filter is selected, all log messages will be displayed.

![The log-message type filter highlighted.](/src/files/latest/281116717/281116720/1/1723835400000/console-type-selector.png)

### Toggle live feedback

If you're troubleshooting or developing on a workspace that actively receives events from an external system, you might see log messages from script invocations you didn't trigger. To filter out these sometimes noisy messages, uncheck the **Live Feedback** checkbox in the console log header. This will only display messages from scripts you trigger manually.

This is useful if you're troubleshooting or developing in a workspace that actively receives events from an external system. It can also help when you're triggering scripts manually or via event listeners using test event payloads and want to filter out messages from external events.

### Filter log messages by environment

By default, log messages are shown only for the environment selected in your workspace. To see all log messages, regardless of the environment, uncheck the **Filter by Environment** checkbox in the console log header.

### Search log messages by keyword

To filter messages by a specific keyword, use the search box on the right-hand side of the console log header.

## Clear log messages

At any time, click **Clear Log** to clear all log messages. 

**Abort script limitation 🚨**

The only way to abort a script invocation is to click **Abort Invocation** in the _Invocation Scheduled_ section of the log. If you clear the console, you lose the opportunity to abort any currently running script invocation. Clear logs with caution!

![The ](/src/files/latest/281116717/281116718/1/1724084694000/abort-invocation.png)
