# Work with Templates

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: hapi
- Doc ID: doc-sr4cc-477865065
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-templates

You can fetch [blueprint templates](https://developer.atlassian.com/cloud/confluence/rest/v1/api-group-template/#api-wiki-rest-api-template-blueprint-get) inside your Confluence instance with a script like this: 

```
def template = Templates.getBlueprintTemplates();
template.each(t ->{
    logger.info(t.toString())
    logger.info(t.name)
})
```

In the Log, you can see that blueprint templates were imported. Here is an example: 

![](/sr4cc/files/latest/477865065/477865067/1/1765461512000/blueprint.png)

Fetching blueprint templates is also available as an [Example Script](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts)! 

The blueprint template properties you can work with are: 

-   `templateId`
-   `name`
-   `description`
-   `templateType`
-   `space`

For more information about blueprint templates, check out the [Atlassian documentation](https://developer.atlassian.com/cloud/confluence/rest/v1/api-group-template/#api-wiki-rest-api-template-blueprint-get).
