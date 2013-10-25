$(document).ready ->
  toggle_submit = ->
    if /\w+\.[a-z]{2,}/i.test($('#webpage_request_url').val())
      $('#submit_url').attr('disabled', false)
    else
      $('#submit_url').attr('disabled', true)

  toggle_submit()
  $('#webpage_request_url').keyup (event) ->
    toggle_submit()

  $('#webpage_request_url').keydown (event) ->
    if event.keyCode is 13
      $('#webpage_request_url').trigger 'blur'
      $('#submit_url').click()

  $('#webpage_request_url').blur ->
    request_url = @value
    return false if request_url is ''
    uri = new URI(request_url)
    if uri.protocol() is ''
      # Default to http if a protocol is not present
      uri.protocol 'http'
      
      # Create a new URI object so that all normalizations get applied in one go
      request_url = uri.normalize().toString()
      uri = new URI(request_url)
    request_url = uri.normalize().toString()
    @value = request_url

  $('#submit_url').click ->
    return false if $('#webpage_request_url').val() is ''
    Recaptcha.reload() if Recaptcha?

  $('#recaptcha_challenge_field').keydown (event) ->
    submit() if event.keyCode is 13

$ ->
  $('#navTabs a:first').tab 'show'
