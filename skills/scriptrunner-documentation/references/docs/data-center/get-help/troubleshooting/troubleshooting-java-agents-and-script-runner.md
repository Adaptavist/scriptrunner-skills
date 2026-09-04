# Troubleshooting Java Agents and ScriptRunner

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > troubleshooting
- Doc ID: doc-sr4js-348419523
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-java-agents-and-scriptrunner

DataCenter admins have a tough job keeping a service running 24/7, and ScriptRunner is a big help. But sometimes ScriptRunner and Java Agents don't work well together.

ScriptRunner has had intermittent, difficult-to-resolve conflicts with Java monitoring tools like TraceLytics, AppDynamics, DataDog, DynaTrace, and others. The trouble is that none of these monitoring tools _consistently_ produce the same problems within ScriptRunner. 

To better help our customers keep their Atlassian apps running, we have compiled what we know about Java monitoring agents. Please note that the implementation details of different Java monitoring agents will vary, and w_e_ can't realistically keep up with the many details.

That said, this is what we know and can share with you.

# General troubleshooting advice

## Staging environment

If you've reached the scale that you want Java Monitoring tools in your instance, you should have a staging environment. Make sure to test out updates to your Java Agent and plugins in your staging environment first. Additionally, keep your staging environment's script configurations closely aligned with production, so that you can catch any problems before they actually go to production. This can help catch any conflicts between your Java Agent and ScriptRunner before they cause problems for your users.

## Try disabling the Java Agent

A good way to see if the Java Agent is part of the problem is to disable it temporarily in an environment where you can reproduce the problem. If the problem goes away, there may be a conflict between ScriptRunner and your particular Java Agent.

## Check your logs

Often, when a Java Agent causes ScriptRunner to enter an error state, there will be a large stack trace error in the application logs. Atlassian Support may identify ScriptRunner's code in the stacktrace. If your Java Agent's code appears in the same stacktrace, that may be an indicator of the conflict.

## Collaborative support

While supporting every Java Agent out there is beyond the scope of our support; we are happy to work with other vendors to try and resolve any problems for our customers. If you have an open ticket with us that has been narrowed down to a problem with your Java Agent and you _also_ have support from the Java Agent's vendor, you can use their support system to put us in touch with them. We can then discuss the details of the problem with them to see if we can reach a resolution.

# Particular Java Agents

## DataDog

[DataDog](https://www.datadoghq.com/) is one popular monitoring tool with Java Agent capability.

Some issues with ScriptRunner have been resolved in the most recent version of the Java Agent. For instructions on downloading and installing the latest version, see the [DataDog documentation](https://docs.datadoghq.com/tracing/trace_collection/dd_libraries/java/?tab=containers).

Alternatively, disabling DataDog's tracing on classloading may resolve problems for older versions. You can either add this JVM option to your Atlassian app's startup options:

```
-Ddd.resolver.use.loadclass=false
```

or set this environment variable:

```
DD_RESOLVER_USE_LOADCLASS=false
```
