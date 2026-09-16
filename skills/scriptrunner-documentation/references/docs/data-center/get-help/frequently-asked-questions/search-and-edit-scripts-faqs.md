# Search and Edit Scripts FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: Get Help > Frequently Asked Questions
- Doc ID: doc-sr4js-f1eb6aa7-16ab-46e8-a93a-45aa050944c4-f4c1702fd1ed6bcf
- Source: https://docs.adaptavist.com/sr4js/latest/get-help#frequently-asked-questions--en#search-and-edit-scripts-faqs--en

## Is there a way for me to see all my scripts for any given feature in ScriptRunner and search those scripts for specific content?

ScriptRunner provides the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) built-in script; this allows you to see all scripts for each feature in tab format. After running this built-in script you can switch to the feature tab you want to review scripts for, then use the standard browser search tools `ctrl + f` (windows) or `cmd + f` (Mac) to find specific content.

Unfortunately, we do not provide a feature that lets you search over all ScriptRunner scripts at once. If you need to frequently search all your scripts, we suggest you change from using inline scripts to using script files instead. Using script files, you can use the operating systems file search tools, or an IDE, to search all your scripts easily. If you use script files, you can also take advantage of [version control](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/version-control), so you have better management of changes to your scripts.

## Is there a way to bulk edit all or some inline scripts?

ScriptRunner does not provide a method for you to bulk edit all inline scripts. If you are looking to have some form of bulk refactor feature with your ScriptRunner scripts, we suggest you switch to using script files instead of inline scripts wherever possible.

With script files, you can use operating system tools like the _Linux sed_ tool, or open all your scripts in an IDE environment and then run a search/replace using the IDE's tools. When using files, you can also take advantage of [version control](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/version-control) allowing you to revert your changes if your bulk edits cause your scripts to break.
