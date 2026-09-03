# Other Apps

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations
- Doc ID: doc-sr4js-101624699
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps

A focus of ScriptRunner is being able to script other plugins, for instance, Jira Software, Structure, etc.

Two annotations allow this. The first is `@WithPlugin(pluginKey)`, which effectively makes classes provided by the target plugin available to your script.

The second is `@PluginModule`, which injects an instance of this module into your script.

Jira Software is a special case (see [Working With Jira Agile](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/jira-agile)).

## @WithPlugin

Add this annotation to your script or on a class. It takes the plugin key as an argument. You can get the plugin key from the _Manage Plugins_ screen:

![](/sr4js/files/latest/101624699/101628167/1/1600973825000/withplugin-app-key.png)

When this annotation is present, the classloader for the target plugin is added to the list of classloaders when the script is compiled and run. Meaning imports from, for example, the Structure plugin, will be resolved.

## @PluginModule

Annotating a _variable_ in a class or a script injects an instance of this type into your script. This is most commonly used for getting hold of a module defined in another plugin. In a traditional plugin, you would use `<component-import>` to achieve this.

If you are working with Structure you may use:

```
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.StructureServices
// ...
@PluginModule
StructureServices structureServices
```

  

Structure is quite easy because given a [StructureServices](https://wiki.almworks.com/display/structure/Structure+Services) you can get all the other services from that.

Do not initialize the variable yourself, for example:

```
@PluginModule
StructureServices structureServices = null
```

This produces an error:

```
startup failed: General error during semantic analysis: Cannot set plugin module when field already initialized
```

  

If you are working with IntelliJ IDEA you may get a warning about uninitialized variables:

You can disable this with `//noinspection GroovyVariableNotAssigned` on your first use of the variable.
