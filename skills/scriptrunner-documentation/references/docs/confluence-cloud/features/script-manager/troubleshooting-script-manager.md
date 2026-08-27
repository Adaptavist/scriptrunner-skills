# Troubleshooting Script Manager

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > script-manager
- Doc ID: doc-sr4cc-506007585
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-manager/troubleshooting-script-manager

Script Manager is available for Groovy code editors **only**.

## Common errors

### Compilation errors

These error types are mainly due to one of the following reasons:

-   The saved script was renamed, moved, or deleted.
    
-   The package path doesn’t match the folder structure.
    
-   Class was not found due to missing import.
    
-   A dependent saved script fails to compile.
    

An error will typically mention a class or '_script_ _not found'_.

### Missing saved scripts

When a saved script has been deleted but is still referenced:

-   Script failing with compilation errors of missing classes or properties.
    
-   Some execution errors will reference **only the script ID**.
    
    -   The name of the deleted script is not available.
        
    -   Fix: Choose a new saved script, or contact Support to have the deleted script restored.
        

## Troubleshooting FAQs

### Was a saved script deleted?

You should check the following:

-   Missing script, or missing method exceptions.
-   _'Script not found'_ errors that reference a UUID.

### Does the folder path match the package declaration?

You may notice this as a missing script, or missing method exceptions.

### Autocomplete does not appear to work

Autocomplete only works for classes, not plain scripts. It will work for methods contained within scripts too, but only after a manual import has occurred.

Some level of failure can occur during autocompletion as we fetch code from remote storage and compile on the fly so if a saved script appears to be missing according to the autocompletion but you know it's there, you can fallback to writing the import statement manually. 

You can use the **Load** button to browse the code base in Script Manager and remind yourself of the exact name and location of a saved script.

### Script Manager content is unusually large, or deeply nested

If there are too many scripts, you should simplify. 

We have built Script Manager to handle hundreds of scripts, even thousands. However, Cloud environments can have drawbacks when operating at such scales and various limiting conditions can occur depending on variations like scripts size, scripts count, names length and other. We recommend that if you use large numbers of saved scripts then it should only be considered as an extreme case and efforts should be made to prevent the code base from reaching such extents.

## Other limitations

-   We do not enforce a hard limit on the number of scripts you can create. However, based on maximum name length and other system considerations, we recommend keeping your codebase to **no more than 3,000 scripts**.
    
-   There is no restriction on script length, but very large scripts can be difficult to maintain. We recommend organizing your code into smaller, easier-to-maintain scripts.
    
-   Script Manager does not introduce significant performance overhead. However, because scripts are stored in the cloud, you may experience minor sub-second delays when modified scripts are loaded into the runtime environment.
    

## Recommendations

The name of the file should match the name of the class described within the file. It is necessary that the name of the script, for example, ABC.groovy, is the same as the class name:

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

If multiple classes within one file is preferred, you can create one overarching class that contain child classes within:

**DoubleClass.groovy**

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

**Script Console**

```
import utils.DoubleClass
logger.info(DoubleClass.DoubleClassOne.returnSomething('Hi')+DoubleClass.DoubleClassTwo.returnSomething('Bye'))
```
