# Script Fragments FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-101626143
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-fragments-faqs

### How do I find the variables available in the context of where I create my Script Fragments?

Navigate to _Script Fragments_ within ScriptRunner. There is an **enable/disable** button for the web location finder. Enable this and go to the location where you chose to display your fragment, hover your mouse over the text description inside the desired location, a tooltip shows the context variables for that location.

You can also log out the binding variables for a script fragment which will output to the `atlassian-jira.log` file using this line:

```
log.error('binding variables: ' + binding.variables)`
```
