# Groovy 4 Breaking Change for Grab Annotations

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4js-442889310
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/groovy-4-breaking-change-for-grab-annotations

There has been a breaking change in Groovy 4 for users using `[@Grab](http://docs.groovy-lang.org/latest/html/documentation/grape.html)` to import certain libraries. This page describes the error that occurs, the symptoms, and the solutions you can implement. 

## Summary of the problem

We have noticed that some users encounter the error below after upgrading to Scriptrunner version 8.0.0 or newer. This error is caused by using the `@Grab` annotation to import libraries into a script where that library has transitive dependencies that are not compatible with Groovy 4. All ScriptRunner versions from 8.0.0 onwards use Groovy 4. If a library imported with `@Grab` has transitive dependencies incompatible with Groovy 4, it will cause script compilation to break.

This is not a ScriptRunner-specific bug. It impacts anyone using Groovy 4 on any platform.

### Error

```
No such property: importPackages for class: org.codehaus.groovy.ast.ModuleNode
```

## Symptoms

If you have triggered a script that contains a `@Grab` call that pulls in a problematic library, it will cause all features in ScriptRunner that use user-created scripts to stop working and produce the above error. This is because once the script has been triggered the incompatible library is added to the classpath, which all ScriptRunner features use.

## Solution

There are three main solution paths you can take and these are described below. 

For any solution path, if you make changes that remove or update the `@Grab` annotation, you must run the [Clear the Groovy class loader cache](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clear-groovy-class-loader) built-in script. If you do not do this, the broken library will still be on the classpath, and any changes you make will not stop the error from occurring when triggering ScriptRunner scripts/features.

Finding my scripts

To find the scripts on your server that use the `@Grab` annotation, you can run the [Script registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) built-in script, and then use the browser shortcut (CTRL + F or CMD + F) to find `@Grab(`.

### Solution 1: Update the `@Grab` call not to import transitive dependencies

An example `@Grab` call that can cause this error on Groovy 4 is shown below:

```
@Grab('com.github.groovy-wslite:groovy-wslite:1.1.2')
```

To prevent the `@Grab` call from pulling in transitive dependencies, you would amend the above to:

```
@Grab('com.github.groovy-wslite:groovy-wslite:1.1.2;transitive=false')
```

This will not take effect until you run the [Clear the Groovy class loader cache](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clear-groovy-class-loader) built-in script, which removes the broken dependencies from the class loader.

### Solution 2: Update the version of the library you are  importing with `@Grab` to a version that is compatible with Groovy 4

The quickest way to determine if the `@Grab` imported library works in Groovy 4 is to try it on Groovy 4. If you have Groovy installed locally on your machine, you can use the _groovyconsole_ as described [in the Apache Groovy documentation](https://groovy-lang.org/groovyconsole.html).

Make sure your local install of Groovy is set to use a Groovy 4 SDK

If you have a test server running ScriptRunner 8.0.0 or newer, you can try it in the Script console, but remember, if you trigger the error, you must clear the class loader cache again to fix it. Do not do this in production because it will stop all ScriptRunner features from working.

### Solution 3: Use a library that is already part of ScriptRunner to do what your `@Grab` library is doing

This solution involves removing `@Grab` calls and using existing libraries provided with ScriptRunner.

`@Grab` makes external calls to download libraries. If a library is already available on the classpath, you can avoid these external calls and use a standard import statement instead.

Several users import libraries with `@Grab` that allow them to make REST calls. ScriptRunner includes the `[org.codehaus.groovy.modules.http-builder](https://github.com/jgritman/httpbuilder/wiki)` library, which is documented [here](https://github.com/jgritman/httpbuilder/wiki). This library can most likely do whatever you need to do concerning making external REST calls. This library has classes like  `groovyx.net``.http.HTTPBuilder` and `groovyx.net``.http.RESTClient`. Both classes can be accessed with a simple import, with no `@Grab` calls required.  

For example, if you want to make a GET REST call with a REST client, you can do this:

```
import groovyx.net.http.RESTClient

def client = new RESTClient('https://jsonplaceholder.typicode.com')
def resp = client.get( path: '/todos/1' )

resp['data']
```
