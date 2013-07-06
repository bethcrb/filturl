$(document).ready(function() {
  $("input#webpage_url").blur(function() {
    var input = $(this);
    var val = input.val();
    if (val && !val.match(/^http([s]?):\/\/.*/)) {
        input.val('http://' + val);
    }
  });
});
