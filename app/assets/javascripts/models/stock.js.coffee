class StockDashboard.Models.Stock extends Backbone.Model
  defaults: () ->
    "name": ""
    "stockExchangeInfo": ""
    "symbol": ""
    "price": 0
    "lastTradeDate": '1969-12-31 19:00:00'
    "lastTradeTime": ''
    "change": 0
    "changePercent": 0
    "volume": 0
    "open": 0
    "previousClose": 0
    "high": 0 
    "low": 0
    "avgDlyVol": 0
    "marketCap": 0

  initialize: ->
     @symbol = $('#stockSymbolTxt').val()

  url: () ->
     nurl = 'http://query.yahooapis.com/v1/public/yql'
     data = encodeURIComponent("select * from yahoo.finance.quotes where symbol in ('" + @symbol + "')")
     return nurl + '?q=' + data + '&format=json&diagnostics=true&env=http://datatables.org/alltables.env' 

   updateAttributes: (response) ->
     rawData = response.query.results.quote
     @set("name", rawData.Name)
     @set("symbol", rawData.Symbol)
     @set("lastTradeDate", rawData.LastTradeDate)
     @set("lastTradeTime", rawData.LastTradeTime)
     dtf = @getLastTradeDateTime(@get('lastTradeDate'), @get('lastTradeTime'))
     @set("stockExchangeInfo", rawData.StockExchange + ': ' + rawData.Symbol + ' - ' + dtf)
     @set("price", (if rawData.AskRealtime == null then '' else parseFloat(rawData.AskRealtime).toFixed(2)))
     @set("change", (if rawData.ChangeRealtime == null then '' else parseFloat(rawData.ChangeRealtime).toFixed(2)))
     @set("changePercent", @getChangePercentRealtime(rawData.ChangePercentRealtime))
     @set("volume", parseInt(rawData.Volume).toLocaleString())
     @set("open", (if rawData.Open == null then '0.00' else  parseFloat(rawData.Open).toFixed(2)))
     @set("previousClose", (if rawData.PreviousClose == null then '0.00' else parseFloat(rawData.PreviousClose).toFixed(2)))
     @set("high", (if rawData.DaysHigh == null then '0.00' else parseFloat(rawData.DaysHigh).toFixed(2)))
     @set("low", (if rawData.DaysLow == null then '0.00' else parseFloat(rawData.DaysLow).toFixed(2)))
     @set("avgDlyVol", (if rawData.AverageDailyVolumne == null then '0.00' else parseInt(rawData.AverageDailyVolume).toLocaleString()))
     @set("marketCap", rawData.MarketCapitalization)
     @trigger('updateTweetsEvent', @)

   getLastTradeDateTime: (lastTradeDate, lastTradeTime) ->
     monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
     dt = new Date(lastTradeDate)
     dtStr = monthNames[dt.getMonth()] + ' ' + dt.getDate() + ' ' + lastTradeTime
     return dtStr

   getChangePercentRealtime: (changePercent) ->
				if changePercent == null then return '' else return changePercent.replace('N/A - ', '')
   
