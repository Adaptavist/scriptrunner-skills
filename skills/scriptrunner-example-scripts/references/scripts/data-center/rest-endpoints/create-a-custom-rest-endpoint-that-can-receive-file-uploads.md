# Create a custom REST endpoint that can receive file uploads

- Platform: data-center
- Feature: rest-endpoints
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-file-upload-to-rest-endpoint-onPrem
- Source: https://examples.scriptrunner.io/scripts/file-upload-to-rest-endpoint-onPrem

## Overview

This REST endpoint allows receiving file uploads from an HTML form, that may look like:

    <form action="http://jirahost/rest/scriptrunner/latest/custom/fileUpload" method="POST" enctype="multipart/form-data">
        <input type="file" name="myfile">
        <input type="submit"/>
    </form>

The key point here is that the endpoint closure has the signature:

    { MultivaluedMap queryParams, HttpServletRequest request ->

Note the second argument is a `HttpServletRequest`, and not a `String`. 
When we see this we do not attempt to read the request input stream.

## Description

#### Overview

This REST endpoint allows receiving file uploads from an HTML form, that may look like:

    <form action="http://jirahost/rest/scriptrunner/latest/custom/fileUpload" method="POST" enctype="multipart/form-data">
        <input type="file" name="myfile">
        <input type="submit"/>
    </form>

The key point here is that the endpoint closure has the signature:

    { MultivaluedMap queryParams, HttpServletRequest request ->

Note the second argument is a `HttpServletRequest`, and not a `String`. 
When we see this we do not attempt to read the request input stream.

## Script

```groovy
import com.adaptavist.hapi.jira.issues.Issues
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript
import org.apache.commons.fileupload.disk.DiskFileItemFactory
import org.apache.commons.fileupload.servlet.ServletFileUpload

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response
import java.nio.file.Files

@BaseScript CustomEndpointDelegate delegate

fileUpload(httpMethod: "POST", groups: ['jira-users']) { MultivaluedMap queryParams, HttpServletRequest request ->

    if (ServletFileUpload.isMultipartContent(request)) {
        def factory = new DiskFileItemFactory()
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")))

        def upload = new ServletFileUpload(factory)

        def fileItems = upload.parseRequest(request)

        fileItems.each { fileItem ->
            // do something with each fileItem -

            // for example, you can get the name:
            // fileItem.name

            // the contents:
            // fileItem.inputStream

            // or write to another file:
            // fileItem.write(new File('/tmp/myfile.png'))

            // purely as an example, the following code demonstrates attaching each file to an existing issue
            def tempDirectory = Files.createTempDirectory(null)
            try {
                def attachmentFile = new File(tempDirectory.toFile(), fileItem.name)
                fileItem.write(attachmentFile)
                Issues.getByKey('SR-1').addAttachment(attachmentFile)

            } finally {
                tempDirectory.deleteDir()
            }
        }
    }

    Response.noContent().build()
}
```

