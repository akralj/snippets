require('isomorphic-fetch')
checkStatus = (response) ->
  if response.status >= 200 and response.status < 300
    return response
  else
    error = new Error(response.statusText)
    error.response = response
    throw error


fetch('http://localhost:3333/ap.json').then(checkStatus).then((response) -> response.json()).then((data) ->
  console.log 'request succeeded with JSON response', data
).catch (error) -> console.log 'request failed', error


# only works in browser
xhr = require('xhr')
getBase64FromHttp = (url, next) ->
  xhr {
    uri: url
    responseType: 'json'
  }, (err, resp, json) ->
    console.log err, "xhr"
    if resp?.statusCode is 200
      next null, json

    else next {error: 404}

#getBase64FromHttp "http://localhost:3333/api.json",  (err,res) -> console.log err, res