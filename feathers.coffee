
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


# hooks (https://docs.feathersjs.com/hooks/readme.html)
# always wrap in a function so you can pass options and for consistency.
myHook = (options) =>
  (hook) =>
    console.log('My custom hook ran');
    Promise.resolve(hook); # A good convention is to always return a promise.

# Set up our before hook
userService.before({
  all: [] # run hooks for all service methods
  find: [myHook()] # run hook on before a find. You can chain multiple hooks.
})