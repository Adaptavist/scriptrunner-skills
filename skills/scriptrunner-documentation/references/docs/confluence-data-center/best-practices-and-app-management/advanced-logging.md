# Advanced Logging

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-6cafd050-1fd9-4d1d-90df-1acbb0d62e75-442dc64905a01c8e
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#advanced-logging--en

Learn our advanced concepts for logging in the app.

## What is the variable 'log'?

The `log` variable is injected into every ScriptRunner inline script, and its value is equivalent to:

```
def log = Logger.getLogger("com.onresolve.scriptrunner.runner.ScriptRunnerImpl")
```

`log` is an instance of a [Logger](https://logging.apache.org/log4j/1.2/apidocs/index.html).

## Using your own logger

It might be preferable to use your own logger so that you can adjust logging levels separately from ScriptRunner as a whole.

In an inline script, or file, you can do this using the following code:

```
import org.apache.log4j.Logger

def log = Logger.getLogger("com.acme.workflows")
log.warn("Workflow function running...")
```

If you use classes the simplest way to get a logger is to use the `@Log4j` annotation:

```
package com.acme.workflows

import groovy.util.logging.Log4j

@Log4j
class Foo {

    void utilityMethod() {
        log.warn "Foo.utilityMethod"
    }
}
```

In the above example, the `log` instance is automatically created and will have the category `com.acme.workflows.Foo`, that is, the fully qualified class name.

Tip: This is the best way of logging, as it will automatically wrap calls to the logger in the relevant guarding function, e.g. `if (log.isDebugEnabled()) {log.debug(…​)}`

Warning: Confluence uses log4j 1x, if browsing the documentation be sure you are not looking at the documentation for log4j 2x.

## Log Levels

A log message is printed if the logging level is the same or higher than the configured level for that category.

Tip: For detailed information on logging levels, see [log4j Logging Levels](https://www.tutorialspoint.com/log4j/log4j_logging_levels.htm).

The default log level for most categories is `WARN`. Take a note of the default log level before making any changes. Therefore, if you want to use `log.debug`, the category level must be set to `DEBUG` or `TRACE`.

Tip: Take a note of the default log level before making any changes.

Temporarily enable ScriptRunner logging under System > Logging and Profiling in the Administration menu. Set the `com.onresolve` package to DEBUG under _Default Loggers_.

Note: This sets the logging level until the instance is restarted or the logging level is changed manually (to the default WARN for example).

You can change the logging level permanently by adjusting the `log4j.properties` files - see the Atlassian Confluence [Logging Levels](https://confluence.atlassian.com/doc/configuring-logging-181535215.html) documentation.
