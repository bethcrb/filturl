toggleSubmit = ->
  if /\w+\.[a-z]{2,}/i.test($('#webpage_request_url').val())
    $('#submit_url').attr('disabled', false)
    $('#submit_url').removeClass('btn-default').addClass('btn-primary')
  else
    $('#submit_url').attr('disabled', true)
    $('#submit_url').removeClass('btn-primary').addClass('btn-default')

initEvents = ->
  toggleSubmit()

  propertyChangeUnbound = false # This is to support IE < 9
  $('#webpage_request_url').on 'propertychange', (event) ->
    toggleSubmit() if event.originalEvent.propertyName is 'value'

  # Toggle submit button based on valid input
  $('#webpage_request_url').on 'input', ->
    unless propertyChangeUnbound
      $('#webpage_request_url').unbind 'propertychange'
      propertyChangeUnbound = true
    toggleSubmit()

  $('#webpage_request_url').keydown (event) ->
    if event.keyCode is 13
      $('#webpage_request_url').trigger 'blur'
      $('#new_webpage_request').submit()

  $('#webpage_request_url').blur ->
    webpageRequest = new WebpageRequest(@value)
    @value = webpageRequest.url

  $('#new_webpage_request').submit ->
    $('#webpage_request_url').attr('readonly', true)
    $('#submit_url').attr('disabled', true)
    $('#submit_url').removeClass('btn-primary').addClass('btn-default')

$(document).on 'page:change', ->
  initEvents()

$(document).ready ->
  initEvents()

