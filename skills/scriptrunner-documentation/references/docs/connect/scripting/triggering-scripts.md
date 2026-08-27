# Triggering Scripts

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-194676491
- Source: https://docs.adaptavist.com/src/latest/scripting/triggering-scripts

# Triggering scripts manually

# Triggering scripts programatically

In addition to manually triggering scripts via the UI, you can programmatically trigger scripts from another script within the same workspace.

To programmatically trigger a script, you first have to import a `triggerScript` function from the `@sr-connect/trigger` package and call that function. The first argument to this function is the name of the script you want to trigger, and the second argument is `options`. The options object accepts `functionName` and `payload` properties, both of which are optional.

The function name is the name of the function within the script you want to invoke; if not specified, an exported default function will be looked for. Payload accepts a JS object, which then will be passed into the function you're triggering as an event.

Here is an example:

```
import { triggerScript } from "@sr-connect/trigger";

export default async function(event: any, context: Context): Promise<void> {
	await triggerScript('ScriptName', {
		functionName: 'functionName',
		payload: {
			hello: 'world'
		}
	});
}
```

## Use cases

### String short jobs together

A useful use case of this feature is allowing jobs to run longer than 15 minutes, which is the app's limit for a single function invocation run. (This limit is a common requirement for migration workloads.) You can structure your long-running job to do a job in batches by doing as much work as possible during a single script invocation, and when time is about to run out, the script can auto-trigger and restart itself, and then continue where the previous script invocation left off. (Take a look at the [Tempo Timesheets Cloud migration template](https://stitchit.app/template/01GHGY972VANE1R7CS8TY1B50C) to view how this functionality is applied to run a migration workload that needs to run longer than 15 minutes.)

### **Run parallel tasks**

If you can't run the workload within the same script, consider spawning parallel tasks. However, it's worth keeping in mind that you can use [Promise.all](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all) to run async tasks concurrently, but if you need to run synchronous (CPU-bound) tasks in parallel, then the only option is to spawn parallel tasks, which this feature is perfectly suited for.

**Key facts to keep in mind**

-   The functions you plan to trigger must be [exported](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export).
-   To prevent infinite loops, refrain from triggering chained scripts (scripts that are triggered programmatically) more than 200 times.
-   While you can manually trigger saved or unsaved root scripts from the UI, programmatically invoked chained scripts always trigger from saved versions.

## Rate limits

This API call is [rate-limited](https://docs.adaptavist.com/src/latest/limits-and-quotas), meaning that if you exceed the allowed quota, the API call will get blocked, and status code 429 will be returned instead. By default `@sr-connect/trigger` package automatically retries rate-limited calls, which you can disable. By default, a warning message is emitted when the API call gets rate-limited, but you can disable this setting, too.

Here is an example of how you can disable automatic retry logic and warning messages while manually catching 429 errors:

```
import { triggerScript } from "@sr-connect/trigger";

export default async function (event: any, context: Context): Promise<void> {
	try {
		await triggerScript('Script', {
			retryOn429: {
				enabled: false, // Disable automatic retry
				verbose: false // Disable warning messages on automatic retries
			}
		});
	} catch (e) {
		if (e instanceof ServiceError && e.errorCode === 429) {
			// Do something when API call was rate limited
		}
	}
}
```
