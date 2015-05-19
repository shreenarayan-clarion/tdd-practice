// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap3
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery_nested_form
//= require bootstrap-multiselect
//= require_tree .


function setFileBrowseView(){
  var file_html='<div class="input-group"><span class="input-group-btn" id="file-browse"><span class="btn btn-primary btn-file">Browse… </span></span></div>'
  $("[type~=file]").wrap(file_html);
  $("#file-browse").after('<input type="text" class="form-control" id="file-input"readonly="" style="width:80%"><a href="javascript:void(0)" class="glyphicon glyphicon-refresh" style="top:12px;margin-left:5%" id="remove_file-value" ></a>');
  $("[type~=file]").on("change", function() {
    return $("#file-input").val($(this).val());
  });
  $("#remove_file-value").on("click",function(){
    $("[type~=file],#file-input").val('')
  });

}