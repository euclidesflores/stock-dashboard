window.StockDashboard =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
   new StockDashboard.Routers.Dashboards()
   Backbone.history.start(pushState: true)

$(document).ready ->
  StockDashboard.initialize()
