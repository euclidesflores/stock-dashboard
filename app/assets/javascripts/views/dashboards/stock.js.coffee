class StockDashboard.Views.Stock extends Backbone.View
  template: JST['dashboards/stock']

  initialize: ->
    @collection = new StockDashboard.Collections.Tweets()
    @listenTo @model, 'destroy', @unbindTimer
    that = this
    mdl = @model
    @timer = setInterval ->
       try
        mdl.fetch success: (model, response, options) ->
          model.updateAttributes(response)    
          that.render()
    , 60000

  render: ->
    $(@el).html(@template(model: @model))
    @

  unbindTimer: ->
    clearInterval(@timer)
