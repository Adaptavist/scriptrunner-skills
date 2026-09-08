# Write Code

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-101624793
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code

For a video on Groovy scripting, see our [Groove Basics](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-1-video-groovy-basics-for-scriptrunner-data-center-server) training video. 

ScriptRunner users work with the software in different ways. You may exclusively use the point-and-click pieces without writing a single line of code, or you may use the best development tools and practices to streamline your scripting experience. You may be somewhere between the two - maybe you can copy and paste code from the documentation, or maybe you write custom scripts and use developer tools like an IDE.

Use this page to determine what group of users you might categorize yourself with. Then, use your group to help you navigate the documentation.

## For Everyone

If you don’t have a test or QA instance of your application (Jira, Confluence, or BitBucket), consider obtaining one. They are the best way to test your scripts without fear of creating problems in your production Jira instance. You can get a [development license](https://www.atlassian.com/licensing/purchase-licensing#licensing-7) to setup a test server, where you can run a cloned instance of your Atlassian application’s configuration.

## For Explorers

If you regularly find yourself on Atlassian’s Community site asking, "I have ScriptRunner, how can I…​" questions, you’re an **Explorer**.

You primarily use ScriptRunner to gather information about your Atlassian application. For example, you may occasionally run a built-in script or copy and paste some code into the _Script Console_ to get information or make a bulk update that the UI just can’t accomplish. In ScriptRunner for Jira, you probably use JQL functions heavily. In Confluence, you probably use the built-in macros quite a bit, and you may have touched a _Search Extractor_ or a custom CQL function on occasion.

If you want to go further in writing your scripts, check out [our guide on the code editor](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor).

## For Builders

If you’re concerned about continuous integration, infrastructure as code, or automated testing, you’re a **Builder**.

You may have a job title like "Developer", "Software Engineer", or something with "DevOps" in it. You may even be a Jira or Confluence admin who reads blogs by and for people with the previously mentioned job titles, and you may have an interest in implementing those concepts. If you’re a Bitbucket Server or Bamboo admin _and_ user, you’re probably in this group because you’re using developer tools.

If you are a software developer, you probably have other concerns similar to:

-   How can I track changes to my scripts and their configuration in a source control tool like Git?
    
-   How can I write and run automated tests to make sure my scripts work as I expect across Atlassian product releases, server migrations, and ScriptRunner updates?
    
-   How can I build and deploy my scripts as a packaged solution, first to a test or QA environment and then to production?
    

If so, then you want to [setup a development environment](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/set-up-a-dev-environment) and package your scripts as a [script plugin](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin). You can use that infrastructure as a basis for writing and running [automated tests](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests).

## For the Unsure

Not sure which tidy box to put yourself in? That’s okay! Start with the [built-in code editor](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor) to help you write your own custom scripts faster. If you find yourself wanting more, look at the options for Builders. We realize and celebrate that scripters are often programmers and users. Embrace scripting and try something…​ on your test server, of course.
