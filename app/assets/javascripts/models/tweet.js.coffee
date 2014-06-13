class StockDashboard.Models.Tweet extends Backbone.Model
  defaults: () ->
    "id": "" 
    "created_at": '1969-12-31 19:00:00'
    "text": ""
    "screen_name": ""
    "name": ""
    "date_tz": ""
    "name_tag": ""
    "screen_name_tag": ""

  initialize: () ->
    created_at_tz = new Date(Date.parse(@get('created_at')))
    @set("date_tz", @formatDate(created_at_tz)) 
    @set("name_tag", "<a href=https://twitter.com/" + @get('screen_name') + ">" + @get('name') + "</a>") 
    @set("screen_name_tag", "<a href=https://twitter.com/" + @get('screen_name') + "> (@" + @get('screen_name') + ")</a>") 

  formatDate: (dt) ->
    monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    dtToStr = monthNames[dt.getMonth()] + ' ' + dt.getDate() + ', ' + dt.getFullYear()
    return dtToStr
