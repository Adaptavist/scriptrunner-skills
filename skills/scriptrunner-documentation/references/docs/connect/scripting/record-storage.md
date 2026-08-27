# Record Storage

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-194676468
- Source: https://docs.adaptavist.com/src/latest/scripting/record-storage

Record storage is key-value storage that allows you to store arbitrary data as key-value pairs.

**Data overwrite**

At this time, record storage does not support atomic operations, meaning that two parallel invocations that write to record storage using the same key will overwrite the data.

## Scopes

Scopes are a means to limit the scope/accessibility of the record without having to manually concatenate record keys with extra values to achieve the same result. A good example is an `environment` scope. If you want to store a value that would only be accessible within the environment that the script is executed for, you would have to concatenate `environmentId` into the record key, which you can grab from the `context`. ScriptRunner Connect offers many scopes out-of-the-box, so you don't have to resort to manual record key concatenation for common use cases; however, you can still do it if you would like to use scoping behaviors that are not supported out-of-the-box.

### Available scopes in ScriptRunner Connect

-   **`team`** \- Records are accessible through the team, additionally `teamScope` option can be used to further limit the scope. By default no `teamScope` is used, so be careful not to overwrite values,
    
    It is highly recommended to use the `teamScope` option to reduce the chance of accidental overwrites.
    
    This scope can be handy if you are implementing OAuth 2.0 connectors manually in a workspace and would like to share refreshed access keys with other workspaces.
-   **`workspace`** - Records are accessible throughout the workspace, from any environment, and from any invocation.
-   **`environment`** (default) - Records are accessible only from the environment where the code was invoked.
-   **`invocation`** - Records are accessible only during the invocation. Invocation-scoped records will be automatically deleted because you can only access the invocation-scoped record during the invocation, which is short-lived (15 minutes max).

## Options

When you create a record-storage instance, you can set options globally. You can also specify options individually at the function level, which overwrites global (instance-level) options.

### Available options in ScriptRunner Connect

