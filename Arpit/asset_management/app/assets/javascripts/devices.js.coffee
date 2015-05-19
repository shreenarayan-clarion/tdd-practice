# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->

  disable_assign_option = ->
    $("#device_status").parent().addClass('disabled')
    input = $("input[value='assigned']")
    input.prop('disabled', true)
    input.parents('li').addClass('disabled')

  status_type = $("#device_status").attr('data-assigned')
  parent = $("#device_parent_id").val()
  if parent != ''
    $("#device_status").multiselect('disable')
  else
    $("#device_status").multiselect('enable')
  if status_type == 'true'
    disable_assign_option()

  $("#device_lifetime_warranty").change ->
    if this.checked
      $("#warrenty_values").hide()
      $("#device_warranry_year").addClass('ignore')
      $("#device_warranry_month").addClass('ignore')
    else
      $("#device_warranry_year").removeClass('ignore')
      $("#device_warranry_month").removeClass('ignore')
      $("#warrenty_values").show()

  $("#remove-device").click ->
    if $(".remove_nested_fields:visible:last").length > 0 
      $(".remove_nested_fields:visible:last").click()

  $("#device_parent_id").change ->
    label = $(this.options[this.selectedIndex]).closest('optgroup').prop('label');
    if label?
      $("#device_status").multiselect('disable')
      label_status = label
      if label_status == 'In Stock'
        status = 'instock'
      else
        status = label_status.toLowerCase()
    else
      status = 'instock'
      $("#device_status").multiselect('enable')
      $("#device_status").parent().removeClass('disabled')
    $("#device_status").prop('value', status).multiselect('refresh')
    if $("#device_status").attr('data-assigned') == "true"
      disable_assign_option()

