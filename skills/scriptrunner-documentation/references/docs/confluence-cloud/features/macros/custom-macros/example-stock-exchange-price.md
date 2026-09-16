# Example: Stock Exchange Price

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Custom Macros
- Doc ID: doc-sr4cc-f1576cc8-761a-4bb6-bdb6-2afb020365a9-68188d5db855ecd7
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros#example-stock-exchange-price--en

You can use the custom macro functionality to create a macro that allows users to display stock exchange prices on a Confluence page.

The example below assumes you already have a REST API authentication token for the [StockData REST API](https://www.stockdata.org/) stored in a [Script Variable](../../script-variables.md) with the name `STOCKDATA_API_KEY`.

1.  Select Create Custom Macro.
2.  Fill out the fields that appear:
    1.  Macro Name: Stock Exchange Price.
    2.  Description: Use this macro for a stock exchange price to appear on a Confluence page.
    3.  Enabled (radio button): Select Enabled.
    4.  Body Type: None.
    5.  Output Type: Block
    6.  Script to Execute: Enter the script for the macro here.
        
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
        
3.  Select Add Parameter.
    
    1.  Type: String
    2.  Name: Stock Exchange Symbol
    3.  Description: Enter the symbol of the stock that you would like to see the exchange price for.
    4.  Required: Do not tick the box
    5.  Hidden: Do not tick the box
    6.  Select Add.
    
    Note: When users add this macro to a Confluence page, they will enter something like NASDAQ:AMZN for Amazon.com.
    
4.  Select Save.

You can now use this macro on a Confluence page. For help with using the macro, check out the Use Macros section of the [Macros](../../macros.md) documentation.

This is what the macro looks when rendered on a Confluence page:

You can use multiple instances of it in a table, which would look like this:

Tip: If the user enters an incorrect stock code symbol in the macro editor, they will receive an error message in the output. You can see this error message in the image above.
