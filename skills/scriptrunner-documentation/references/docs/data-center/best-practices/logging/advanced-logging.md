# Advanced Logging

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > logging
- Doc ID: doc-sr4js-280527055
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging/advanced-logging

Log4j 1 and Log4j 2

In Jira 9.5, Atlassian upgraded the Log4j runtime logging library to version 2. If you have Jira 9.4 or sooner, you should use the **Log4j 1**. If you have Jira 9.5 or later, you should use the **Log4j 2**. Read more about this change in Atlassian's documentation on [Migrating custom logging configurations to Log4j 2](https://confluence.atlassian.com/jirakb/migrating-custom-logging-configurations-to-log4j-2-1188771818.html).

## What is the variable 'log'?

The `log` variable is injected into every ScriptRunner inline script, and its value is equivalent to:

```
def log = Logger.getLogger("com.onresolve.scriptrunner.runner.ScriptRunnerImpl")
```

`log` is an instance of a [Logger](https://logging.apache.org/log4j/1.2/apidocs/index.html).

## Using your own logger

It might be preferable to use your own logger so that you can adjust logging levels separately from ScriptRunner as a whole.

In an inline script, or file, you can do this using the following code:

```
import org.apache.log4j.Logger

def log = Logger.getLogger("com.acme.workflows")
log.warn("Workflow function running...")
```

If you use classes the simplest way to get a logger is to use the `@Log4j` annotation:

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

In the above example, the `log` instance is automatically created and will have the category `com.acme.workflows.Foo`, that is, the fully qualified class name.

This is the best way of logging, as it will automatically wrap calls to the logger in the relevant guarding function, e.g. `if (log.isDebugEnabled()) {log.debug(…​)}`

## Log Levels

A log message is printed if the logging level is the same or higher than the configured level for that category.

For detailed information on logging levels, see [log4j Logging Levels](https://www.tutorialspoint.com/log4j/log4j_logging_levels.htm).

The default log level for most categories is `WARN`. Take a note of the default log level before making any changes. Therefore, if you want to use `log.debug`, the category level must be set to `DEBUG` or `TRACE`.

Take a note of the default log level before making any changes.

Temporarily enable ScriptRunner logging under **System>Logging and Profiling** in the _Administration_ menu. Set the `com.onresolve` package to **DEBUG** under _Default Loggers_.

![](/sr4js/files/latest/280527055/280527054/1/1724076726000/logging-debug-level+%281%29.png)

This sets the logging level until the instance is restarted or the logging level is changed manually (to the default **WARN** for example).

You can change the logging level permanently by adjusting the `log4j.properties` (log4j) or `log4j2.xml` (log4j2) files - see the Atlassian Jira [Logging Levels](https://confluence.atlassian.com/jirakb/change-logging-levels-in-jira-server-629178605.html) documentation.

Unless you have changed your default output log file, ScriptRunner logs to the `atlassian-jira.log` file under `<JiraHome>/log/` for more information see the Atlassian [Logging and Profiling](https://confluence.atlassian.com/adminjiraserver/logging-and-profiling-938847671.html) documentation.

## Using another file for logging

By default all log entries go to "atlassian-jira.log". However, you might want to have your scripts, or ScriptRunner itself, log to another file.

This can help you remove noise and debug your scripts more efficiently.

See instructions for Log4j 1

### Step 1: Create your own appender

The logger is configured in your log4j.properties file. This file can be found by default at WEB-INF/classes path within your JIRA\_HOME directory.

Log4J uses its own structure to output to different log files. First of all you need to create your own appender.

This is the entity that dispatches the messages from the plugin to the correct file. Our appender will be called "ScriptRunnerLogger". You can insert the following code anywhere within your log4j.properties file.

```
#ScriptRunner logger
log4j.appender.ScriptRunnerLogger=com.atlassian.jira.logging.JiraHomeAppender
#Here you define the log file name
log4j.appender.ScriptRunnerLogger.File=ScriptRunnerLogFile.log
log4j.appender.ScriptRunnerLogger.MaxFileSize=20480KB
log4j.appender.ScriptRunnerLogger.MaxBackupIndex=5
log4j.appender.ScriptRunnerLogger.layout=com.atlassian.logging.log4j.NewLineIndentingFilteringPatternLayout
log4j.appender.ScriptRunnerLogger.layout.ConversionPattern=%d %t %p %X{jira.username} [%c{4}] %m%n
```

You can modify various settings here. For instance, to change the layout see the documentation on [PatternLayout](https://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/PatternLayout.html).

### Step 2: Forward the ScriptRunner logs to the appender

Once we have the appender, we need to tell your package to use it. If you wanted to simply move the ScriptRunner logs to another file, you would, after the code above, add the following snippet:

```
log4j.logger.com.onresolve = WARN, console, ScriptRunnerLogger
log4j.additivity.com.onresolve = false
```

If you have followed the advice above and used your own category, you could instead (or as well) add:

```
log4j.logger.com.acme = DEBUG, console, ScriptRunnerLogger
log4j.additivity.com.acme = false
```

This sets the logging threshold to `DEBUG`…​ you may wish to set it to `INFO` or `WARN`.

Once this is done, it is important that you restart your Jira instance. If you don’t, the changes will not be picked up.

After doing this any logging that you use, and that is in the plugin itself, will be forwarded to your new "ScriptRunnerLoggerLogFile.log"

See instructions for Log4j 2

### Step 1: Create your own appender

The logger is configured in your log4j2.xml file. This file can be found by default at WEB-INF/classes path within your JIRA\_HOME directory.

Log4J uses its own structure to output to different log files. First of all you need to create your own appender.

This is the entity that dispatches the messages from the plugin to the correct file. Our appender will be called `ScriptRunnerLogger`. You can insert the following code into your log4j.xml file:

```
<Appenders>
  <JiraHomeAppender name="ScriptRunnerLogger"
                  fileName="ScriptRunnerLogFile.log"
                  filePattern="ScriptRunnerLogFile.log.%i">
    <PatternLayout alwaysWriteExceptions="false">
      <Pattern>
        %d %t %p %X{jira.username} [%c{2}] %m%n
      </Pattern>
    </PatternLayout>
    <Policies>
      <SizeBasedTriggeringPolicy size="20480 KB"/>
    </Policies>
    <DefaultRolloverStrategy fileIndex="min" max="5"/>
  </JiraHomeAppender>
</Appenders>
```

You can modify various settings here. For instance, to change the layout see the documentation on [PatternLayout](https://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/PatternLayout.html).

### Step 2: Forward the ScriptRunner logs to the appender

Once we have the appender, we need to tell your package to use it. If you wanted to simply move the ScriptRunner logs to another file, you would, add the following snippet under the appenders defined above:

```
<Loggers>
  <Logger name="com.onresolve" level="WARN" additivity="false">
    <AppenderRef ref="ScriptRunnerLogger"/>
  </Logger>
</Loggers>
```

If you have followed the advice above and used your own category, you could instead (or as well) add:

```
<Loggers>
  <Logger name="com.acme" level="DEBUG" additivity="false">
    <AppenderRef ref="ScriptRunnerLogger"/>
  </Logger>
</Loggers>
```

This sets the logging threshold to `DEBUG`…​ you may wish to set it to `INFO` or `WARN`.

Once this is done, it is important that you restart your Jira instance. If you don’t, the changes will not be picked up.

After doing this any logging that you use, and that is in the plugin itself, will be forwarded to your new "ScriptRunnerLoggerLogFile.log"
