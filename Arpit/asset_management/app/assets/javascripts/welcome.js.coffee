# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  window.setTimeout (->
    $(".alert").fadeOut()
    return
  ), 6000

  $(".close-icon").click ->
    $(".alert").fadeOut()
    return

  return
