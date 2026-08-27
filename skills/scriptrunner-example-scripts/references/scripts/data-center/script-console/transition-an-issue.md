# Transition an Issue

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-transition-issue-input-paramaters-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-issue-input-paramaters-onPrem

## Overview

Transition an issue through a workflow action. In this example, we set the **resolution** value.

## Description

#### Overview

Transition an issue through a workflow action. In this example, we set the **resolution** value.

## Script

```groovy
Issues.getByKey('SR-1').transition('Resolve Issue') {
    setResolution('Done')
}
```

