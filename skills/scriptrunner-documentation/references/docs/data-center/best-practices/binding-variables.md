# Binding Variables

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-441364508
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/binding-variables

Binding variables are predefined variables that are automatically available within a script. These variables provide access to commonly used objects and services in Jira, allowing you to interact with Jira without having to import/create those objects or services.

Binding variables are a useful feature of ScriptRunner because they provide scripts with the context needed to perform their intended function within Jira.

## How binding variables differ from feature to feature

The binding variables available to you can vary depending on the feature you are using because different features operate in different contexts and, therefore, have different requirements.

#### Script console

When you run a script in the Script Console, you typically have access to a minimal set of binding variables. You might have access to the `log` variable for logging, but you won't have access to issue-specific variables since the script is not being executed in the context of a specific issue.

#### Built-in scripts

Built-in scripts are pre-written scripts provided by ScriptRunner that allow you to automate manual, complex, and time-consuming tasks. Some of our built-in scripts provide script areas where you can write custom code, for example, to add a condition. Within these script areas, you are provided with context-specific binding variables that you can use in your script. For example, the _Guardrails: Maximum attachment size_ built-in script has a script area where `attachment` is a binding variable that lets you further refine your attachment filter with a scripted condition.

#### Listeners

Listeners respond to events in Jira. When writing a listener script, you have access to binding variables that provide information about the event that triggered the listener. The primary binding variable for listeners is the `event` variable. The type of this variable changes depending on the event you select. For example, if you choose an issue-based event like `Issue Created`, the event object will be of the `IssueEvent` type, as documented in the [API documentation](https://docs.atlassian.com/software/jira/docs/api/9.13.0/com/atlassian/jira/event/issue/IssueEvent.html). The `IssueEvent` type itself provides access to methods like `[getIssue](https://docs.atlassian.com/software/jira/docs/api/9.13.0/com/atlassian/jira/event/issue/IssueEvent.html#getIssue--)` to get the issue that triggered the event.

#### Script fields

Script fields allow you to extend the information shown for an issue, and display that information in the form of a custom field. In the context of a script field, you have access to binding variables that allow you to calculate a value based on the current issue. The `issue` variable is commonly used here to derive the value to be displayed in the custom field.

#### Workflow functions (conditions, validators, post functions)

ScriptRunner Workflow functions allow you to enhance and automate your workflows beyond Jira's native possibilities. When you use ScriptRunner to customize workflows, you have access to binding variables related to the transition being performed. For example, `issue` for the current issue and `transientVars` for variables that only exist during the transition.

#### Fragments

Script Fragments allow you to customize the Jira user interface by adding web items, web sections, or web panels. When creating a script fragment, you can use binding variables to render dynamic content. 

Binding variables available for fragments when writing a script include `issue`, `jiraHelper`, and `log`. The `issue` and `jiraHelper` variables will be `null` if there is no issue in the context where it is rendered. For example, if you're adding a web panel to the issue view screen, you can use the `issue` binding variable to display information specific to the current issue.

#### REST endpoints

With ScriptRunner, you can use Groovy scripts to define REST endpoints, allowing you to integrate with external systems and exchange data. When creating custom REST endpoints, you have access to the `log` binding variable for logging.

## Accessing binding information

You can access binding information through the help button on any script editor:

![Image showing the location of the help button](/sr4js/files/latest/441364508/441364510/1/1707328450000/Binding+information.png)

The binding information that displays will vary depending on the feature you are working on. 

## How to use a string and array variables

You can define a string variable by assigning a sequence of characters enclosed in single quotes (`'`) or double quotes (`"`). An array variable can be defined using square brackets (`[]`).
