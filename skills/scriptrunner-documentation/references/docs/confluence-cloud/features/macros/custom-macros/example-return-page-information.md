# Example: Return Page Information

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > custom-macros
- Doc ID: doc-sr4cc-246187400
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-return-page-information

You can create a macro to pull the page information (like page title, the page creator, the parent page, and the space) of Confluence content onto a Confluence page.

## Create the macro

1.  Select **Create Custom Macro**. 
2.  Enter a **Name** to identify the Macro, like _Page Information_. 
3.  Enter an optional **Description**, like _Get the current page title, the page creator, the parent page, and the space_. 
4.  Select **Enabled** to allow the macro to be added to pages. 
5.  Select _None_ for **Body Type.** 
6.  Pick _Block_ for **Output Type**.   
    ![](/sr4cc/files/latest/246187400/246187403/1/1709060386000/page-info-maco-form.png)
7.  Enter the following script into the **Script to Execute** field: 
    
    This script uses the response status code for error checking.
    
    ```
//ERROR CHECKING USING THE RESPONSE STATUS
//Variables scoped and default value assigned
def pageInfo
String pageLink, spaceLink, ownerLink, parentLink
pageLink = spaceLink = ownerLink = parentLink = "Not available" //Catch-all error management
//Use Implicit Parameters to create Page and Space links
pageLink = "<ac:link><ri:content-entity ri:content-id='${parameters.pageId}'/></ac:link>"
spaceLink = "<ac:link><ri:space ri:space-key='${parameters.spaceKey}'/></ac:link>"
//Get page info via REST using Unirest
pageInfo = get("/wiki/api/v2/pages/${parameters.pageId}")
    .header("Accept", "application/json")
    .asObject(Map)
if (pageInfo.status == 200) {
	if (pageInfo.body.ownerId) { //Space overview pages return null for owner ID
	//Explicit null check - if (pageInfo.body.ownerId != null) - is not necessary in Groovy
	    ownerLink = "<ac:link><ri:user ri:account-id='${pageInfo.body.ownerId}'/></ac:link>"
	} else {
	    ownerLink = "This page does not have an owner." //Degrade gracefully
	}
	//Get parent info if available (Space Overview pages do not have a parent)
	if (pageInfo.body.parentId) {
		parentLink = "<ac:link><ri:content-entity ri:content-id='${pageInfo.body.parentId}'/></ac:link>"
	} else {
		parentLink = "There is no parent for this page."
	}
} else { 
    logger.info("pageInfo GET error: " + pageInfo.statusText) // Not very informative
	// + pageInfo.body.errors.code + pageInfo.body.errors.title would be better
	// or + pageInfo.body.errors
    return "<p>Page Information is not available currently. Pleasee try \
    refreshing the page or contact an administrator if the problem persists.</p>"
}
return """
<h4>Links</h4>
<p><strong>Current Page</strong>: ${pageLink}</p>
<p><strong>Page owner</strong>: ${ownerLink}</p>
<p><strong>Parent Page</strong>: ${parentLink}</p>
<p><strong>Space</strong>: ${spaceLink}</p>
"""
```
    
8.  Select **Save**.

## Results

The macro appears on the main _Macros_ page:

![](/sr4cc/files/latest/246187400/246187402/1/1709599386000/page-info-macro-page.png)

Users in your instance can now add it to Confluence pages. When it's added and the page is published, it appears like this:

![](/sr4cc/files/latest/246187400/246187404/1/1709060215000/page_information.png)
