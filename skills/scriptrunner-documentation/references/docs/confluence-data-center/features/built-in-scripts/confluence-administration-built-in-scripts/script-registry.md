# Script Registry

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-5030ab75-dbb4-479a-a72e-3a1a293aae37-8fba1f07d4a38c63
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#script-registry--en

Use the _Script Registry_ to search your ScriptRunner custom scripts, and view any type checking errors or deprecation warnings.

CAUTION: Type checking errors do not mean your code will not run. Since we compile it statically and Groovy is a dynamic language, there may be false errors.

_Script Registry_ lists scripts, their type, content, and location. Each script undergoes [Static Type Checking](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/static-type-checking) to ensure it is written correctly.

Tip: It is recommended that _Script Registry_ is used on staging instances after upgrading Confluence to validate that all necessary APIs are available.

## Using this built-in script

1.  From ScriptRunner, navigate to Built-in Scripts > Script Registry . Alternatively, you can select the Ellipses Menu > Script Registry
    
2.  Click Run to view all configured scripts. All Groovy scripts on the Confluence instance are listed.
3.  Scripts are sorted into category tabs, showing the number of scripts in each category. Click on a tab to display all scripts of that kind.
