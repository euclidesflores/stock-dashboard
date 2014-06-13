class StockDashboard.Views.Tweets extends Backbone.View
   template: JST['dashboards/tweets']

   initialize: ->
     @listenTo @collection, 'collectionUpdatedEvent', @updateView     

   render: ->
     $(@el).html(@template(collection: @collection))
     @

   updateView: ->
     @render()
