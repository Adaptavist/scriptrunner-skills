# Use Regex to Find Email Addresses in a String and Find the User

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-use-regex-to-find-emails-address-onPrem
- Source: https://examples.scriptrunner.io/scripts/use-regex-to-find-emails-address-onPrem

## Overview

Find an email address in a string using regex, and find a user from the email address using the UserSearchService.

## Example

I am a Jira administrator, and for my Jira instance, the Description field is automatically generated and contains the email address of the person reporting the issue. 
I want to identify the user the email belongs to so that I can add them as the Reporter for the issue. 
This script uses regex to find the email address in the Description, then uses the UserSearchService to identify the user, and returns the user's name.

## Description

#### Overview
Find an email address in a string using regex, and find a user from the email address using the UserSearchService.                            
#### Example
I am a Jira administrator, and for my Jira instance, the Description field is automatically generated and contains the email address of the person reporting the issue. 
I want to identify the user the email belongs to so that I can add them as the Reporter for the issue. 
This script uses regex to find the email address in the Description, then uses the UserSearchService to identify the user, and returns the user's name.

## Script

```groovy
import java.util.regex.Pattern
import com.atlassian.jira.component.ComponentAccessor

//Define the UserSearchService, which we will use to find the User from the Email Address
def userSearchService = ComponentAccessor.userSearchService

//Define the Regex to find the Email Addresses
def regex = "([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\\.[a-zA-Z0-9_-]+)"
//Define a String to search through
def searchQuery = "this is the email: example@email.com, anotherExample@email.com"

//Define the Pattern with the Regex, and the Matcher with the searchQuery
def pattern = Pattern.compile(regex, Pattern.MULTILINE)
def matcher = pattern.matcher(searchQuery)

//Using each, iterate through the Matcher's result
matcher.each {
    //Observe the Email Address found
    log.warn matcher.group(0)

    //Use the UserSearchService to find the User by Email
    def userFoundByEmail = userSearchService.findUsersByEmail( matcher.group(0) )
    //Observe the User found - if this returns an empty List, no User was found
    log.warn userFoundByEmail
}
```

