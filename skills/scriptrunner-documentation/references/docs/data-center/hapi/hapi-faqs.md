# HAPI FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888197
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/hapi-faqs

This page details frequently asked questions about [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi). 

## FAQs

### **How do I get HAPI?**

You can access HAPI from version 7.11.0 onwards of ScriptRunner for Jira Server/Data Center.

### **Do I need to rewrite existing scripts?**

No. You can keep existing scripts as they are. However, if you wish to make your current scripts shorter and more manageable, you may want to update them using HAPI.

Check out our video on [how to use HAPI with existing scripts](https://www.youtube.com/watch?v=NHESFvp0EeI). 

### **Can HAPI features be combined along with old methods/scripts?**

Yes. HAPI is Groovy so you can combine HAPI with regular Groovy methods and scripts.

### **What's the performance of HAPI when you have to deal with projects with 1000s of issues?**

HAPI has been developed with the performance needs of large instances in mind.

When dealing with larger datasets there will be an increase in execution time, e.g a JQL search over millions of issues. However HAPI should not cause out-of-memory issues, even with large datasets.

### **How can I force completions to give me suggestions?**

You can use the keyboard shortcut **Control + Space**. This shortcut allows you to display completions when they disappear. 

### How do I keep up to date with changes to HAPI?

You can keep up to date with changes on the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog) page. 

### What does the H stand for in HAPI?

Well, it can be many things. Here are some of our favorites:  Happy/Hero/ Helpful/Handy/Hardworking/Harmonious/Heavy lifting.

### Is HAPI interoperable with Jira API? 

Yes. You can mix and match HAPI calls with Jira API.

### How do permissions work with HAPI?

HAPI **respects the permissions** of the current user _by default_ but provides the option to both override those permissions or execute as an arbitrary user. If you are permitted to do something in Jira, you have the same permissions with HAPI.

### How do I stop notifications from being sent when I bulk update issues?

We described how to [avoid notification and event dispatches](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues#avoid-notification) in our documentation.

## Have any feedback? 

![Icon image of pen on paper](/sr4js/files/latest/442888197/442888198/1/1758746917000/sr-icon-documentation.png)

Take our short survey and let us know what you think about HAPI!

[Take survey](https://www.surveymonkey.com/r/YXPMPKT)

  

* * *

## Related content

-   [HAPI Examples](https://docs.adaptavist.com/sr4js/latest/hapi/hapi-examples)
-   [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog)
-   [Simplify Current Scripts with HAPI](https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi)
