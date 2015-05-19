$('#purchase_div').html("<%= j render(partial: 'purchase_orders/form') %>")
$('#device_transactions').removeClass("hide")
$("#device_transactions").slideDown 2500
$("form.validate-form").validate
  ignore: ".ignore"
$(".input_tooltip").tooltip placement: "bottom"
$("#loading_div").addClass("hide")

$('select:not(.dataTables_length select)').multiselect
  enableFiltering: true
  includeSelectAllOption: true
  buttonWidth: 'auto'
  enableCaseInsensitiveFiltering: true
  onChange: (element) ->
    if element != undefined
      $("##{element.parent().attr('id')}").valid()

<%- on_date = @quotation.present? ? @quotation.on_date.to_s : "" %>
now = new Date()
current_date = now.getDate() + "/"  + (parseInt(now.getMonth())+1)  + "/" + now.getFullYear()

$("[data-behaviour~=no-future-datetimepicker]").datetimepicker
  format: "dd/mm/yyyy"
  minView: 2 # This will provide only date . Remove if you want date and time
  autoclose: 1
  startDate: "<%= on_date %>"
  endDate: current_date
$("#date-upload-div").removeClass('hide'); 
setFileBrowseView()