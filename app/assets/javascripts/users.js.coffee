# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Twitter =
  extractId: (tweet) ->
    try
      $("#user_original_uid").attr('value', tweet[0].user.id)
    catch error
      alert("Couldn't read the tweets of this user")

  getUserId: (user) ->
    $.getJSON("http://twitter.com/statuses/user_timeline/"+user+".json?callback=?", @extractId)

window.Twitter = Twitter

$(document).ready ->
  $("#user_original").observe_field 1, (env) ->
    Twitter.getUserId(this.value)
