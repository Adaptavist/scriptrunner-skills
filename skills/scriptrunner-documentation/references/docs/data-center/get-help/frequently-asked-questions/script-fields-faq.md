# Script Fields FAQ

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-442886757
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-fields-faq

### Will Guardrails affect my script fields?

Guardrails were [introduced in Jira 8.22.2](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html) to limit the impact that re-indexing would have on performance. Generally, this is a good thing for Jira and ScriptRunner.

Script fields shouldn't be affected by safeguards, and you may even see an improvement in performance. Script fields are indexed at the issue level, so the safeguards around comments, change logs, and work logs won't affect a script field's output.

Even if your script field reads from the issue's comments, work logs, or change logs, the information is accessed through the standard Atlassian Java API, which reads from the database not the indexes. For example, the following will load the whole list of comments from the issue, not just the top 500:

```
import com.atlassian.jira.component.ComponentAccessor

def commentManager = ComponentAccessor.commentManager
commentManager.getComments(issue)
```

As long as you follow the recommendations on the [Script Fields Tips](#) page, your script fields should work alongside Jira Guardrails.

### When I use `order by` in an Issue Picker scripted field, why are issues not sorted as expected?

Sorting is not an included functionality within an issue picker list. If `order by` was permitted in the JQL query it would conflict with the default ordering that Jira applies. This would make things like searching for issue keys difficult or impossible. Therefore, allowing manual ordering would make the search results for the field act inconsistently compared to other Jira fields.  

In addition, issues that a user has recently viewed, and that match the query, are taken into account when the issue picker field is empty. This is useful as many users will have recently viewed the issue they wish to select using the issue picker field. If the `order by` function is included with this field, it would conflict with the "recently viewed" ordering and negatively impact results. 

### Why does my picker field not show the correct values when I use context-specific logic to control the displayed options?

Closures are used to customize the configuration of ScriptRunner Database pickers, Custom pickers, and LDAP pickers. For example, see the list of custom picker closures [defined on our Custom Picker page](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker#definitions).

If you have a situation where your picker field displays options you are not expecting, it is likely due to how you configured these closures.

#### Caching of pickers for enhanced performance

The closures for Database pickers, Custom pickers, and LDAP pickers are cached and re-run when users view/interact with the field; we do this to speed up execution. This means that the script you define for your picker is not run in its entirety every time a user interacts with it. When you create a picker, the entire script is run once; we store the closures, and then if you change the configuration script, they are recompiled. Therefore, if you declare a variable that changes value based on context, only its initial value will be captured.

#### Our recommendation for effective picker functionality 

Any context-specific programming (such as looking up the logged-in user groups to filter search results for a picker) should be done inside the closures. Any variables you dynamically change outside the closures will only ever equal the value that they were first set to (when the script was first run after a user edited the pickers configuration script).
