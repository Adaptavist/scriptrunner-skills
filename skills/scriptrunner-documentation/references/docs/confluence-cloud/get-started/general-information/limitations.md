# Limitations

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: get-started > general-information
- Doc ID: doc-sr4cc-223117958
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/limitations

Several limitations (timeouts, event rate limiting, and package imports) are applied to scripts when they run. The limits should be more than sufficient for most scripts and are designed to catch erroneous scripts. 

## Timeouts

There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated. Any logs from the first 240 seconds of execution will be logged on the  [Script Logs](https://docs.adaptavist.com/sr4cc/latest/features/logging/script-logs) page.

Different timeout limit for custom macros

The execution timeout limit for [Custom Macros](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros) is 60 seconds.

## Package imports

While you can import packages into your scripts in the script console. For listeners, you can only import from the standard Java 11 classes and the following libraries:

-   org.apache.groovy:groovy:4.0.22
    
-   org.apache.groovy:groovy-datetime:4.0.22
    
-   org.apache.groovy:groovy-dateutil:4.0.22
    
-   org.apache.groovy:groovy-json:4.0.22
    
-   org.apache.groovy:groovy-jsr223:4.0.22
    
-   org.apache.groovy:groovy-nio:4.0.22
    
-   org.apache.groovy:groovy-sql:4.0.22
    
-   org.apache.groovy:groovy-templates:4.0.22
    
-   org.apache.groovy:groovy-xml:4.0.22
    
-   com.fasterxml.jackson.core:jackson-core:2.17.2
    
-   com.fasterxml.jackson.core:jackson-annotations:2.17.2com.fasterxml.jackson.core:jackson-core:2.17.2
    
-   com.fasterxml.jackson.core:jackson-databind:2.17.2
    
-   com.fasterxml.jackson.datatype:jackson-datatype-jdk8:2.17.2
    
-   com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.17.2
    
-   com.fasterxml.jackson.module:jackson-module-jaxb-annotations:2.17.2
    
-   io.github.openunirest:unirest-java:2.2.10
    
-   com.google.code.gson:gson:2.9.0
    
-   commons-logging:commons-logging:1.2
    
-   commons-codec:commons-codec:1.11
    
-   org.apache.httpcomponents:httpclient:4.5.13
    
-   org.apache.httpcomponents:httpcore:4.4.13
    
-   org.apache.httpcomponents:httpmime:4.5.13
    
-   org.apache.httpcomponents:httpasyncclient:4.1.4
    
-   org.apache.httpcomponents:httpcore-nio:4.4.10
    
-   org.apache.httpcomponents:httpcore:4.4.13
    
-   org.slf4j:slf4j-api:1.7.36
    
-   io.jsonwebtoken:jjwt:0.9.1
    
-   org.jsoup:jsoup:1.15.3
    
-   com.amazonaws:aws-lambda-java-log4j2:1.5.1
    
-   org.apache.logging.log4j:log4j-api:2.19.0
    
-   org.apache.logging.log4j:log4j-core:2.19.0 (\*)
    
-   org.apache.logging.log4j:log4j-slf4j-impl:2.19.0
    
-   org.apache.logging.log4j:log4j-iostreams:2.19.0
    
-   org.apache.logging.log4j:log4j-1.2-api:2.19.0
    
-   com.sun.mail:javax.mail:1.6.2
    
-   org.postgresql:postgresql:42.2.19
    
-   mysql:mysql-connector-java:8.0.33
    
-   com.microsoft.sqlserver:mssql-jdbc:9.2.1.jre11
