$(document).ready(function() {
  $('#webpage_request_url').keydown(function(event) {
    if (event.keyCode == 13) {
      $('#webpage_request_url').trigger('blur');    
      $('#submit_url').click();
    }
  });

  $('#webpage_request_url').blur(function() {
    var request_url = $(this).val();

    var uri = new URI(request_url);
    if (uri.protocol() == "") {
      // Default to http if a protocol is not present
      uri.protocol("http");

      // Create a new URI object so that all normalizations get applied in one go
      request_url = uri.normalize().toString();
      uri = new URI(request_url);
    }

    request_url = uri.normalize().toString();
    $(this).val(request_url);
  });
});

$(function () {
  $('#navTabs a:first').tab('show');
})
