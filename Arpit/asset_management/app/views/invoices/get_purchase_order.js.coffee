$("[data-behaviour~=no-future-datetimepicker]").datetimepicker  "setStartDate", "<%= @purchase_order.on_date.to_s %>"
$('#purchase_order').html("<%= j render(:partial => '/invoices/show_purchase_order') %>");

