# Package Manager

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-194675356
- Source: https://docs.adaptavist.com/src/latest/workspaces/package-manager

ScriptRunner Connect workspaces consist of several JavaScript packages hosted on [NPM](https://www.npmjs.com/) that make it tick. Most of the time, you don't have to concern yourself with how packages are managed because ScriptRunner Connect manages them for you, but there are a few more advanced use cases where you may want to take manual control over how packages are managed for you. You can do so by entering Package Manager and assuming manual control for packages with versions included in your workspace. You can also click on the package name to navigate to the NPM page, which contains additional information on how to use the package.

## Demo

## Categories

Packages are sorted into the following three categories:

-   Core packages
-   [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis)
-   Third-party packages

Some packages cannot be unselected. These are the packages that are pulled in automatically in response to how you have set up your workspace; however, you can change the version of these packages. Core packages and managed APIs default to `latest` version, which means that your workspace will always pull in the latest available version. We recommend keeping it that way, as we'll be making continuous improvements to event types and managed APIs. We want to ensure that your workspace receives the most up-to-date information regarding third-party services. The only time you should take manual control over these package versions is if we decide to release a major version that could introduce some breaking changes. While we will try to avoid such an outcome and will only do it as a last resort, in that situation, you will have the option to downgrade a package to an older version that your workspace was built to work with if you can't immediately upgrade.

When it comes to changes in event types in core packages and managed APIs that result in breaking changes due to modifications made by the third-party service vendor, downgrading won't work because our side introduced the breaking change in response to an external change over which we have no control. As a result, you will need to make manual updates in your workspace to accommodate the change.

Third-party packages won't default to the `latest` version label, but they will default to the latest concrete version at the time of inclusion. You need to upgrade the package manually by returning to Package Manager and selecting the newer version. ScriptRunner Connect doesn't default to `latest` as it does with core packages and managed APIs, because the app has no control over third-party packages and their release schedules, all of which have the potential to include breaking changes. Therefore, staying on a concrete version increases stability.

### Core packages

Core packages consist of system-level packages that are always included. For example, [@sr-connect/convert](https://www.npmjs.com/package/@sr-connect/convert) offers a few handy buffer-level conversion functions that are not natively available in the JavaScript standard library. Another example is product-specific libraries, which are usually automatically included based on the event listeners you have configured in your workspace.

It is unlikely that you ever have to take manual control over core-package versions, but you may decide to include a package that is not included automatically.

### Managed APIs

Managed APIs are automatically pulled in based on the API connections you have declared in your workspace. Most of the time, you don't have to resume manual control over managed APIs; however, there are cases when you might want to include a managed API that is not automatically included. The most likely scenario for this would be if you're using a generic API connection to connect to a service for which we have managed APIs available, but you are not using our bespoke connector to do so. For example, you may need to use an authentication scheme that ScriptRunner Connect's native connector doesn't support. In this example, you could pull in the managed API via the Package Manager that wasn't included, construct the managed API manually, and use it by combining it with the app's generic API connection.

### Third-Party packages

No third-party packages are included by default, but you can pull in any package from [NPM](https://www.npmjs.com/). 

For example, you may want to include [dayjs](https://www.npmjs.com/package/dayjs) to work with dates and times more conveniently than the standard library allows. Or maybe you want to add a [validator](https://www.npmjs.com/package/validator) that contains various utility functions for input validation; for example, instead of writing your own regular expression to ensure that an input is a valid email, you could use the `isEmail` function from the validator package instead.

#### Importing third-party packages

Use [ES(6) Modules](https://www.typescriptlang.org/docs/handbook/2/modules.html#es-module-syntax) syntax when importing packages into ScriptRunner Connect instead of CommonJS, which makes use of the `require` function.

Returning to the example of the [validator](https://www.npmjs.com/package/validator) package, the correct import statement would be:

```
import validator from 'validator';
```

Or, if you would like to import a single function from the validator:

```
import isEmail from 'validator/lib/isEmail';
```

#### Dealing with types

Today, most NPM packages either come with TypeScript types natively or have community-written types available from [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) project. However, some packages may have neither. The ScriptRunner Connect editor uses TypeScript types to power [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense), which is extremely useful; therefore, getting types sorted out is important.

##### Packages with native support

NPM packages with native support have a _TS_ logo next to the title on the NPM page ([dayjs](https://www.npmjs.com/package/dayjs), for example). Simply include the package, and ScriptRunner Connect automatically picks up the types.  
![The TS logo, highlighted next to an associated NPM package.](/src/files/latest/194675356/194675353/1/1695209034000/package-manager-ts-icon.png)

##### Packages with community support

Packages with community support have the _DT_ (DefinitelyTyped) logo next to the title on the NPM page. This means you should also include the DefinitelyTyped package alongside the main package you're trying to include.

![The DT logo, highlighted next to an associated NPM package.](/src/files/latest/194675356/194675354/1/1695209035000/package-manager-dt-icon.png)

The naming convention for DefinitelyTyped packages is `@types/MainPackageName`. For example, if you're including a [validator](https://www.npmjs.com/package/validator) with types in the DT package, you should also include [@types/validator](https://www.npmjs.com/package/@types/validator).

**Potential sync issues**

Be aware that DT types have the potential to become out of sync with the package that they aim to add types of support for. For example, a package author may decide to convert their package from DefinitelyTyped to TypeScript. In this case, case NPM should reflect the correct information, displaying the _TS_ icon instead of _DT_.

##### Packages without any support

If a package has no support, you can still attempt to use it, but you won't receive any IntelliSense support, and the editor and compiler will complain. However, you should be able to use it if you can use the package without any editor support.

#### Your mileage may vary

There are two reasons that some NPM packages can't be used with ScriptRunner Connect:

-   **Incompatibility with the ScriptRunner Connect runtime**  
    For example, if the package was exclusively built to work on [Node](https://nodejs.org/en/), it most likely won't be compatible because we're not implementing Node APIs. ScriptRunner Connect runtime aims to implement standardized APIs—APIs that exist in browsers and in more modern server-side/cloud runtimes aiming to leverage the [WinterCG](https://wintercg.org/) initiative, which we also aim to achieve.
-   **Package structure issues**   
    We plan to resolve this issue. If you happen to have a package that should work but doesn't, please let us know so we can investigate further. Also, packages that fail due to lacking types or type-loading failures can still be used, but it takes a little more work to get them sorted out.

##### Verified packages

To make it easier to include third-party NPM packages, ScriptRunner Connect curates a list of verified packages that are confirmed to work well in ScriptRunner Connect. This list of verified packages will grow over time.

##### Unverified packages

If you can't find the package that solves your problem in the verified list, you can try adding any unverified NPM package; however, as mentioned, your mileage may vary. The easiest approach is to include the package and see if it works; if it doesn't, you can look for alternatives.

**Support options**

Package management can be quite a challenge, even for seasoned developers. [We welcome your feedback on the packages you would like to use](https://scriptrunnerconnect.nolt.io/top).

You can also log a [support ticket](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/20) with an explanation of the problem you're trying to solve, and we'll be happy to look for ScriptRunner Connect-friendly packages that help solve your business problem. (If you need help logging in, see [Log In to the TAG Support Portal](https://docs.adaptavist.com/log-in-to-the-tag-support-portal).)
