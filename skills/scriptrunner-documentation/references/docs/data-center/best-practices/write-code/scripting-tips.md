# Scripting Tips

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442886008
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/scripting-tips

The following page provides you with some quick tips on writing and debugging your scripts. 

## Where to put your scripts

If you're not adding an inline script, you can connect to a file and give the absolute path of the script, or path relative to one of your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots). Relative paths are more portable and make switching servers easier.

![](/sr4js/files/latest/442886008/442886009/1/1758746537000/Script_file.png)

When your scripts or classes include a `package` declaration, make sure you organize them in a directory structure that reflects the package hierarchy. 

## Script binding

Binding variables are predefined variables that are automatically available within a script. These variables provide access to commonly used objects and services in Jira, allowing you to interact with Jira without having to import/create those objects or services. Binding variables are a useful feature of ScriptRunner because they provide scripts with the context needed to perform their intended function within Jira.

The binding variables available to you can vary depending on the feature you are using because different features operate in different contexts and, therefore, have different requirements.

For example, when writing an inline script for a [simple scripted condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition) you will have immediate access to the current `issue` and `transientVars` in the _script binding_. That means you can refer to them using these variables, without declaring them. For example, you can log the issue key with the following line:

```
log.debug issue.getKey()
```

If you use Intellij IDEA, you can add a **dynamic property** for these variables of the correct type. Alternatively, you can redeclare the variable with _type_ information in your script:

```
import com.atlassian.jira.issue.Issue;
Issue issue = issue
```

### Available variables

You can check what binding variables are available to you through the help button on any script editor:

![](/sr4js/files/latest/442886008/442886010/1/1758746537000/Binding+information.png)

The binding variables that display will vary depending on the feature you are working on. 

## Safe navigation

To safely check an issue's resolution without causing an error when the resolution is not set, use the [safe-navigation operator](http://docs.groovy-lang.org/latest/html/documentation/#_safe_navigation_operator) `?.`.

For example, to check the resolution is **Won’t Fix** you might typically write:

```
issue.resolution.name == "Won't Fix"
```

However, if the resolution is not set at all this code would produce an error. Therefore it should be written as follows with the safe-navigation operator:

```
issue.resolution?.name == "Won't Fix"
```

## Power Assertions

[Power assertions](http://dontmindthelanguage.wordpress.com/2009/12/11/groovy-1-7-power-assert/) are a very useful for debugging your code. If you're having issues with a line of code you can add `assert` at the beginning to check if it's working as expected. 

Remove the `assert` before using as a real condition - your condition will always evaluate to **false** if you leave the assert in.

### Example

In the following example we're using the script in a [custom script condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/custom-script-condition). 

We have a custom fields called **MySelect** and it has two values, **Yes** and **No**, and we only want a transition to happen if the value is set to **Yes**. As a first step, we try the following:

```
cfValues['MySelect'] == "Yes"
```

This doesn’t work for an issue where it should, so we add `assert`:

```
assert cfValues['MySelect'] == "Yes"
```

Which also fails as it shows that both sides are `Yes` yet the `==` was false. To investigate further, we have to check the the type of class:

```
assert cfValues['MySelect'].class == String.class
```

The result from this tells us that value for our custom field key is not a String but a `[LazyLoadedOption](https://docs.atlassian.com/software/jira/docs/api/7.6.1/com/atlassian/jira/issue/customfields/option/LazyLoadedOption.html)`. This means we should call the `[getValue()](https://docs.atlassian.com/software/jira/docs/api/7.6.1/com/atlassian/jira/issue/customfields/option/SimpleOption.html#getValue--)` method to compare its value. The `toString()` method of `Option` returns the value, but you can’t compare them as strings.

**Multiselect example**

For a multiselect field, which is stored as a List of Options, the correct code to use to check to see if a particular value is present uses the spread-dot operator `*.` to call the `getValue()` method on every item:

```
cfValues['MyMultiSelect']*.value.contains("AAA")
```
