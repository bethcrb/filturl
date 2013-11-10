toggle_submit = ->
  if /\w+\.[a-z]{2,}/i.test($('#webpage_request_url').val())
    $('#submit_url').attr('disabled', false)
    $('#submit_url').removeClass('btn-default').addClass('btn-primary')
  else
    $('#submit_url').attr('disabled', true)
    $('#submit_url').removeClass('btn-primary').addClass('btn-default')

initEvents = ->
  toggle_submit()

  propertyChangeUnbound = false # This is to support IE < 9
  $('#webpage_request_url').on 'propertychange', (event) ->
    toggle_submit() if event.originalEvent.propertyName is 'value'

  # Toggle submit button based on valid input
  $('#webpage_request_url').on 'input', ->
    unless propertyChangeUnbound
      $('#webpage_request_url').unbind 'propertychange'
      propertyChangeUnbound = true
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

$(document).on 'page:change', ->
  initEvents()

$(document).ready ->
  initEvents()

