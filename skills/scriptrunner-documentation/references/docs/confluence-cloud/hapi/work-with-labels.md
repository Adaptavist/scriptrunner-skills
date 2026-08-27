# Work with Labels

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: hapi
- Doc ID: doc-sr4cc-416678102
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-labels

HAPI makes it easier for you to add and find labels! 

## Add labels

Using HAPI, you can add one or multiple labels designated in the script. The page ID of the page created on [Create a Page](https://docs.adaptavist.com/sr4c/latest/hapi/create-a-page) is `196721`, so we will use that in the example. To add a label to a page in a space, use a script like this: 

```
def page = Pages.getById(196721)
page.addLabels("label-here1", "label-here2")
```

After running this script, the `FAQ` in the `Test` has the two new labels:

![](/sr4cc/files/latest/416678102/416678105/1/1753906795000/add-labels.png)

You can customize the script by changing the page ID or the labels.

## Get labels from a page

Using HAPI, you can see what labels are on a page. For this example, we will use the same page ID from the above example. To get labels from a page, use a script like this: 

```
def page = Pages.getById(196721)
def labelsOnPage = page.getLabels()
```

After the script finishes running, the labels appear in the log: 

![](/sr4cc/files/latest/416678102/416678104/1/1753981731000/get-labels-from-page.png)

You can customize the script by changing the page ID.
