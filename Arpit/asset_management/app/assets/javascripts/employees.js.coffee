ready = undefined
ready = ->

  # Date Pickers
  # ---  This variabled will be called on the edit form of employee
  # where employee join date will restrict the employee resign date with format
  close_date_resign = []
  resign_close_date = ""
  main_date = ""
  if ($("#employee_join_date").val())
    close_date_resign = $("#employee_join_date").val().split("/")
    resign_close_date =  new Date(close_date_resign[1] + "-" + close_date_resign[0] + "-" + close_date_resign[2])
    main_date = resign_close_date.getDate() + "/"  + (parseInt(resign_close_date.getMonth())+1)  + "/" + resign_close_date.getFullYear()
  now = new Date()
  + now.getFullYear()
  # ---  
  # This are the employee join date picker options
  joinDatePickerOption =
    format: "dd/mm/yyyy"
    minView: 2 # This will provice only date . Remove if you want date and time
    autoclose: 1
  # This are the employee resign date picker options
  resignDatePickerOption =
    format: "dd/mm/yyyy"
    startDate: main_date
    minView: 2 # This will provice only date . Remove if you want date and time
    autoclose: 1
  
  # This methods will initiate the datepicker and  are applied when employee change the join date and resign date
  datePicker1 = $("#employee_join_date").datetimepicker(joinDatePickerOption).on("changeDate", (e) ->
    datePicker2.datetimepicker "setStartDate", e.date
    datePicker2.datetimepicker "update"
    return
  )
  
  # In this case employee can not enter resign date less then join date and videversa
  datePicker2 = $("#employee_resign_date").datetimepicker(resignDatePickerOption).on("changeDate", (e) ->
    datePicker1.datetimepicker "setEndDate", e.date
    datePicker1.datetimepicker "update"
    return
  )

# This method is initialisation method to solve turbo link issu . This will call even after turbo link been called
$(document).ready ready
$(document).on "page:load", ready