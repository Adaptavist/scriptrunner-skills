# Script Manager Naming Rules

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-manager
- Doc ID: doc-sr4jc-480378911
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-manager/script-manager-naming-rules

When creating scripts and folders in Script Manager, you must follow specific naming rules to ensure your scripts function correctly. These rules are enforced by the frontend validation system. As you type the name, spaces are automatically replaced with underscores, and invalid characters are rejected. If a character is rejected, an explanatory notification appears in the top-right corner of your screen.

## Script names

Category

Rules

Examples

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Allowed

**Start with**: A letter only (a-z, A-Z)

**Use anywhere**: Letters, numbers, underscores, and hyphens

**Maximum length**: 248 characters (the `.groovy` extension is added automatically, making the total 255 characters).

-   `test`
-   `myScript`
-   `script_123`
-   `MyClass`
-   `test-file`
-   `test1`
-   `myScript2File`
-   `VeryLongFileNameThatIsStillValidAsLongAsItDoesNot   Exceed248CharactersIncludingTheGroovyExtensionWhich   IsAddedAutomatically`

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) Not allowed

-   Dots anywhere in the name (e.g., `test.script`)
-   Names starting with a: 
    
    -   number (e.g., `123test`)
    -   underscore (e.g., `_test`)
    -   dollar sign (e.g., `$test`)
    -   dot (e.g., `.hidden`)
-   Dollar signs anywhere in the name (e.g., `test$script`)
-   Spaces anywhere in the name (e.g., `test script`)
-   Special characters like `!`, `@`, `#`, `%`, `&`, `*`, etc.
-   Slashes in file names (e.g., `folder/file`)
-   Names longer than 248 characters
-   Empty names

-   `123test` - Cannot start with a number
-   `_test` - Cannot start with an underscore
-   `.hidden` - Cannot start with a dot
-   `$test` - Cannot start with a dollar sign
-   `test.script` - Cannot contain dots
-   `test$script` - Cannot contain dollar signs
-   `test script` - Cannot contain spaces (
-   `test!` - Contains invalid character (!)
-   `test/file` - Cannot contain slashes
-   `test@script` - Contains invalid character (@)
-   Empty string - Cannot be empty

## Folder names

Category

Rules

Examples

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Allowed

**Start with**: A letter only (a-z, A-Z)

**Use anywhere**: Letters, numbers, underscores, and forward slashes (for nested folders)

**Maximum folder name length**: 255 characters. Each folder in a path cannot exceed 255 characters.

**Maximum path length**: 600 characters (includes all parent folder names + folder name), as long as each stays within the individual folder name limit.

-   `test`
-   `myFolder`
-   `folder_123`
-   `MyFolder`
-   `folder1test_ok`
-   `FolderOne/FolderTwo`
-   `FolderOne/AAAA/CCC`
-   `folderOne/subfolder`
-   `main/sub/directory`
-   `scripts/utils/helpers`

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) Not allowed

-   Dots anywhere in the name (e.g., `folder.test`)
-   Dashes (e.g. `test-folder)`
-   Names starting with a: 
    
    -   number (e.g., `123test`)
    -   underscore (e.g., `_folder`)
    -   dollar sign (e.g., `$folder`)
    -   dot (e.g., `.hidden`)
-   Dollar signs anywhere in the name (e.g., `folder$test`)
-   Spaces anywhere in the name (e.g., `test folder`)
-   Special characters like `!`, `@`, `#`, `%`, `&`, `*`, etc.
-   Double slashes (e.g., `folder//sub` - use `folder/sub` instead)
-   Starting with a slash (e.g., `/folder`)
-   Ending with a slash (e.g., `folder/`)
-   Paths longer than 600 characters (including all parent folders)
-   Empty names

-   `123test` - Cannot start with a number
-   `_folder` - Cannot start with an underscore
-   `$folder` - Cannot start with a dollar sign
-   `.hidden` - Cannot start with a dot
-   `test folder` - Cannot contain spaces
-   `folder.test` - Cannot contain dots
-   `folder$test` - Cannot contain dollar signs
-   `test!` - Contains invalid character (!)
-   `/folder` - Cannot start with a slash
-   `folder/` - Cannot end with a slash
-   `folder//sub` - Cannot have double slashes (use `folder/sub` instead)
-   Empty string - Cannot be empty
-   `test-folder` - Cannot have a dash

## Total path length validation

The total path length (including all parent folders and the script folder name) must not exceed 600 characters. This applies to both script files and folders.

### Example

If you have a folder path: `very/long/path/structure/that/goes/deep/into/the/hierarchy`

And you try to create a script file: `anotherVeryLongFileNameThatWouldMakeTheTotalPathExceed600Characters.groovy`

The validation will fail if the combined length exceeds 600 characters.

## Auto-fixing behavior

Script Manager automatically fixes some common issues as you type:

-   **Spaces:** Automatically replaced with underscores (`_`).
-   **Invalid starting characters:** Automatically removed (e.g., typing `123test` becomes `test`).
-   **Invalid characters:** Automatically removed (e.g., typing `test@script` becomes `testscript`).
-   **Slashes in file names:** Automatically removed.
-   **File names exceeding 248 characters:** Automatically truncated.

When these auto-fixes occur, you'll see confirmation messages.

## Duplicate name detection

Script Manager prevents you from creating scripts or folders with the same name in the same location. The comparison is case-insensitive, so `MyScript` and `myscript` are considered duplicates.

## Best practices

-   **Use descriptive names**: Choose names that clearly indicate the script's purpose.
-   **Use camelCase or kebab-case**: `myScript` or `my-script` are both valid.
-   **Avoid special characters**: Stick to letters, numbers, underscores, and hyphens.
-   **Keep names concise**: While you can use up to 248 characters, shorter names are easier to work with.
-   **Organize with folders**: Use nested folders to organize related scripts (e.g., `utils/helpers`, `workflows/validators`).

## Technical notes

-   File names automatically get the `.groovy` or `.jel` extension appended.
-   Folder structures should be reflected in the package definition of scripts and classes.
-   Validation happens in real-time as you type.
-   The validation rules are enforced on the frontend before saving to the backend.
-   These rules ensure compatibility with Groovy and Jira Expression file system conventions.
