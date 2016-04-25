
# custom hook for REST
before:
  find: (hook, next) ->
    # convert numbers & booleans in strings for queries
    query = hook.params.query
    Object.keys(query).forEach (key) ->
      if query[key] is 'true'
        query[key] = true
      else if query[key] is 'false'
        query[key] = false
      else if not _.isNaN(+query[key])
        query[key] = +query[key]
    console.log hook.params.query
