# Scripting

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194676293
- Source: https://docs.adaptavist.com/src/latest/scripting

ScriptRunner Connect scripting language is [JavaScript](https://www.javascript.com/)/[TypeScript](https://www.typescriptlang.org/), and our [online editor](https://docs.adaptavist.com/src/latest/scripting/editor) is based on Monaco, which also powers the extremely popular [VS Code](https://code.visualstudio.com/) product.

Our [runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) is based on a robust and secure [V8 engine](https://v8.dev/) that also powers Chromium-based browsers and most other (server-side and cloud-native) JavaScript runtimes. This combination with our [managed APIs](https://docs.adaptavist.com/src/latest/managed-apis) allows us to deliver industry-standard developer experience to increase productivity and familiarity while reducing the learning curve. We chose this combination because:

-   JavaScript + TypeScript is the [most popular combination](https://survey.stackoverflow.co/2022/#section-most-popular-technologies-programming-scripting-and-markup-languages) in [greenfield projects](https://en.wikipedia.org/wiki/Greenfield_project).  
    Chances are you already have been exposed to JavaScript. If not, it's easy to start, and many resources are available to help you learn it. Beyond ScriptRunner Connect, JavaScript is also used as a scripting language in many other projects; e.g., [Atlassian Forge](https://developer.atlassian.com/platform/forge/) uses JS/TS as the default language. JavaScript is also a default scripting language for [ServiceNow](https://developer.servicenow.com/dev.do#!/learn/courses/rome/app_store_learnv2_scripting_rome_scripting_in_servicenow). Beyond scripting capabilities of specific services, you can use JavaScript to build web apps; build server-side logic using [Node](https://nodejs.org/en/), [Deno](https://deno.land/), or [Bun](https://bun.sh/); build mobile apps using [React Native](https://reactnative.dev/) or [Ionic](https://ionicframework.com/); build desktop apps using [Electron](https://www.electronjs.org/); build [IoT stuff](https://blog.openreplay.com/top-5-iot-libraries-for-javascript-developers), etc. The possibilities with this language are so vast that it probably makes more sense to point out where you _can't_ take it, which is usually the domain of systems programming where low-level languages, such as C/C++ and Rust, still reign supreme. On top of that, [npm](https://www.npmjs.com/) is the world's largest software package registry.
-   Monaco editor, which powers VS Code, is also beloved and [very popular](https://survey.stackoverflow.co/2022/#section-most-popular-technologies-integrated-development-environment), making our editor instantly familiar to many.
-   V8 is an industry-standard technology for building JavaScript-based runtimes for performance and security.

![](/src/files/latest/194676293/345964980/1/1742840766000/8c7b1dc6-cb81-4a29-a8c1-b2bfdd6144ce.png)

  

Don’t have the time or capacity to write scripts in-house? Our on-demand scripting service can bolster your capability and help you launch customization and automation initiatives.  
[shortcut Scripting Service](https://www.adaptavist.com/solutions/development-services)

  

  

## Demo

## Scripting language options

ScriptRunner Connect allows the choice of three different language options that control various features on the editor level: JavaScript, TypeScript, and TypeScript Strict. The primary features controlled by these three options are [auto-complete suggestions](https://docs.adaptavist.com/src/scripting/editor#Editor-togglingautocomplete), [import suggestions](https://docs.adaptavist.com/src/scripting/editor#Editor-togglingimportsuggestions), syntax checking, and [strict mode](https://www.typescriptlang.org/tsconfig#strict).

### JavaScript

The JavaScript option only enables the auto-complete-suggestions feature on the editor level; every other feature will be disabled. This option is suitable for those who strongly like to write their code as they are used to writing JavaScript without any additional syntax checks performed by TypeScript. In this mode, you can still leverage TypeScript syntax in places you need, for example, specifying types in TypeScript to get support for auto-complete suggestions.

**Avoid bugs and silly errors  🐜**

Disabling TypeScript syntax checking can lead to bugs and typos at runtime that otherwise could have been caught during compilation. We strongly encourage you to use the syntax-checking aid. 

### TypeScript

In addition to auto-complete suggestions, the TypeScript option enables syntax checking and an import suggestion \[link to the same as above\] feature, which cannot be enabled without syntax checking. This is the default option for all new workspaces, except for ones created from templates, which default to TypeScript Strict mode.

Syntax checking adds compile time checks to your code to help you write less error-prone code. For example, if a typo was made and TypeScript knows about the type it's working with, a notification will be shown:

![Code snippet with an error message in a popup. The message suggests correcting ](/src/files/latest/194676293/194676290/1/1695218972000/Screenshot+2022-09-02+at+07.13.01.png)

Syntax checks are not always guaranteed; TypeScript can help if the type is specified or inferred. If the type is `any` (or equivalently very loose), defaults to `any`—or is inferred as `any`—then TypeScript has no idea what's inside and won't perform the syntax check for you, or it will potentially allow accessing any property, even if it knows what's inside if the type allows it. To make the most out of TypeScript's assistance, it's important to understand [how type-inferencing works](https://docs.adaptavist.com/src/scripting/editor#Editor-leverage-type-interface).

### TypeScript Strict

The TypeScript Strict option enables [strict](https://www.typescriptlang.org/tsconfig#strict) mode, which adds many additional features that force you to practice more defensive programming. The most beneficial feature of strict mode is that it forces users to start checking potentially missing properties when accessing object properties, which otherwise can blow up at the runtime if they were to be missing and you didn't explicitly check for them.

For example, the following code is valid in regular TypeScript mode but throws an error in TypeScript Strict mode because null checks are not performed and are deemed potentially unsafe:

![Code snippet with TypeScript error highlighting ](/src/files/latest/194676293/194676291/1/1695218972000/Screenshot+2022-09-02+at+07.25.48.png)

This problem could be easily solved by simply checking if the `assignee` property wasn't `null` or `undefined`. JavaScript has a handy feature called [optional chaining](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining) that can traverse potentially missing properties without blowing up:

![Code snippet in JavaScript defining an asynchronous function named ](/src/files/latest/194676293/194676292/1/1695218972000/Screenshot+2022-09-02+at+07.28.55.png)

**A recommendation 🏆**

We recommend switching to TypeScript Strict scripting mode to help you write less error-prone code. This is not a default option because it requires awareness of certain TypeScript features that might be too much for those trying out TypeScript for the first time.
