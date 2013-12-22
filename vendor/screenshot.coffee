page = require('webpage').create()
system = require 'system'

if system.args.length < 2
  console.log 'Usage: screenshot.js URL filename'
  phantom.exit 1
else
  address = system.args[1]
  output = system.args[2]
  page.viewportSize = { width: 1024, height: 768 }
  page.open address, (status) ->
    if status isnt 'success'
      console.log 'Unable to load the address!'
      phantom.exit()
    else
      window.setTimeout (-> page.render output; phantom.exit()), 200
