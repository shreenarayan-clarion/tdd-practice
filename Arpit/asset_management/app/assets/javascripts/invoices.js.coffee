# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
	$("#purchase_order").delegate "#purchase_order_invoice_attributes_purchase_order_id", "change", (e) ->
		$("#purchase_order_invoice_attributes_purchase_on_date").next().html('')
		$("#purchase_order_invoice_attributes_purchase_on_date").val('')
		id = $(this).val()
		$("#loading_div").removeClass("hide")
		if id.length > 0
			$.ajax "/invoices/new?purchase_order_id=#{id}",
				type: 'GET'
				dataType: 'script'
				error: (jqXHR, textStatus, errorThrown) ->
					$('body').append "AJAX Error: #{textStatus}"
				success: (data, textStatus, jqXHR) ->
					$("#loading_div").addClass("hide")
		else
			$("#loading_div").addClass("hide")
			$('#device_transaction_div').html('')
