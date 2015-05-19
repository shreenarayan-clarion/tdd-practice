# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '.remove_nested_fields', ->
  $(this).prev().val(true)
  $(this).parents('.row').addClass('hide').find('.form-control').addClass('ignore')
  if $(".nested-remove:visible").length == 1
    $(".remove_nested_fields").parent().addClass('hide')
  if $("#size")
    nested_id = $(this).attr('data-association')
    $("#size").val($("##{nested_id} .nested_div:visible").size())
    if $("#size").val() < 10
      $('.add_nested_fields').show().removeAttr('disabled')
    if $("#size").val() == "1"
      $('#remove-device').attr('disabled','disabled')
      $('.add_nested_fields').removeAttr('disabled')
$(document).on 'click', '.add_nested_fields', ->
  if $(".nested-add:visible").length > 0
    $(".remove_nested_fields").parent().removeClass('hide')
  if $("#size")
    nested_id = $(this).attr('data-target')
    $("#size").val($("#{nested_id} .nested_div:visible").size())
    if $("#size").val() > 9
      $('.add_nested_fields').attr('disabled','disabled')
    if $("#size").val() > 1
      $('#remove-device').removeAttr('disabled')