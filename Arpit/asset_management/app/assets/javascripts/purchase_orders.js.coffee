# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  if ($("#quotation_purchase_order_attributes_quotation_id").text() != undefined || $("#quotation_purchase_order_attributes_quotation_id").text() != "")
    $('#device_transactions').removeClass("hide")

  $("#purchase_div").delegate "#quotation_purchase_order_attributes_quotation_id", "change", (e) ->
    $("#loading_div").removeClass("hide")
    quotation_id = $(this).val()
    $.ajax "/purchase_orders/new",
      type: 'GET'
      dataType: 'script'
      data:
        quotation_id: quotation_id
      # quotation_id = $("#quotation_purchase_order_attributes_quotation_id")
      # quotation_id.multiselect('rebuild')
