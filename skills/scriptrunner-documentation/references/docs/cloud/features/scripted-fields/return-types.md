# Return Types

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scripted-fields
- Doc ID: doc-sr4jc-517020953
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/return-types

The script for your field must return the correct data type.

For a text field, the script must return a single line String. The String returned must be no more than 255 characters and must not contain any newline characters. If you want to return a string of more than 255 characters, you should use a [paragraph scripted field](#id-.ReturnTypesvCurrent-richtext).

```
// This is OK
return "Hello World"
// This is not OK
return "Hello\nWorld"
```

For a number field, the script must return a numeric type, for example an Integer, Long, Float, Decimal, or BigDecimal.

For a date field, the script must return a [LocalDate](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html).

```
import java.time.LocalDate
import java.time.Month
return LocalDate.of(2020, Month.JUNE, 25)
```

For a datetime field, the script must return a [ZonedDateTime](https://docs.oracle.com/javase/8/docs/api/java/time/ZonedDateTime.html).

```
import java.time.LocalDate
import java.time.LocalTime
import java.time.Month
import java.time.ZonedDateTime
import java.time.ZoneId
import java.time.ZoneOffset
return ZonedDateTime.now(ZoneId.of("America/New_York"))
// or
return ZonedDateTime.of(LocalDate.of(2020, Month.JUNE, 25), LocalTime.of(13, 45, 0), ZoneOffset.ofHours(-3))
```

For a paragraph field, you can return either plain text or rich text.

You can use plain text if you want to return a single line string of more than 255 characters. You cannot include newline characters in a plain text string.

If you return using rich text, you **must** use the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/) (ADF). You can refer to Atlassian's [ADF Builder](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) for further details. You can also watch our [demo video](https://www.youtube.com/watch?v=I0UD_MH2vg8) showing how to display tables within scripted fields using rich text.

We've provided some ADF examples below:

-   table with headings, 2 rows and 2 columns

```
[
  "version": 1,
  "type": "doc",
  "content": [
    [
      "type": "table",
      "attrs": [
        "isNumberColumnEnabled": false,
        "layout": "default",
        "localId": "58c619ab-f32c-4dfa-aa54-2b4b39643deb"
      ],
      "content": [
        [
          "type": "tableRow",
          "content": [
            [
              "type": "tableHeader",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Header 1"
                    ]
                  ]
                ]
              ]
            ],
            [
              "type": "tableHeader",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Header 2"
                    ]
                  ]
                ]
              ]
            ]
          ]
        ],
        [
          "type": "tableRow",
          "content": [
            [
              "type": "tableCell",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Row 1 Column 1"
                    ]
                  ]
                ]
              ]
            ],
            [
              "type": "tableCell",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Row 1 Column 2"
                    ]
                  ]
                ]
              ]
            ]
          ]
        ],
        [
          "type": "tableRow",
          "content": [
            [
              "type": "tableCell",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Row 2 Column 1"
                    ]
                  ]
                ]
              ]
            ],
            [
              "type": "tableCell",
              "attrs": [:],
              "content": [
                [
                  "type": "paragraph",
                  "content": [
                    [
                      "type": "text",
                      "text": "Row 2 Column 2"
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
]
```

When you are in work item view, this table example appears as follows:

![](/sr4jc/files/latest/517020953/517020956/1/1773314298000/issue+view.jpg)

-   paragraph

```
[
  "version": 1,
  "type": "doc",
  "content": [
    [
      "type": "paragraph",
      "content": [
        [
          "type": "text",
          "text": "This is a paragraph"
        ]
      ]
    ]
  ]
]
```

When you are in work item view, this paragraph example appears as follows:

![](/sr4jc/files/latest/517020953/517020955/1/1773314299000/issue+view+paragraph.jpg)

JSON notations

Atlassian’s Document Format Builder outputs JSON, so if you want to use it directly in the console rather than converting it to Groovy, you can use `new groovy.json.JsonSlurper().parseText("""Your ADF""")`. See the example below:

  

```
return new groovy.json.JsonSlurper().parseText("""
{
  "version": 1,
  "type": "doc",
  "content": [
    {
      "type": "table",
      "attrs": {
        "isNumberColumnEnabled": false,
        "layout": "default",
        "localId": "58c619ab-f32c-4dfa-aa54-2b4b39643deb"
      },
      "content": [
        {
          "type": "tableRow",
          "content": [
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Header 1"
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Header 2"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "tableRow",
          "content": [
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Row 1 Column 1"
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Row 1 Column 2"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "tableRow",
          "content": [
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Row 2 Column 1"
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Row 2 Column 2"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
""")
```

* * *
