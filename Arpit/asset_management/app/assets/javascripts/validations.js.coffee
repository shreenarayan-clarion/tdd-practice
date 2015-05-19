$(document).ready ->

  $.validator.addMethod "validName", ((value, element) ->
    @optional(element) or /^[a-zA-Z0-9\s]+$/.test value
    ), "Please enter a valid name"

  $.validator.addMethod "validDescription", ((value, element) ->
    @optional(element) or /^[a-zA-Z0-9\s,.]+$/.test value
    ), "Please enter a valid description"

  $.validator.addMethod "deviceName", ((value, element) ->
    /^[a-zA-Z0-9-]+$/.test value
    ), "Please enter valid  Asset Name"

  $.validator.addMethod "dateFormat", ((value, element) ->
    @optional(element) or /^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/.test value
    ), "Please enter a valid date"
  $.validator.addMethod "month", ((value, element) ->
    @optional(element) or  (value >= 0 and value <=11)
    ), "Please enter a valid month"

  $.validator.addMethod "phoneNumber", ((value, element) ->
    @optional(element) or /^[0-9\-]+$/.test value
    ), "Please enter a valid number"
  $.validator.addMethod "RealNumber", ((value, element) ->
    @optional(element) or /^[0-9]+$/.test value
    ), "Please enter a positive value"
  $.validator.addMethod "employeeName", ((value, element) ->
    $("#device_status").val()=='assigned' and value != ''
    ), "This field is required."
  $.validator.addMethod "validateMaxDevice", ((value, element) ->
    if parseInt($("#size").val()) > 10
      return false
    ), "This field is required."
  $.validator.addMethod "validateWarrentyDevice", ((value, element) ->
    if $("#device_lifetime_warranty:checked").length == 1  && value == ''
      return false
    ), "This field is required."

  #Kaushal Kishor Sharma
  #custom method to check unique name with multiple fields
  $.validator.addMethod "uniqeName", ((value, element) ->
    values = $("[data-rule-uniqename=#{$(element).attr('data-rule-uniqename')}]:visible").map((v, e) ->
      if (element.id != e.id && @value != '')
        @value.trim()
    ).get()
    return !(values.length > 0 && $.inArray(value.trim(), values) >= 0 && value != '')
    ), "This field is is already taken."


  jQuery.validator.addMethod "uniqueSerial", ((value, element) ->
    value = value.trim()
    response = undefined
    values = []
    id = ''
    if $("#id").length
      id = $("#id").val()
    result = true
    i = 0
    $("input:text[id*='serial_number']").each ->
      if element.id != this.id
        values.push($(this).val().trim())
    sorted_arr = values.sort() # You can define the comparing function here.
    # JS by default uses a crappy string compare.
    console.log(id)
    while i < sorted_arr.length
      result = false  if sorted_arr[i] is value #sorted_arr[i]
      i++
    if result
      $.ajax(
        type: "POST"
        url: '/devices/check_serial_uniqueness'
        data: "serial_number=" + value + '&id=' + id
        async: false
      ).done (data) ->
        response = data
        # console.log data
        $(this).addClass "done"
        return
      if response is "0"
        true
      else if response is "1"
        false
      else false
    else false
  ), "Serial number is already taken"

