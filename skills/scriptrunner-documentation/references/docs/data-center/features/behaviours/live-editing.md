# Live Editing

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442888037
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/live-editing

For live editing and improved efficiency in script management, we recommend you use external script files rather than inline scripts. This approach eliminates the need for frequent manual saving and allows for automatic updates within the [Script Roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).

To implement this method you can use the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) to create and manage your external script files. When you're creating a Behaviour you can point to the file you created. 

![](/sr4js/files/latest/442888037/442888039/1/1758746900000/Add_file.png)

  

If you have a groovy script as opposed to a groovy class the method name should be `run`.

## Code completions for IDE users

If you're using an IDE you can get code completions by adding the following lines at the beginning of your script:

```
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours
```

## Related content

-   [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor)
-   [Write Code](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code)
-   [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms)
