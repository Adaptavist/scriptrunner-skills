# Store all Environment Specific Variables

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442888980
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/store-all-environment-specific-variables

You may wish to write and test your ScriptRunner scripts on a test/development instance before migrating over to your production instance. Manually editing environment-specific variables in each custom script is time-consuming and prone to errors. We suggest you use names rather than IDs in scripts as the name of custom components do not typically change when migrating to a production instance.

Sometimes, there can be multiple components (such as custom fields) with the same name. When this is the case, we suggest searching for the field name in the context of the issue you have.

For example, in Jira you could run the following:

```
import static com.atlassian.jira.component.ComponentAccessor.customFieldManager

def customField = customFieldManager.getCustomFieldObjects(issue).findByName('Approvals')
```

Did you know you can also use [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms) to create scripts with editable configuration parameters?

## Storing Variables

If you can’t use names as suggested above, then you need to abstract the IDs to a centralised place to avoid hard-coding them in multiple scripts.

Here we describe two ways of doing that - one using a simple java class that varies between environments, and the second one which reads configuration from a YAML file. Storing variables in the application home directory, or an environment-specific class, removes the need to edit custom scripts manually.

### Groovy Class

1.  The most simple method is to create a class like the following (add as many fields as required to this class):
    
    ```
package com.acme

class Config {
    static final String APPROVALS_FIELD_ID = 'customfield_12345'
    static final String SOME_OTHER_FIELD_ID = 'customfield_12345'
    static final Integer SOME_NUMBER = 65_000
}
```
    
    The package `com.acme` is used here, which can be replaced with something meaningful for your company. Because of the package, the class must be placed in a directory: `com/acme`, underneath the script root.
    
    You could use the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) to create the class, or add to the file system directly.
    
2.  Then access one of the variables in your script (either inline or using a file):
    
    ```
import com.acme.Config

Config.APPROVALS_FIELD_ID
```
    

The advantage of this method, besides the simplicity, is you won’t need to cast the type to a _String_ or other class.

The disadvantage is that this requires a different version of the _Config_ class in each environment. If using a version control system to manage your script root, this method would involve some manual copying and could be a maintenance burden.

### YAML File

One way of storing environment-specific variables is to create a class which will read a YAML file. Below is an example YAML file but this method works with any valid YAML file:

```
Approvals: customfield_12345
Long Custom Field Name: customfield_56789
```

1.  Place the YAML file at the root of the instance home directory (this can be changed if necessary).
    
    The _config_ file is loaded once to avoid multiple file system IO.
    
    ```
package com.acme

import com.atlassian.util.concurrent.ResettableLazyReference
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import com.onresolve.scriptrunner.runner.diag.ClusterHomeLocatorService
import org.yaml.snakeyaml.Yaml

class CachedFileConfig {

    private static final ResettableLazyReference<Map> configRef = new ResettableLazyReference() {
        protected Map create() {
            loadConfig()
        }
    }

    static Map getConfig() {
        configRef.get()
    }

    static void reload() {
        configRef.reset()
    }

    static Map loadConfig() {
        def clusterHomeLocatorService = ScriptRunnerImpl.scriptRunner.getBean(ClusterHomeLocatorService)

        // by default the config file is loaded from <platform.home.dir>/config.yaml. For DC instances, this is the shared home directory.
        new File(clusterHomeLocatorService.sharedHomeDir, 'config.yaml').withReader { reader ->
            def yaml = new Yaml()
            yaml.load(reader) as Map
        }
    }
}
```
    
2.  Run the following to retrieve a variable:
    
    ```
import com.acme.CachedFileConfig

def config = CachedFileConfig.getConfig()
log.debug config['Approvals']
```
    
    The configuration is cached. If you modify the .yaml file and want the scripts to pick up new values, you need to either disable then enable ScriptRunner(or restart your instance) or run the following console script:
    
    ```
import com.acme.CachedFileConfig

CachedFileConfig.reload()
```
