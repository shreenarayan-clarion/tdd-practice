# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->

  checkbox = document.getElementById("software_product_license")
  license_no = document.getElementById("license_no")
  
  if checkbox != null
    if checkbox.checked
      license_no.style["display"] = "block"
    else
      license_no.style["display"] = "none"

    checkbox.onclick = ->
      if @checked
        license_no.style["display"] = "block"
      else
        license_no.style["display"] = "none"
        document.getElementById('software_product_license_no').value = ""
        
        
    

 
