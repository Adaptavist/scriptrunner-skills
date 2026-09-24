# Script Roots

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-8247d10b-2f84-4f44-acb8-3f2fda70f687-fc45ddb7122c8e42
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#script-roots--en

Script Roots are directories that ScriptRunner will automatically scan for scripts.

The scripts you store here will be available across all of ScriptRunner.

Dependent classes are automatically detected and recompiled. The one exception is when you first change a dependent class without changing the class/script that's actually called. However if you make a small change like adding a space to comment in the calling script, the changes to the base or dependent class trigger recompilation of both.

## Set up

When the _ScriptRunner_ plugin is first installed, it creates a directory called _Scripts_ under your Confluence home directory and registers this directory as one of its script roots. This directory is sufficient for most users and no other configuration need be made. This is a logical place to store your scripts because it is preserved during Confluence upgrades, and it is accessible by all nodes in a clustered Confluence.

You can create subdirectories for your scripts. You could divide them into the business process they support. You could also create supporting or utility classes to be used by the subdirectories.

CAUTION: Make sure the supporting and utility classes have the correct package name or you will get a compilation error.

For example, a script and a class:

<confluence-home>/scripts/foo.groovy

```
import util.Bollo

log.debug ("Hello from the script")
Bollo.sayHello()
```

<confluence-home>/scripts/util/Bollo.groovy

```
package util

public class Bollo {
    public static String sayHello() {
        "hello sailor!!!"
    }
}
```

Absolute paths outside of script roots continue to work, but changes to dependent classes may not be detected.

## Relative paths

Relative paths are resolved to the script root until a file is found. If you want to use a path you had set up previously, you can add a script root that points to the working directory or to a place where your scripts were kept.

Let's say that your Confluence instance is in `/usr/opt/Confluence` and your scripts are in `/usr/opt/scripts`, so you refer to them like this: `../scripts/foo.groovy`.

When you implement script roots, you need a new property that points to your scripts directory, which would be `set JAVA_OPTS=%JAVA_OPTS% -Dplugin.script.roots=/usr/opt/scripts`.

Note: Resolving `../scripts/foo.groovy` relative to this script path has the same result.

## Tips

-   If you have multiple roots, use a comma to delimit them.
-   If you work on a script locally before deploying to production, set breakpoints in scripts or classes and attach the debugger.
-   If you work on the ScriptRunner plugin, add the SRC and test directories from the checkout so you can work on the scripts without having to recompile.
    
    For example: `set JAVA_OPTS=%JAVA_OPTS% -Dplugin.script.roots=checkout-directory\src\main\resources,checkout-directory\src\test\resources`
    

## Script Root Search

You can search for scripts contained in your configured script roots. Wherever you can enter the path of a script to run, you can search for the script directly in the script file input. You can search by script name, or you can browse the sub-directory structure to find the script you're looking for.

### Search by name

In the file entry, type the filename of the script and select it when you find it.

The script loads for use, and the static type checking begins.

### Browse the script root directory

This is a good option if you don't know the filename of the script but think it exists in a script root.

1.  Type the name of the subdirectory you want to browse.
    
    Tip: If there are lots of directories returned, try to keep refining the search. As you add characters to your search phrase, the results will be refined.
    
2.  Select the directory you want to browse.
    
    Now you will see a list of scripts and subdirectories in that directory.
    
    When you navigate into a directory, the results only show the scripts in that directory. If you want to search all scripts, remove all characters from the input and start again.
    

Tip: You can use tab completion to navigate the directory structure. If you go too far, remove the characters to the previous slash to return the search to the previous directory.

### Result types

The following table contains the different types of results that the search could return:

| Icon | Description |
| --- | --- |
|  | An executable groovy script |
|  | A sub-directory within one of your script roots |
