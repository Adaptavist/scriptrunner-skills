# Troubleshooting Script Manager

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Script Manager
- Doc ID: doc-sr4cc-d14434bb-7041-4709-915a-688f26c34109-8d75bf258f01f942
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-manager#troubleshooting-script-manager--en

Our tips to help figure out why you're having a problem in the Script Manager.

Note: Script Manager is available for Groovy code editors only.

## Compilation errors

These error types are mainly due to one of the following reasons:

-   The saved script was renamed, moved, or deleted.
-   The package path doesn't match the folder structure.
-   Class was not found due to missing import.
-   A dependent saved script fails to compile.

An error will typically mention a class or _'script_ _not found'_.

## Missing saved scripts

When a saved script has been deleted but is still referenced:

-   Script failing with compilation errors of missing classes or properties.
-   Some execution errors will reference only the script ID.
    -   The name of the deleted script is not available.
    -   Fix: Choose a new saved script or contact Support to have the deleted script restored.

## Was a saved script deleted?

You should check the following:

-   Missing script or missing method exceptions.
-   `Script not found` errors that reference a UUID.

## Does the folder path match the package declaration?

You may notice this as a missing script or missing method exception.

## Autocomplete does not appear to work

Autocomplete works only for classes, not for plain scripts. It will work for methods contained within scripts too, but only after a manual import has occurred.

Some failures can occur during autocompletion because we fetch code from remote storage and compile on the fly. So, if a saved script appears to be missing in autocompletion but you know it's there, you can fall back to writing the import statement manually.

Tip: You can use the Load button to browse the codebase in Script Manager and remind yourself of the exact name and location of a saved script.

## Script Manager content is unusually large or deeply nested

If there are too many scripts, you should simplify.

We have built Script Manager to handle hundreds of scripts, even thousands. However, Cloud environments can have drawbacks when operating at such scales, and various limiting conditions can arise depending on factors such as script size, script count, name length and others. We recommend that, if you use a large number of saved scripts, it be considered an extreme case, and that efforts be made to prevent the codebase from reaching such an extent.

## Other limitations

-   We do not enforce a hard limit on the number of scripts you can create. However, based on maximum name length and other system considerations, we recommend keeping your codebase to no more than 3,000 scripts.
-   There is no restriction on script length, but very large scripts can be difficult to maintain. We recommend organizing your code into smaller, easier-to-maintain scripts.
-   Script Manager does not introduce significant performance overhead. However, because scripts are stored in the cloud, you may experience minor sub-second delays when modified scripts are loaded into the runtime environment.

## Recommendations

The file name should match the name of the class described in the file. It is necessary that the name of the script, for example, `ABC.groovy`, is the same as the class name:

```
class ABC {
}
```

We recommend creating a class in the script rather than making it in several classes or methods:

```
package utils
 
class Test {
    static def myTest1() {
        return "hello"
    }
    
    static def myTest2() {
        return "goodbye"
    }
}
```

If multiple classes within one file are preferred, you can create one overarching class that contains child classes within:

DoubleClass.groovy

```
package utils
public class DoubleClass{
    class DoubleClassOne{
        static String returnSomething(String something){
            return something;
        }
    }
    class DoubleClassTwo{
        static String returnSomething(String something){
            return something;
        }
    }
}
```

Script Console

```
import utils.DoubleClass
logger.info(DoubleClass.DoubleClassOne.returnSomething('Hi')+DoubleClass.DoubleClassTwo.returnSomething('Bye'))
```
