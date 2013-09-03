$(document).ready ->
  $("#webpage_request_url").keydown (event) ->
    if event.keyCode is 13
      $("#webpage_request_url").trigger "blur"
      $("#submit_url").click()

  $("#webpage_request_url").blur ->
    request_url = $(this).val()
    uri = new URI(request_url)
    if uri.protocol() is ""
      
      # Default to http if a protocol is not present
      uri.protocol "http"
      
      # Create a new URI object so that all normalizations get applied in one go
      request_url = uri.normalize().toString()
      uri = new URI(request_url)
    request_url = uri.normalize().toString()
    $(this).val request_url

  $("#submit_url").click ->
    Recaptcha.reload()


$ ->
  $("#navTabs a:first").tab "show"
