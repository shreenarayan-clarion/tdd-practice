$('#purchase_order').html("<%= j render(:partial => '/invoices/form') %>");
$(".input_tooltip").tooltip placement: "bottom"
$('select:not(.dataTables_length select)').multiselect
  enableFiltering: true
  includeSelectAllOption: true
  buttonWidth: 'auto'
  enableCaseInsensitiveFiltering: true
  onChange: (element) ->
    if element != undefined
      $("##{element.parent().attr('id')}").valid()
$("#device_transaction_div").slideDown 500

$("form.validate-form").validate
  ignore: ".ignore"

now = new Date()
current_date = now.getDate() + "/"  + (parseInt(now.getMonth())+1)  + "/" + now.getFullYear()
$("[data-behaviour~=no-future-datetimepicker]").datetimepicker
    format: "dd/mm/yyyy"
    minView: 2 # This will provide only date . Remove if you want date and time
    autoclose: 1
    startDate: "<%= @purchase_order.on_date.to_s %>"
    endDate: current_date

$("#date-upload-div").removeClass('hide');
setFileBrowseView()