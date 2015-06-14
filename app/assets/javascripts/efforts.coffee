# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.notification-container a.close').on 'click', ->
    $(@).parent().fadeOut();

  if $('.message-panel').is(':visible')
    setTimeout (->
      $('.notification-container .message-panel').fadeOut()
    ), 8000

