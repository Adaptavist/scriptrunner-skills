# Category Mappings

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442888053
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/category-mappings

Behaviours are mapped to projects (and optionally issue types within projects) or service desks (optionally request types). To map a behaviour to several related projects, map to project categories rather than individual projects. Map behaviours to a project category using a [Custom Listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener) to update mappings using a simple API.

Set up a _Global_ listener to handle a _ProjectCategoryChangeEvent_, and add as many category mappings as required (project or service desk mappings). When a project has a category added or removed, the event handler fires, and mappings relevant to that category are updated.

## Create a Custom Listener to update mappings

1.  From ScriptRunner, go to **Listeners**. 
2.  Select **Create Listener > Custom listener**. 
3.  Enter a **Name** for the listener, for example _Update Mappings_.
4.  Select **Global** to apply the listener to all projects on your instance. 
5.  Select _ProjectCategoryChangeEvent_ in **Events.**
6.  Add a script to the **Script** field specifying the project category and behaviour. See below for some [script examples](#id-.CategoryMappingsv9.x-mapping-examples).
    
    If there is more than one behaviour with the same name, only one of them is updated (the first). Please check your behaviour names before attempting this and edit where necessary. 
    
    ![](/sr4js/files/latest/442888053/442888055/2/1758746901000/Category_mappings.png)
    

## Examples

To map all projects in _My Category_ to a behaviour named _My Behaviour_:

```
                    import com.onresolve.jira.behaviours.BehavioursCategoryMappingService
                    import com.onresolve.scriptrunner.runner.customisers.PluginModule
                    
                    @PluginModule
                    BehavioursCategoryMappingService categoryMappingService

                    categoryMappingService.categoryProjectMapping(event, 'My Category', 'My Behaviour')
```

To map just issue types _Bug_ and _Task_ in projects in _My Category_ to a behaviour named _My Behaviour_:

```
                import com.onresolve.jira.behaviours.BehavioursCategoryMappingService
                import com.onresolve.scriptrunner.runner.customisers.PluginModule
                
                @PluginModule
                BehavioursCategoryMappingService categoryMappingService

                categoryMappingService.categoryProjectMapping(event, 'My Category', 'My Behaviour', 'Bug', 'Task')
```

To create a service desk mapping to all service desk projects in _My Category_ to a behaviour named _My Behaviour_:

```
                    import com.onresolve.jira.behaviours.BehavioursCategoryMappingService
                    import com.onresolve.scriptrunner.runner.customisers.PluginModule
                    
                    @PluginModule
                    BehavioursCategoryMappingService categoryMappingService
                    
                    categoryMappingService.categoryServiceDeskMapping(event, 'My Category', 'My Behaviour')
```

To create a service desk mapping for request types _Employee exit_ and _New employee_**,** to all service desk projects in _My Category_ to a behaviour named _My Behaviour_:

```
            import com.onresolve.jira.behaviours.BehavioursCategoryMappingService
            import com.onresolve.scriptrunner.runner.customisers.PluginModule
            
            @PluginModule
            BehavioursCategoryMappingService categoryMappingService
            
            categoryMappingService.categoryServiceDeskMapping(event, 'My Category', 'My Behaviour', 'Employee exit', 'New employee')
```
