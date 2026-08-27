# A console script viewing filesystem performance of your local and shared home directories.

- Platform: data-center
- Feature: script-console
- Tags: administer, automate, project
- Language: groovy
- Doc ID: example-dataCenter-home-directories-filesystem-speed-benchmark-onPrem
- Source: https://examples.scriptrunner.io/scripts/home-directories-filesystem-speed-benchmark-onPrem

## Overview

ScriptRunner is sensitive to performance of the filesystem of the *shared home directory*. 

Use this script to view the benchmark speed of the shared home, and the local home (if in a multi-node Data Center environment).

## Good to Know

This script will download the "support-tools.jar", as linked to in the Atlassian article [Test disk access speed for a Java application](https://confluence.atlassian.com/kb/test-disk-access-speed-for-a-java-application-818577561.html). You can compare your results with the categories given at [Grading the Results](https://confluence.atlassian.com/kb/test-disk-access-speed-for-a-java-application-818577561.html#TestdiskaccessspeedforaJavaapplication-GradingtheResults).

## Description

#### Overview

ScriptRunner is sensitive to performance of the filesystem of the *shared home directory*. 

Use this script to view the benchmark speed of the shared home, and the local home (if in a multi-node Data Center environment).

#### Good to know

This script will download the "support-tools.jar", as linked to in the Atlassian article [Test disk access speed for a Java application](https://confluence.atlassian.com/kb/test-disk-access-speed-for-a-java-application-818577561.html). You can compare your results with the categories given at [Grading the Results](https://confluence.atlassian.com/kb/test-disk-access-speed-for-a-java-application-818577561.html#TestdiskaccessspeedforaJavaapplication-GradingtheResults).

## Script

```groovy
import com.onresolve.scriptrunner.canned.util.OutputFormatter
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import com.onresolve.scriptrunner.runner.diag.ClusterHomeLocatorService

import java.util.concurrent.TimeUnit

def file = new File(System.getProperty("java.io.tmpdir"), 'support-tools.jar')

if (!file.exists()) {
    def toolsUrl = 'https://confluence.atlassian.com/jirakb/files/54362304/54591494/3/1444177154112/support-tools.jar'
    new URL(toolsUrl).openConnection().with { conn ->
        file.withOutputStream { out ->
            conn.inputStream.with { inp ->
                out << inp
                inp.close()
            }
        }
    }
}

def clusterHomeLocatorService = ScriptRunnerImpl.scriptRunner.getBean(ClusterHomeLocatorService)

def javaHome = System.getProperty('java.home')

def runBenchmarkInDir = { File workdir ->
    def sout = new StringBuilder()
    def serr = new StringBuilder()
    def proc = "${javaHome}/bin/java -jar ${file.absolutePath}".execute([], workdir)
    proc.consumeProcessOutput(sout, serr)
    proc.waitForOrKill(TimeUnit.SECONDS.toMillis(20))
    sout
}

OutputFormatter.markupBuilder {
    div {
        h2("Disk speed in local home directory: ${clusterHomeLocatorService.homeDir}")
        pre(runBenchmarkInDir(clusterHomeLocatorService.homeDir))
        if (clusterHomeLocatorService.homeDir != clusterHomeLocatorService.sharedHomeDir) {
            h2("Disk speed in shared home directory: ${clusterHomeLocatorService.sharedHomeDir}")
            pre(runBenchmarkInDir(clusterHomeLocatorService.sharedHomeDir))
        } else {
            p('Your shared home directory is the same as your local home directory.')
        }
    }
}
```

