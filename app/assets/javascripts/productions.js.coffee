# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
selectChain = [];

jQuery ->
  bindAjaxOption('#add-resume',     '#resume_roles_attributes_0_production_id','#add-production')
  bindAjaxOption('#add-production', '#production_company_id', '#add-company')
  bindAjaxOption('#add-production', '#production_shows_attributes_0_venue_id', '#add-venue')


# Enable adding an option on-the-fly to a select
# PARAMS:
#   origin_form_selector: containing form
#   select_selector:      select to be extended
#   create_form_selector  form for the type of entoty listed on the select.

bindAjaxOption = (origin_form_selector, select_selector, create_form_selector) ->
  $(select_selector.concat(' + .extend-list')).click (e) ->
    e.preventDefault()
    $(origin_form_selector).hide()
    $(create_form_selector).show()
    selectChain.push(create_form_selector)

  $(document).bind "ajaxSuccess", create_form_selector, (event, xhr, settings) ->
    console.log("event.data is: " + event.data)
    if event.data == selectChain[selectChain.length-1]
      $entity_form = $(event.data)
      $error_container = $("#error_explanation", $entity_form)
      $error_container_ul = $("ul", $error_container)
      #  $("<p>").html(xhr.responseJSON.title + " saved.").appendTo $entity_form
      if $("li", $error_container_ul).length
        $("li", $error_container_ul).remove()
      $entity_form.hide()
      $(origin_form_selector).show()
      entId = xhr.responseJSON.id
      entName = xhr.responseJSON.name
      $select = $(select_selector, $(origin_form_selector))
      if $select.length
        $select.append(String.concat("<option value=", entId, " selected='selected'>", entName, "</option>"));
        selectChain.pop()

  $(document).bind "ajaxError", create_form_selector, (event, jqxhr, settings, exception) ->
    $entity_form = $(event.data)
    if event.data == selectChain[selectChain.length-1]
      $error_container = $("#error_explanation", $entity_form)
      $error_container_ul = $("ul", $error_container)
      $error_container.show()  if $error_container.is(":hidden")
      if $("li", $error_container_ul).length
        $("li", $error_container_ul).remove()
      $.each jqxhr.responseJSON, (index, message) ->
        $("<li>").html(message).appendTo $error_container_ul