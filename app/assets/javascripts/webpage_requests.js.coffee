$(document).ready ->
  toggle_submit = ->
    if $("#webpage_request_url").val() == ""
      $("#submit_url").attr("disabled", true);
    else
      $("#submit_url").attr("disabled", false)

  toggle_submit()
  $("#webpage_request_url").keyup (event) ->
    toggle_submit()

  $("#webpage_request_url").keydown (event) ->
    if event.keyCode is 13
      $("#webpage_request_url").trigger "blur"
      $("#submit_url").click()

  $("#webpage_request_url").blur ->
    request_url = @value
    if request_url == ""
      return false
    uri = new URI(request_url)
    if uri.protocol() is ""
      
      # Default to http if a protocol is not present
      uri.protocol "http"
      
      # Create a new URI object so that all normalizations get applied in one go
      request_url = uri.normalize().toString()
      uri = new URI(request_url)
    request_url = uri.normalize().toString()
    @value = request_url

  $("#submit_url").click ->
    if $("#webpage_request_url").val() == ""
      return false
    Recaptcha.reload()

  $("#recaptcha_challenge_field").keydown (event) ->
    if event.keyCode is 13
      submit()
$ ->
  $("#navTabs a:first").tab "show"
