# Reading Jira Logs

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > logging
- Doc ID: doc-sr4js-348417852
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging/reading-jira-logs

A Jira log file is a file that records the events that occur when Jira software runs. For more information, read [Atlassian's guide to logging](https://confluence.atlassian.com/adminjiraserver/logging-and-profiling-938847671.html). This document will help you to search for ScriptRunner errors in your log files.

You may also want to read the [Advanced Logging](https://docs.adaptavist.com/sr4js/latest/best-practices/logging/advanced-logging) page for details on using a logger and log levels.

## Accessing Jira log files in ScriptRunner

We have developed a built-in script for you to access your log files quickly. Visit our Built-in scripts page to [view your server log files](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/view-server-log-files). Then, select a log to view. E.g. _atlassian-jira.log_. 

It can be useful to know which log to look for. Check out Atlassian's documentation on [Useful log files in Jira](https://confluence.atlassian.com/jirakb/useful-log-files-in-jira-1027120387.html?&_ga=2.40150050.1240709667.1666599110-2029362582.1658496808#:~:text=Logging%20is%20written%20by%20default,in%20the%20Jira%20Home%20directory). 

## Searching for ScriptRunner errors in logs

### How do I know which logs are related to ScriptRunner?

ScriptRunner outputs logs that contain the words `onresolve` or `scriptrunner.` Sometimes these words are shortened to abbreviations, like \[`c.o.s]` which stands for `[com.onresolve.scriptrunner]`. With Atlassian logs `[c.a.j]` stands for `[com.atlassian.jira]`. 

You can often find the class responsible for the script error by searching for the class name in the logs. For example, CopyProject issues would contain the word CopyProject.

### Example of a ScriptRunner error

Here's an example of a ScriptRunner error in the `atlassian-jira.log`:

![Example of scriptrunner error](/sr4js/files/latest/348417852/348417854/1/1664372418000/ScriptRunner_error_example.png)

**Green**: Time the log was created  
**Orange**: Logging level – Look for `DEBUG`, `INFO`, `WARN`, `ERROR` and `FATAL` **Blue**: ScriptRunner class - Look for `onresolve` or `scriptrunner`  
**White**: Description of the error  
**Yellow**: The script number and line in which the error occurred. `Script 101.groovy` is an inline script where we increment the number, for example, Script102, Script103, Script104 etc.

If you have used a file script, it will appear as `SomeFile.groovy:26` instead of `Script101.groovy:26`.

In the example above we have an `ERROR`, specifically a `NumberFormatException`, happening with a ScriptRunner scripted field (`GroovyCustomField`) named _Ranking_ on Line 26 of the custom scripted field's code. Everything below the red arrow in the example above is known as the stack trace, and it shows where the error is coming from.

## Making logs easier to read

A log file is full of noise and is thousands of lines long. You can [mark logs](https://confluence.atlassian.com/jirakb/mark-logs-for-easier-troubleshooting-in-jira-server-827334452.html?_ga=2.180157287.219016462.1667210454-2029362582.1658496808) and replicate an issue to clarify what is happening and when. This makes it easier for you to see what's happened in your logs after you have marked them. 

## Still not sure what's wrong?

If you're having trouble reading your log files, and are unsure where an error is coming from, contact [Adaptavist Support](https://productsupport.adaptavist.com/servicedesk/customer/portal/2) for help.
