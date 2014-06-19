class StockDashboard.Collections.Tweets extends Backbone.Collection
  model: StockDashboard.Models.Tweet

  initialize: ->
    @symbol = "$" + $('#stockSymbolTxt').val()  
    @debug = true

  url: () ->
    nurl = '/tweets/get_tweets?symbol=' + @symbol
    return nurl


  updateCollection: (collection) -> 
     @trigger('collectionUpdatedEvent')


