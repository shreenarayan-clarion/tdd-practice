ready = undefined
ready = ->

  # For Using Data table for the listing functionality
  param_action = window.location.pathname.split('/');

  $("#data_table").dataTable
    language:
      info: "Showing _START_ to _END_ of _TOTAL_ #{param_action[param_action.length - 1].split('_').join(' ')}"
      infoEmpty: "Showing 0 to 0 of 0 #{param_action[param_action.length - 1].split('_').join(' ')}"
    sPaginationType: "bootstrap"
    aoColumnDefs: [
      bSortable: false
      aTargets: ["action"]
    ]

  $("#device_category_software_data_tables").dataTable()

  $("#search_data_table").dataTable
    aoColumnDefs: [
      bSortable: false
      aTargets: ["action"]
    ]
    bPaginate: false
    bFilter: false
    bInfo: false

  # For using Date picket on the form
  $("[data-behaviour~=datepicker]").datetimepicker
    format: "dd/mm/yyyy"
    minView: 2 # This will provice only date . Remove if you want date and time
    autoclose: 1


  $("[data-behaviour~=datetimepicker]").datetimepicker
    format: "dd/mm/yyyy HH:ii P"
    todayBtn:  1
    autoclose: 1

  # Date can not be of future . So datepicker restricting to enter future date
  now = new Date()
  current_date = now.getDate() + "/"  + (parseInt(now.getMonth())+1)  + "/" + now.getFullYear()
  $("[data-behaviour~=no-future-datetimepicker]").each (index, obj) ->
    $(obj).datetimepicker
      format: "dd/mm/yyyy"
      minView: 2 # This will provice only date . Remove if you want date and time
      autoclose: 1
      endDate: current_date
      startDate: $(obj).attr('data-start-date')

  $('select:not(.dataTables_length select)').multiselect
    enableFiltering: true
    includeSelectAllOption: true
    buttonWidth: 'auto'
    enableCaseInsensitiveFiltering: true
    onChange: (element) ->
      if element != undefined
        $("##{element.parents('select').attr('id')}").valid()

  # This methods will be applied on the jquery validations
  $("form.validate-form").validate
    ignore: ".ignore"

  #Kaushal Kishor Sharam
  #Show error message in multiple line with UL tag
  $('.help-block').each ->
    message = '<ul>'
    $.each $(this).text().split(','), (index, value) ->
      message = message + "<li>#{value}</li>"
    message = message + '</ul>'
    $(this).html(message)

  setFileBrowseView()
$(document).ready ready
$(document).on "page:load", ready




