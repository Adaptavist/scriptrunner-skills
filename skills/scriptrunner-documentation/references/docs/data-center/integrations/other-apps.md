# Other Apps

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations
- Doc ID: doc-sr4js-fe9c5b9c-f328-4129-8ada-a93bdf79bd2a-d230bd6bde040952
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps

A focus of ScriptRunner is being able to script other plugins, for instance, Jira Software, Structure, etc.

Two annotations allow this. The first is `@WithPlugin(pluginKey)`, which effectively makes classes provided by the target plugin available to your script.

The second is `@PluginModule`, which injects an instance of this module into your script.

Note: Jira Software is a special case (see [Working With Jira Agile](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/jira-agile)).

## @WithPlugin

Add this annotation to your script or on a class. It takes the plugin key as an argument. You can get the plugin key from the Manage Plugins screen:

When this annotation is present, the classloader for the target plugin is added to the list of classloaders when the script is compiled and run. Meaning imports from, for example, the Structure plugin, will be resolved.

## @PluginModule

Annotating a variable in a class or a script injects an instance of this type into your script. This is most commonly used for getting hold of a module defined in another plugin. In a traditional plugin, you would use `<component-import>` to achieve this.

If you are working with Structure you may use:

```
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.StructureServices
// ...
@PluginModule
StructureServices structureServices
```

Structure is quite easy because given a [StructureServices](https://wiki.almworks.com/display/structure/Structure+Services) you can get all the other services from that.

Warning: Do not initialize the variable yourself, for example: 

```
@PluginModule
StructureServices structureServices = null
```

This produces an error:

```
startup failed: General error during semantic analysis: Cannot set plugin module when field already initialized
```

If you are working with IntelliJ IDEA you may get a warning about uninitialized variables:

You can disable this with `//noinspection GroovyVariableNotAssigned` on your first use of the variable.