-   **`scope`** - Specifies the scope (available options are `team`, `workspace`, `environment` (default), and `invocation)`.
-   **teamScope** - Specifies an additional scope as a random string that will be used to limit accessibility. It can only be specified if the team scope is used.
-   **retryOn429 -** Options for automatic retry logic should the API request get rate limited, enabled by default.
-   **`ttl`** - Stands for "Time To Live" and allows you to specify how long (in seconds) the record will be accessible. After expiration, the record will be deleted, though the deletion may not occur immediately. This option is useful if you don't need to keep records around forever. Default: `undefined` (items are stored indefinitely).
-   **`denyUpdateOverwrite`** - By default, any update would overwrite the previous value. To disable this behavior and allow the update operation to fail if the record already exists, set this option to `true`. Default: `false`.
-   **`secure`** - Use the `secure` option to store sensitive information. The secure option adds an additional layer of encryption to the default encryption AWS provided encryption at rest. Default: false.
    
    The `secure` option introduces an additional encryption layer, so it's slower than non-secure reads and writes. Use the `secure` option only if necessary.
    

## Operations

### Construct record storage

To get started with Record storage, create an instance of Record storage as follows:

```
import { RecordStorage } from '@sr-connect/record-storage';

export default async function(event: any, context: Context): Promise<void> {
	const storage = new RecordStorage({ /** global options */});
}
```

Once the instance is created, you can access methods from it:

![Code editor showing JavaScript snippet with an autocomplete suggestion list for storage methods like \`deleteValue\` and tooltips explaining each method.](/src/files/latest/194676468/194676466/1/1695221637000/Screenshot+2022-09-27+at+14.41.55.png)

The last argument for each function is the optional options object. If options are specified at the function level, they will overwrite any options specified at the global instance level.

If you don't like the instance access pattern, you can call functions directly by importing them:

```
import { setRecordValue, getRecordValue, getKeysOfAllRecords, deleteRecordValue, recordValueExists } from '@sr-connect/record-storage';
```

Since you cannot set default global (instance-level) options when using functions directly, you must explicitly specify options (if needed) on each function call as the last optional argument.

### setValue

The `setValue` method inserts or updates a record. If a record already exists, the value will be overwritten unless the `denyUpdateOverwrite` option is enabled.

ScriptRunner Connect automatically serializes record values, so you can be confident that they're the same when you store data and read back the values. This means you don't have to explicitly serialize values to JSON and back, but you can do it if required. Allowed record value types are `any JS object`, `string`, `number`, `boolean`, `Symbol`, `BigInt` or `any array`. Storing `undefined` or `null` is not allowed.

You also have the option to specify the type for the `getValue` method call to automatically have the returned values cast to the expected type.

### getValue

The `getValue` method retrieves a stored value. If the value does not exist, then `undefined` is returned.

In the following example, a value with a specific type is written into the Record storage and then read back by specifying the same type when reading the value back:

```
import { RecordStorage } from '@sr-connect/record-storage';

export default async function(event: any, context: Context): Promise<void> {
	const storage = new RecordStorage({ /** options */});

	const valueToStore: TestRecord = {
		hello: 'world'
	}

	// Store the value
	await storage.setValue('MY_KEY', valueToStore);

	// Read back the value, and specify the TestRecord type
	const value = await storage.getValue<TestRecord>('MY_KEY');
}

interface TestRecord {
	hello: string;
}
```

In this case you can take advantage of TypeScript's type system:

![Code snippet showing TypeScript function for storing and retrieving a value with \`RecordStorage\`, including comments and console log output.](/src/files/latest/194676468/194676467/1/1695221637000/Screenshot+2022-09-27+at+14.58.28.png)

### valueExists

The `valueExists` method checks if a given value exists and returns either `true` or `false`. Using the `getValue` method returns the entire body, so use the `valueExists` function if you just need to check if a record with a given key already exists.

For example:

```
import { RecordStorage } from '@sr-connect/record-storage';

export default async function(event: any, context: Context): Promise<void> {
	const storage = new RecordStorage({ /** options */});

	const valueExists = await storage.valueExists('MY_KEY');

	if (valueExists) {
		// Do something if the record exists
	} else {
		// Do something if the record does not exist
	}
}
```

### deleteValue

The `deleteValue` method deletes the record.

**Deletion idempotency**

The delete operation is idempotent, meaning that if you try to delete an item that does not exist, the delete operation will still succeed.

For example:

```
import { RecordStorage } from '@sr-connect/record-storage';

export default async function(event: any, context: Context): Promise<void> {
	const storage = new RecordStorage({ /** options */});

	await storage.deleteValue('MY_KEY');
}
```

### getAllKeys

Use the `getAllKeys` method to retrieve all keys:

```
{
  keys: string[]; // List of all keys
  lastEvaluatedKey?: string; // Last evaluated key if there are more keys available that couldn't fit into the current response
}
```

**Pagination**

Responses from this function can be paginated. If `lastEvaluatedKey` is present, it means that there may be more keys available that didn’t fit into this response. To view the additional keys, repeat the operation by taking the `lastEvaluatedKey` value from the response and passing it as an option to a new request. Repeat this process until `lastEvaluatedKey` is `undefined`.

Example of implementation of pagination traversal:

```
import { RecordStorage } from '@sr-connect/record-storage';

export default async function(event: any, context: Context): Promise<void> {
	const storage = new RecordStorage({ /** options */});

    const keys: string[] = [];
    let lastEvaluatedKey: string | undefined;

    while (true) {
        const response = await storage.getAllKeys({ lastEvaluatedKey });
        keys.push(...response.keys); // Push existing keys to keys list

        if (response.lastEvaluatedKey) {
            lastEvaluatedKey = response.lastEvaluatedKey; // If 'lastEvaluatedKey' is present then store it and repeate the operation
        } else {
            break; // If not then break the loop
        }
    }

	// Log out all the collected keys
    console.log(keys);
}
```

## Rate limits

These API calls are rate-limited, meaning that if you exceed the allowed quota, the API call will get blocked and a status code 429 will be returned instead. By default, the `@sr-connect/record-storage` package automatically retries rate-limited API calls, which you can disable. By default, a warning message is emitted when the API call gets rate-limited, but you can disable this setting, too.

Here is an example of how you can disable automatic retry logic and warning messages while manually catching 429 errors:

```
import { RecordStorage } from "@sr-connect/record-storage-test";

export default async function (event: any, context: Context): Promise<void> {
	// Create new Record Storage instance and overwrite default automatic retry options
	const storage = new RecordStorage({
		retryOn429: {
			enabled: false, // Disable automatic retry
			verbose: false // Disable warning messages on automatic retries
		}
	});

	try {
		// You can also specify `retryOn429` options individually on a function level which will overwrite global (instance level) settings
		const value = await storage.getValue('KEY');
	} catch (e) {
		if (e instanceof ServiceError && e.errorCode === 429) {
			// Do something when API call was rate limited
		}
	}}
```
