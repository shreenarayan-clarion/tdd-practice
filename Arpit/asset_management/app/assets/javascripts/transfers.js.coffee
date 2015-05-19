# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->

  ### Display confirmation dialog before transfer Employee ###
  if $("#transfer_transferable_type").val() == "Employee"
    $("#btn_transfer").click ->
      if $("#new_transfer").valid()
        if confirm("This will release all assigned devices of Employee?")
          return true
        else
          return false

  ### Custom validation methos to validate "From" & "To" branch ###
  $.validator.addMethod "notEqualTo", ((value, element, param) ->
    @optional(element) or value isnt $(param).val()
  ), "Please select different branch"


  $("#transfer_from_location_id").change ->
    resource = $(this).attr('data-resource-name')
    id = $(this).val()
    transferable_id = $("#transfer_transferable_id")

    if (id == "")
      transferable_id.get(0).options.length = 0
      transferable_id.get(0).options[0] = new Option("Please Select", "")
    else
      ####$.ajax "/branches/#{id}/get_devices?resource=#{resource}",####
      $.ajax "/transfers/#{id}/resources?resource=#{resource}",
        type: 'GET'
        dataType: 'JSON'
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          transferable_id.get(0).options.length = 0
          transferable_id.get(0).options[0] = new Option("Please Select", "")
          console.log data.resource[0]
          $.each data.resource, (index, item) ->
            if data.resource_name == "Employee"
              name = item.first_name + " " + item.last_name
            else
              name = item.device_identifier + "-" + item.serial_number
            transferable_id.get(0).options[$("#transfer_transferable_id").get(0).options.length] = new Option(name, item.id)
          transferable_id.multiselect('rebuild');






