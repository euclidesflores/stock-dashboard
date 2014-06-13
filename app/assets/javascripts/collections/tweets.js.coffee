class StockDashboard.Collections.Tweets extends Backbone.Collection
  model: StockDashboard.Models.Tweet

  initialize: ->
    @symbol = "$" + $('#stockSymbolTxt').val()  
    @debug = true

  url: () ->
    nurl = 'http://127.0.0.1:3000/tweets/get_tweets?symbol=' + @symbol
    return nurl


  updateCollection: (collection) -> 
     @trigger('collectionUpdatedEvent')


