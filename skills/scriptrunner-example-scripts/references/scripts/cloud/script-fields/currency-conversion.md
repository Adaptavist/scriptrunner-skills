# Currency conversion

- Platform: cloud
- Feature: script-fields
- Tags: issue, hapi, fields
- Language: groovy
- Doc ID: example-cloud-currency-conversion-cloud
- Source: https://examples.scriptrunner.io/scripts/currency-conversion-cloud

## Overview

Get the value shown in a number field and convert this to a different currency.

## Example

This example shows how you can get the value shown in a number field on the work item and convert this to a different currency and display this in a Scripted Field on the work item.

## Good to Know

The field that this script will evaluate should be configured to use a 'Number' return type.
The API of choice will most likely need to be configured (e.g. with access key) as per its own documentation to perform successful REST calls.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
// The name of the field containing the value to be converted (e.g. 'Euro Amount', 'Cost EUR', 'Cost in euros')
def costFieldName = 'Euro Amount'

// Extract the value of that field from the work item being viewed
def euroValue = currentWorkItem.getCustomFieldValue(costFieldName) as BigDecimal

// Use a 3rd-party currency conversion REST API and configure it as appropriate
def conversionResult = get("https://api.exchangeratesapi.io/latest?base=EUR&symbols=USD")
        .queryString('access_key', 'DUMMY_API_KEY')
        .queryString('base', 'EUR')
        .queryString('symbols', 'USD')
        .asObject(Map)
        .body

def usdRate = (conversionResult.rates as Map<String, BigDecimal>).USD

// Return the new currency value
if (euroValue && conversionResult != null) {
    return euroValue * usdRate
} else {
    return 0
}
```

