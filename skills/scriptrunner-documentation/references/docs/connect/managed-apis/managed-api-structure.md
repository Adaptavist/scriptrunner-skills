# Managed API Structure

- Platform: connect
- Space: SRC
- Hierarchy: managed-apis
- Doc ID: doc-src-194675653
- Source: https://docs.adaptavist.com/src/latest/managed-apis/managed-api-structure

## Grouping

When you import an API connection, you'll get an entry point to a Managed API for the given service. At a minimum, you can expect to find the fetch function as demonstrated in the second example. Most of the time, in addition to the fetch function, we'll offer other functions to increase the developer experience, as demonstrated in the third example as the highest-level abstraction.

Managed APIs are structured into logical hierarchical groups (groups containing other groups), and groups can also contain functions you can call. If you're unfamiliar with the service and its logical structure, there's an _All_ group where all functions are housed. Enter this group and start typing to narrow down the list.

In this example, we can see how the word "issue" reveals all available functions that include the word "issue":

![Code editor showing JavaScript with comments, async function fetching a Jira issue. Autocomplete list offers methods, highlighting ](/src/files/latest/194675653/194675652/1/1695217401000/Screenshot+2022-08-09+at+18.19.08.png)

It makes no difference in how you access functions, whether you'll drill down into logical groups or access the functions from the All group. The primary purpose of the grouping is to increase discoverability.

## Parameters

All Managed API functions that facilitate calling third-party APIs always accept a single parameter for _options_.

Parameters are handled in two parts. If the parameter is originally part of the URL path or query parameters, then parameters will be directly assignable in the root level of the options. However, if parameters are part of the body, they must enter the **body** field.

Sometimes, official (vendor-level) documentation simply refers to "parameters" without explicitly stating which type of parameters they are. If you cannot find the parameters you are looking for in the root level, check the **body** field.

Here is an example of how parameters can be assigned:

```
await JiraCloud.Issue.updateIssue({
    issueIdOrKey: 'ISSUE-1', // Parameter that is part of the URL path
    body: {
        ... /// Parameters that need to be passed inside body
    }
});
```

Sometimes the options parameter is optional if all the fields inside the options object are also optional.
