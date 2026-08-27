# Add a definition of done checklist

- Platform: cloud
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-cloud-definition-of-done-checklist-cloud
- Source: https://examples.scriptrunner.io/scripts/definition-of-done-checklist-cloud

## Overview

Add a definition of done checklist in a comment to each newly created work item.

## Example

As a product owner I want a definition of done checklist added to all *Story* and *Task* work items so that developers know when a work item is fully complete and ready to be merged.

## Good to Know

* To help define the *Atlassian Document Format* for the checklist use the [visual editor](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) that Atlassian provide to generate this. 
* In the generated format all { and } brackets need to be replaced with [ and ] brackets.

## Script

```groovy
import groovy.json.JsonOutput

def adfBody = [
  "version": 1,
  "type": "doc",
  "content": [
    [
      "type": "paragraph",
      "content": [
        [
          "type": "text",
          "text": "Definition Of Done Checklist:",
        ],
      ]
    ],
    [
      "type": "rule"
    ],
    [
      "type": "paragraph",
      "content": [
        [
          "type": "text",
          "text": "Checklist:",
          "marks": [
            [
              "type": "strong"
            ]
          ]
        ]
      ]
    ],
    [
      "type": "bulletList",
      "content": [
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "All Requirements on Ticket Complete."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Pull Request reviewed by at least 2 developers."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Thorough spot checking done and video attached to PR covering relevant edge cases."
                ],
                ],
              ]
            ]
          ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Unit tests all updated or added where necessary and pass."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Appropriate Monitoring or Error detection added."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Change fully regression tested for older code/config versions."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Release order considered."
                ]
              ]
            ]
          ]
        ],
        [
          "type": "listItem",
          "content": [
            [
              "type": "paragraph",
              "content": [
                [
                  "type": "text",
                  "text": "Documentation updated."
                ]
              ]
            ]
          ]
        ]
      ]
    ],
    [
      "type": "rule"
    ]
  ]
]

def commentBody = [
    body: [
        type: "doc",
        version: 1,
        content: adfBody.content
    ]
]

def addComment = post("/rest/api/3/issue/${issue.key}/comment")
    .header("Content-Type", "application/json")
    .body(JsonOutput.toJson(commentBody))
    .asJson()

assert addComment.status == 201
```

