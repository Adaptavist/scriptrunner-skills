# Runtime

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-194676514
- Source: https://docs.adaptavist.com/src/latest/scripting/runtime

ScriptRunner Connect runtime is a custom JavaScript runtime based on Google's [V8](https://v8.dev/) engine, which offers strong security guarantees for isolating script executions. Because we have our own runtime, it's incompatible with other runtimes, such as [Node](https://nodejs.org/en/) or [Deno](https://deno.land/). However, we are embracing implementing standardized APIs whenever possible and generally aim to be compatible with other runtimes of a similar nature. We welcome and aim to be compatible with the [WinterCG](https://wintercg.org/) initiative.

## How does that affect you?

When you want to include an [NPM](https://www.npmjs.com/) package in your workspace, it may not be (fully) compatible with our runtime if it's built exclusively for Node or uses browser-based APIs which we don't support. This does not mean that you can't use any NPM package. There are many packages out there that solve the same problem; you just have to try a different one that may be written to utilize (more modern) standardized APIs. For example, an NPM package that uses [Node's crypto](https://nodejs.org/api/crypto.html) module under the hood wouldn't work because we don't support that API. However, if you find a different package that does the same job and uses [Web Crypto API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Crypto_API), which is standardized, it's more than likely to work (although our Web Crypto support is currently partial).

We'll be curating a list of verified (to work in our runtime) third-party NPM packages, which you can easily pick from, but you can try out any NPM package you desire. 

## Enhanced isolation mode

This feature is available only for paid users.

Although [V8](https://v8.dev/) is very robust in ensuring isolation, no software is immune to bugs and zero-day vulnerabilities. By default, a new V8 isolate is created and destroyed per request and is executed in a shared pool of [AWS Lambdas](https://aws.amazon.com/pm/lambda). However, a theoretical vulnerability still exists where a [sandbox](https://en.wikipedia.org/wiki/Sandbox_\(computer_security\)) escape is possible from the V8 isolate, which could lead to an AWS Lambda runtime instance being unintentionally altered. As an extra layer of security, you can enable enhanced isolation mode at the workspace level (go to **edit workspace** to _enable_ it) that will cause scripts from enabled workspaces to run in a [tenant isolation mode in Lambda](https://docs.aws.amazon.com/lambda/latest/dg/tenant-isolation.html), which means that the code running in enhanced isolation mode runs in a pool of Lambdas that are only allocated for a given [team](https://docs.adaptavist.com/src/latest/collaborate-with-teams). Should a sandbox escape event occur, the malicious actor won't be able to reach other AWS Lambda instances running in tenant isolation mode.

### Caveat

AWS Lambda functions experience a phenomenon known as [cold starts](https://aws.amazon.com/blogs/compute/understanding-and-remediating-cold-starts-an-aws-lambda-perspective/). This means that whenever a new Lambda instance needs to be created to process a new request, it must go through the initialisation phase, which incurs additional latency. In the ScriptRunner Connect runtime, this latency is typically 2-3 seconds. By default, this is almost unnoticeable because we collectively process a large volume of scripts, and the likelihood of consistently hitting a cold Lambda is quite low. However, when you enable enhanced isolation mode, you'll start running your scripts in an isolated pool of Lambda instances dedicated to your team, which most likely will lead to an increased occurrence of cold-starts, unless your scripts are being processed in a very uniform manner (constant and frequent load with very few spikes). For most workloads, the extra 1-2 seconds of delay should not be a concern. Still, in a few cases, such as processing Sync HTTP event listeners, where response times are time-critical, you may want to trade off extra security for performance by turning off enhanced isolation mode (which is less likely to cause cold starts).

## Supported APIs

By default, V8 has a core standard library for JavaScript (ECMAScript 2020).

On top of the core standard library, we have added support for the following APIs:

-   console
    
    -   [log](https://developer.mozilla.org/en-US/docs/Web/API/Console/log "https://developer.mozilla.org/en-US/docs/Web/API/Console/log")
        
    -   [trace](https://developer.mozilla.org/en-US/docs/Web/API/Console/trace "https://developer.mozilla.org/en-US/docs/Web/API/Console/trace")
        
    -   [debug](https://developer.mozilla.org/en-US/docs/Web/API/Console/debug "https://developer.mozilla.org/en-US/docs/Web/API/Console/debug")
        
    -   [info](https://developer.mozilla.org/en-US/docs/Web/API/Console/info "https://developer.mozilla.org/en-US/docs/Web/API/Console/info")
        
    -   [warn](https://developer.mozilla.org/en-US/docs/Web/API/Console/warn "https://developer.mozilla.org/en-US/docs/Web/API/Console/warn")
        
    -   [error](https://developer.mozilla.org/en-US/docs/Web/API/Console/error "https://developer.mozilla.org/en-US/docs/Web/API/Console/error")
        
    -   [assert](https://developer.mozilla.org/en-US/docs/Web/API/console/assert "https://developer.mozilla.org/en-US/docs/Web/API/console/assert")
        
    -   [count](https://developer.mozilla.org/en-US/docs/Web/API/Console/count "https://developer.mozilla.org/en-US/docs/Web/API/Console/count")
        
    -   [countReset](https://developer.mozilla.org/en-US/docs/Web/API/Console/countReset "https://developer.mozilla.org/en-US/docs/Web/API/Console/countReset")
        
    -   [time](https://developer.mozilla.org/en-US/docs/Web/API/Console/time "https://developer.mozilla.org/en-US/docs/Web/API/Console/time")
        
    -   [timeLog](https://developer.mozilla.org/en-US/docs/Web/API/Console/timeLog "https://developer.mozilla.org/en-US/docs/Web/API/Console/timeLog")
        
    -   [timeEnd](https://developer.mozilla.org/en-US/docs/Web/API/Console/timeEnd "https://developer.mozilla.org/en-US/docs/Web/API/Console/timeEnd")
        
    -   [group](https://developer.mozilla.org/en-US/docs/Web/API/Console/group "https://developer.mozilla.org/en-US/docs/Web/API/Console/group")
        
    -   [groupCollapsed](https://developer.mozilla.org/en-US/docs/Web/API/Console/groupCollapsed "https://developer.mozilla.org/en-US/docs/Web/API/Console/groupCollapsed")
        
    -   [groupEnd](https://developer.mozilla.org/en-US/docs/Web/API/Console/groupEnd "https://developer.mozilla.org/en-US/docs/Web/API/Console/groupEnd")
        
-   performance
    
    -   [now](https://developer.mozilla.org/en-US/docs/Web/API/Performance/now "https://developer.mozilla.org/en-US/docs/Web/API/Performance/now")
        
-   crypto (can also be accessed as window.crypto)
    
    -   [gerRandomValues](https://developer.mozilla.org/en-US/docs/Web/API/Crypto/getRandomValues "https://developer.mozilla.org/en-US/docs/Web/API/Crypto/getRandomValues")
        
-   crypto.subtle (can also be accessed as window.crypto.subtle)
    
    -   [generateKey](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/generateKey "https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/generateKey")
        
    -   [exportKey](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/exportKey "https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/exportKey")
        
    -   [importKey](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/importKey "https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/importKey")
        
    -   [sign](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/sign "https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/sign")
        
    -   [verify](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/verify "https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/verify")
        
-   [fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API "https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API") (partial implementation, but all the essentials are implemented)
    
-   [btoa](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa "https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa")
    
-   [atob](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/atob "https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/atob")
    
-   [setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout "https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout")
    
-   [clearTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout "https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/clearTimeout")
    
-   [Headers](https://developer.mozilla.org/en-US/docs/Web/API/Headers "https://developer.mozilla.org/en-US/docs/Web/API/Headers")
    
-   [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob "https://developer.mozilla.org/en-US/docs/Web/API/Blob")
    
-   [FormData](https://developer.mozilla.org/en-US/docs/Web/API/FormData "https://developer.mozilla.org/en-US/docs/Web/API/FormData")
    
-   [URL](https://developer.mozilla.org/en-US/docs/Web/API/URL "https://developer.mozilla.org/en-US/docs/Web/API/URL")
    
-   [URLSearchParams](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams "https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams")
    
-   [TextEncoder](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder "https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder")
    
-   [TextDecoder](https://developer.mozilla.org/en-US/docs/Web/API/TextDecoder "https://developer.mozilla.org/en-US/docs/Web/API/TextDecoder")
    

If you're interested in TS types for our runtime, [you can find them here](https://unpkg.com/browse/@stitch-it/runtime@latest/index.d.ts).

## Known limitations

Unhandled promise rejections are not captured and logged for floating promises. We recommend taking caution not to fire off a `promise` without `awaiting` completion, or adding a `catch` method to capture any possible errors.

## Versions

Runtime version allows you to control which version of the runtime your scripts are running on the workspace level. You can change the version by navigating to the _Workspace Edit_ setting and selecting the **Runtime version**. Currently, the default version for all existing workspaces is V1, while new workspaces will be configured to use V2. 

Runtime version selection is only available during the transitional periods when the ScriptRunner Connect team is releasing a new runtime version. Historically, we have performed runtime upgrades in the background, but since upgrading the underlying Node and V8, versions can introduce changes in how memory is used, so we have now opted to use staged releases. For a short period, both versions will remain available, allowing you to switch to the new version while the old version remains as a rollback option. 

 We advise switching to the new version (and reporting any issues) as soon as it becomes available, while retaining the option to revert to the old version for the time being. 

Switch to V2

On 1 April 2026, all existing workspaces will be switched to V2, and V1 will become decommissioned.

### Changelog

#### V2

-   Internal implementations of [TextEncoder](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder) and [TextDecoder](https://developer.mozilla.org/en-US/docs/Web/API/TextDecoder) APIs are upgraded. These APIs are used internally by [Managed API](https://docs.adaptavist.com/src/latest/managed-apis)'s HTTP response `text` and JSON methods, thereby affecting many scripts. The new implementation should use significantly less memory, allowing it to decode larger HTTP responses without running out of memory as quickly.
-   Introducing the `fastTransfer` option for some APIs that work with [ArrayBuffers](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer). By default, when you pass an `ArrayBuffer` as a parameter to an API, the contents of the `ArrayBuffer` will be copied. When you're performing a lot of these operations, and `ArrayBuffers` tend to be larger in size, you're spending CPU time just on copying the content over. To speed up such operations, you can now optionally enable `fastTransfer` mode, which, instead of copying the content, will pass along the reference of the ArrayBuffer instead, which is a constant-time operation. As a consequence of passing the reference, the `ArrayBuffer` reference in your script becomes invalidated (de-referenced), meaning that you no longer can access the content or edit your `ArrayBuffer,` henceforward, which in most cases you wouldn't need anyway. Trying to read from an invalidated `ArrayBuffer` or edit it will either return an empty byte array or throw an error. If you need to continue reading or editing the contents of the `ArrayBuffer` after you have passed its reference into an API, simply do not enable this mode. The following APIs have this option available:
    -   `` `TextDecoder`'s decode `` method accepts the `fastTransfer` option  
        
    -   `@sr-connect/convert`'s `convertBufferToText` and `convertBufferToBase64` functions accept `fastTransfer` option.
