# Script Editor FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-101626130
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-editor-faqs

## Why is there an Incorrect Package Declaration Message in the Script Editor?

There is no requirement for you to fix existing scripts; it is just a recommendation.

### Warning introduced in version 7.1.0

In version 7.1.0, we introduced a warning message to the Script Editor to flag invalid/missing package declarations in script files. The message stated these invalid/missing package declarations wouldn't be supported from version 9.0.0 onwards. However, this is no longer the case. **We will not do anything that breaks existing usage in future releases.**

You will see a warning message (shown below) if you create, or have previously created, a script file under a directory without specifying a valid package declaration, something that we encourage in our [best practices](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) guide. This warning displays in Script Editor or when adding a script file to a feature configuration screen.

There is a bug in version 7.1.0 relating to the mismatch of package declaration warnings in the script registry and script editor. Always refer to the warning(s) shown in Script Editor. This bug was fixed in version 7.3.0. 

There is an additional bug that validates the last imported class in a script rather than the actual package declaration. This bug is due to be fixed in version 7.5.0. 

![Image showing warning message](/files/151624079/151628073/1/1668616522000/Package_declaration_1.png)

### Why we introduced a warning message

We recommended you use correct package declarations to prevent class name conflicts where you may have two files with the same name in different packages. For example, if you had `foo/bar/file.groovy` and `abc/pqr/file.groovy` without the package declaration, both would be loaded as `file.class`. Suppose you have the same named script in two different directories, and you don't have correct package declarations and import them into another script. In that case, you can get non-deterministic behaviour regarding which script is imported.

### Warning to be updated in an upcoming release

We are in the process of updating the warning to an information message, as we will not remove support for invalid/missing package declarations from version 9.0.0. We suggest you use packages correctly for new scripts/classes, **but there is no requirement to fix existing scripts**, unless you want to. In the meantime we are looking at what tools we can provide, so it's easier to update existing scripts.

### How do you get rid of this message?

There is no way to bulk update incorrect package declarations and scripts that reference them. If you have multiple scripts that need updating, you need to update them one at a time. 

#### Solution if there is no package declaration and the class isn't imported in any other script files

The solution is straightforward, and you must add the correct package declaration, as mentioned in the warning message at the top of the script. 

For example, as mentioned in the screenshot above, adding `package common` should remove the warning message.

![Image correcting the warning message](/files/151624079/151628072/1/1668616522000/Package_declaration_4.png)

#### Solution if there is no package declaration and the class is imported in other script files

If you have imported this class in another script, in addition to adding the correct package declaration, you must rectify the `import` statement. For example, script files that import the class will show the error below.

As you can tell, if you had more than one file with the same name in different directories, it would not be possible to identify the correct class to load, which is one of the reasons for enforcing correct package declarations.

![Additional image displaying package declaration message](/files/151624079/151628071/1/1668616522000/Package_declaration_3.png)

To fix this, update the import statement to include the package name. In this example, it is `import` `common.util`.

![Image displaying correct import message](/files/151624079/151628074/1/1668616522000/Package_declaration_2.png)

#### Solution if there is no package declaration and the directory structure is incorrect

A package declaration should be made up of [valid identifiers](https://groovy-lang.org/syntax.html#_identifiers) and not contain any of the reserved [keywords](https://docs.oracle.com/javase/tutorial/java/nutsandbolts/_keywords.html). We recommend that you follow the naming convention for [Java Packages](https://docs.oracle.com/javase/tutorial/java/package/namingpkgs.htm).

Sometimes, the directory names may contain identifiers not valid in a package name. For example, `int/util.groovy` contains a keyword that can't be used as an identifier. In such cases, you will need to rename the directory structure so that it forms a valid package name.

1.  Rename the directory to something like `int_/util.groovy`.
2.  Add the correct package declaration to the `util.groovy` after the directory is renamed, for example, `package int_`.
3.  Update import statements in any scripts that import this class.
4.  Change import statements from `import util` to `import int_.util`.
5.  Since you changed the directory name, you need to update any references to this file. If the file was used in a listener configuration, edit the configuration and **choose** the file in the renamed directory.

## When is the issue object available by default in the script editor?

The issue object is available in the following contexts:

-   Post-functions
    
-   Listeners (as `event.issue`)
    
    The issue binding variable is only available for events that contain a single issue object. This means only issue events (excluding issue link events).
    
-   Behaviours (as `underlyingIssue`)
    
    Not available on the _Create_ screen.
    
-   Scripted Fields
    

You will have to declare a specific issue object in the following contexts:

-   Script Console
    
-   Mail Handler
