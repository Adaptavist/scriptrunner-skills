# Example: Stock Exchange Price

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > custom-macros
- Doc ID: doc-sr4cc-125502822
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-stock-exchange-price

You can use the custom macro functionality to create a macro that allows users to display stock exchange prices on a Confluence page. 

The example below assumes you already have a REST API authentication token for the [StockData REST API](https://www.stockdata.org/) stored in a [Script Variable](https://docs.adaptavist.com/sr4cc/latest/features/script-variables) with the name `STOCKDATA_API_KEY`.

1.  Select **Create Custom Macro_._**
2.  Fill out the fields that appear:   
    1.  **Macro Name**: _Stock Exchange Price_. 
    2.  **Description**: Use this macro for a stock exchange price to appear on a Confluence page.
    3.  **Enabled** (radio button): Select _Enabled_.
    4.  **Body Type**: _None_. 
    5.  **Output Type**: _Block_
    6.  **Script to Execute**: Enter the script for the macro here.
        
        ```
def exchange_symbol = parameters['Stock Exchange Symbol']
def url = "https://api.stockdata.org/v1/data/quote?symbols=${exchange_symbol}&api_token=${STOCKDATA_API_KEY}"
def resp = get(url).asObject(Map)
if (resp.status > 300) {
    return "<p>Sorry, we couldn't fetch the stock details for ${exchange_symbol}</p>"
}
def body = resp.body as Map<List>
def data = body.data as List<Map>
if (!data) {
    return "<p>Sorry, we couldn't fetch the stock details for ${exchange_symbol}</p>"
}
def stock_price = "${data[0].price} ${data[0].currency}"
def stock_name = "${data[0].name} (${data[0].ticker})"

return """
<p>${stock_name} ${stock_price}</p>
"""
```
        
3.  Select **Add Parameter**.   
    1.  **Type**: _String_
    2.  **Name**: _Stock Exchange Symbol_
    3.  **Description**: Enter the symbol of the stock that you would like to see the exchange price for. 
    4.  **Required**: Do not tick the box
    5.  **Hidden**: Do not tick the box
    6.  Select **Add.  
        **
        
        When users add this macro to a Confluence page, they will enter something like _NASDAQ:AMZN_ for Amazon.com. 
        
4.  Select **Save**. 

**Result:** You can now use this macro on a Confluence page. For help with using the macro, check out the _Use Macros_ section of the [Macros](https://docs.adaptavist.com/sr4cc/draft/features/macros#id-.Macrosvlatest-Usemacros) documentation. 

This is what the macro looks when rendered on a Confluence page: 

![](/sr4cc/files/latest/125502822/125502824/1/1636651484000/stock_exchange_prices_1-2.png)

You can use multiple instances of it in a table, which would look like this: 

![](/sr4cc/files/latest/125502822/125502825/1/1635868790000/stock_exchange_prices_2.png)

If the user enters an incorrect stock code symbol in the macro editor, they will receive an error message in the output. You can see this error message in the image above.
