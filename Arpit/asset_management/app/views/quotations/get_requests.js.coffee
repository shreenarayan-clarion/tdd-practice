$("#quotations").html "<%= j render(:partial => '/quotations/quotation_form') %>"
$("[data-behaviour~=no-future-datetimepicker]").datetimepicker  "setStartDate", "<%= @device_request.on_date.to_s %>"

$("#quotations").removeClass("hide")

$(".input_tooltip").tooltip placement: "bottom"

$('select:not(.dataTables_length select)').multiselect("rebuild")
