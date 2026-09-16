# Live Editing

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours
- Doc ID: doc-sr4js-b3b48717-199a-4dd7-a9f7-71a11fdb9f59-0bef07c601e01bad
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#live-editing--en

For live editing and improved efficiency in script management, we recommend you use external script files rather than inline scripts. This approach eliminates the need for frequent manual saving and allows for automatic updates within the [Script Roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).

To implement this method you can use the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) to create and manage your external script files. When you're creating a Behaviour you can point to the file you created.

CAUTION: If you have a groovy script as opposed to a groovy class the method name should be `run`.

## Code completions for IDE users

If you're using an IDE you can get code completions by adding the following lines at the beginning of your script:

Add the following lines at the beginning of your script.

````
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseS```cript

@BaseScript FieldBehaviours fieldBehaviours
````

## Related content

-   [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor)
-   [Write Code](../../best-practices/write-code.md)
-   [Dynamic Forms](../../best-practices/dynamic-forms.md)
