# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->

  $(".category_select, #device_branch_id, .branch_select").change ->
    parent_device_select = "<option value=''>Select Associated Device</option>"
    defaul_select = "<option value=''>Please Select</option>"
    branch_id = $('.branch_select').val()
    category_id = $('.category_select').val()
    $("#device_status").prop('value', '').multiselect('enable').multiselect('refresh')
    if $.isNumeric(branch_id)
      $.ajax "/branches/#{branch_id}/associate_data",
        type: 'GET'
        dataType: 'json'
        data:
          device_category_id: category_id
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          emp_select = defaul_select
          device_select = defaul_select
          parent_instock_device = ''
          parent_assign_device = ''
          $.each data.employees, (i, e) ->
            emp_select += "<option value=#{e.id}>#{e.first_name} #{e.last_name}</option>"
          $.each data.devices, (i, a) ->
            device_value = "<option value=#{a.id}>#{a.device_identifier} - #{a.serial_number}</option>"
            if a.status == 'assigned'
              parent_assign_device += device_value
            else
              parent_instock_device += device_value
          parent_device_select += "<optgroup label='Assigned'>"+parent_assign_device+"</optgroup>" if parent_assign_device != ''
          parent_device_select += "<optgroup label='In Stock'>"+parent_instock_device+"</optgroup>" if parent_instock_device != ''
          $("#device_parent_id").html(parent_device_select)
          $(".device_select").html(parent_instock_device)
          $(".employee_select").html(emp_select)
          $('#device_parent_id, .employee_select, .device_select').multiselect('rebuild')
    else
      $(".device_select, .employee_select").html(defaul_select)
      $("#device_parent_id").html(parent_device_select)
      $('#device_parent_id').multiselect('rebuild') 
