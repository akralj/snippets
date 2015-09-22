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
request = (opts, next) ->
  if opts.responseType is 'json' or opts.responseType is 'blob'
    xhr {
      url: opts.url
      responseType: opts.responseType
    }, (err, res) ->
      if err
        next err
      else if res?.statusCode isnt 200
        next error: res.statusCode
      else
        next null, res.body
  else
    next throw new Error('please specify either json or blob as responseType')

url = '/api.jso'
request {url: url, responseType: 'json'}, (err,res) -> console.log err,res
url = 'http://a.tile.openstreetmap.org/10/551/357.png'
request {url: url, responseType: 'blob'}, (err,res) -> console.log err,res
