class StockDashboard.Routers.Dashboards extends Backbone.Router
  routes: 
    ''                : 'index'

  initialize: -> 

  index: ->
    view = new StockDashboard.Views.DashboardsIndex()
    $('#container').html(view.render().el)
    $("#stockSymbolTxt").focus()    

  dashboard: ->

