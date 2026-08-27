# ScriptRunner Dev and Deployment Tool

- Platform: migration-suite
- Space: SMS
- Hierarchy: n/a
- Doc ID: doc-sms-448135909
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool

Use the Dev and Deployment Tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

## How the tool works

The Dev and Deployment Tool gives you a place to save your scripts' code and their configuration _and_ a way to deploy that code to ScriptRunner in your Atlassian Cloud site without having to manually point-and-click through the UI.

This is helpful if you have a lot of scripts, particularly if you want to test them in a separate instance before deploying them to production.

Often, you might go through a few rounds of editing the script on a test site to get it "right", perhaps with the assistance of the [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) or in collaboration with the users who rely on the script to work a certain way. Once you've got it working right in a test instance, it's a bit tedious to manually copy-and paste all the code and configuration for each script into a new production site. The more scripts you're managing, the more work this is. Also, if you have to make changes to lots of scripts over time in collaboration with multiple people, it can be helpful to have a record of the changes you've made.

The Dev and Deployment Tool enables all of that using software development tools like git, Gradle, and an IDE. You don't need to be an expert at using those tools to get value from it, but if you're already comfortable with any of them it's likely to make your ScriptRunner migration more manageable.

### How to use the tool

Please visit [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool) to learn how to clone the [public repository](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/) and follow the README to configure and run the tooling.

It's important to note that you will need to edit [the extensions.yaml file](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/cloud/src/main/resources/extensions.yaml) to configure details about your scripts, such as how often a Job runs or what events a Listener responds to. The JSON files included in the Script Export from Data Center should provide an outline on what configuration you need. You can ask the [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) for help in converting them to YAML.

Even with AI assistance, this step can be challenging, and we aim to provide more documentation and tooling for it in the future.

The Dev and Deployment Tool streamlines many aspects of script conversion and management, but many parts of the process are still being refined. We appreciate your patience as we continue to develop and enhance this tool.

Watch a demo of the Dev and Deployment tool below! ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") 

## Related documentation 

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)
-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)
-   [Best Practices](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/best-practices)
-   [Migrate to Cloud Using the ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite)

## [![](/sms/files/latest/448135909/534479395/1/1776103632000/sr-icon-comments.png)](https://www.adaptavist.com/products/atlassian-apps/get-involved-scriptrunner?queryID=d51c44fdc2ca51c26341f63b3881b962)

## Get involved

Tell us how we can keep improving! Your feedback directly shapes the ScriptRunner product roadmaps and empowers others just like you.

[Give feedback](https://docs.google.com/forms/d/e/1FAIpQLSdt-Ex1FbA3gKIjotLJBzGaSggypf4veyPCwxKl01zAC_YH9w/viewform)
