# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $("#quotations").delegate "#device_request_quotations_attributes_0_device_request_id", "change", (e) ->
    $("#loading_div").removeClass("hide")
    $("#device_transaction_div").addClass("hide")
    id = $(this).val()
    vendor_id = $("#device_request_quotations_attributes_0_vendor_id")

    if (id == "")
      $("#loading_div").addClass("hide")
      vendor_id.get(0).options.length = 0
      vendor_id.get(0).options[0] = new Option("Please Select", "")
      vendor_id.multiselect('rebuild');
      $("#device_transaction_div").addClass("hide")
    else
      ####$.ajax "/branches/#{id}/get_devices?resource=#{resource}",####
      $.ajax "/quotations/#{id}/request_vendors",
        type: 'GET'
        dataType: 'JSON'
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          $("#loading_div").addClass("hide")
          vendor_id.get(0).options.length = 0
          vendor_id.get(0).options[0] = new Option("Please Select", "")
          $.each data.vendors, (index, item) ->
            vendor_id.get(0).options[$("#device_request_quotations_attributes_0_vendor_id").get(0).options.length] = new Option(item.name, item.id)
          vendor_id.multiselect('rebuild');

  $("#quotations").delegate "#device_request_quotations_attributes_0_vendor_id", "change", (e) ->
    $("#loading_div").removeClass("hide")
    $("#loading_div").removeClass("hide")
    id = $(this).val()
    vendor_id = $("#device_request_quotations_attributes_0_vendor_id")

    if (id == "")
      $("#loading_div").addClass("hide")
      $("#device_transaction_div").addClass("hide")
    else
      ####$.ajax "/branches/#{id}/get_devices?resource=#{resource}",####
      device_request_id = $("#device_request_quotations_attributes_0_device_request_id").val()
      $.ajax "/quotations/new?vendor_id=#{id}&device_request_id=#{device_request_id}",
        type: 'GET'
        dataType: 'script'
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          $("#loading_div").addClass("hide")