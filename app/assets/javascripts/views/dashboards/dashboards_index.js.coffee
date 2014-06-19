class StockDashboard.Views.DashboardsIndex extends Backbone.View
  template: JST['dashboards/index']

  events:
    'click #signOut': 'signOutTwitter'
    'click #searchBtn': 'searchStockInfo'
    'keypress #stockSymbolTxt': 'keyPressedStockTxt'

  initialize: ->
    @symbol = ""

  render: ->
    $(@el).html(@template())
    @

   signOutTwitter: (event) ->
     @render()

   searchStockInfo: (event) ->
     $('#error-panel').addClass('hidden')
     event.preventDefault()
     stockSymbolTxt = $('#stockSymbolTxt').val()
     @invalidTicker(stockSymbolTxt) if (stockSymbolTxt.length < 1 || stockSymbolTxt.length > 10)
     @show() if (stockSymbolTxt.length > 0 && stockSymbolTxt.length <= 10)

   invalidTicker: (ticker) -> 
     @raiseError("Ticker symbol can not be blank" if (ticker.length < 1)
     @raiseError("Ticker symbol does not exist") if ticker.length > 4)
     
   keyPressedStockTxt: (event) ->
     $('#error-panel').addClass('hidden')
     @searchStockInfo(event) if (event.keyCode == 13) 

    show: () ->
      that = this
      try
        newModel = new StockDashboard.Models.Stock()
        newModel.fetch success: (model, response, options) ->
           isInvalid = response.query.results.quote.ErrorIndicationreturnedforsymbolchangedinvalid
           that.raiseError("No such ticker symbol") if isInvalid?
           that.updateView(model, response, options) if !isInvalid?         
      catch error
        console.log(error)


    raiseError: (error_message) ->
       $('#error-panel').removeClass('hidden')
       $('#error-panel').find("span").remove()
       $('#error-panel').append("<span>" + error_message + "</span>")
       $('#stockSymbolTxt').select() if $('#stockSymbolTxt').length > 0

    updateView: (model, response, options) ->
       @tweets = new StockDashboard.Collections.Tweets()
       @model.destroy() if @model?
       @view.remove() if @view?
       @model = model
       @listenTo @model, 'updateTweetsEvent', @updateTweets
       @model.updateAttributes(response)
       @view = new StockDashboard.Views.Stock({model: model})
       $('#left-panel').append @view.render().el
      
    updateTweets: (model) ->
       @updateTweetsView() if @tweets.length > 0
       @resetTweetsView() if @tweets.length == 0


    updateTweetsView: () ->
       that = this
       @tweets.fetch
                 success: (collection, response, options) ->
                      that.tweets.updateCollection(that.tweets)
     
    resetTweetsView: () ->
       that = this
       $('#right-panel').removeClass('hidden') 
       @twtsView.remove() if @twtsView? 
       @tweets.fetch success: (collection, response, options) ->
          that.twtsView = new StockDashboard.Views.Tweets({collection: that.tweets})
          $('#tweets').append that.twtsView.render().el
