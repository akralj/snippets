_toConsumableArray = (arr) ->
  if Array.isArray(arr)
    i = 0
    arr2 = Array(arr.length)
    while i < arr.length
      arr2[i] = arr[i]
      i++
    arr2
  else
    Array.from arr

findMissingNumbers = (arr) ->
  # Create sparse array with a 1 at each index equal to a value in the input.
  sparse = arr.reduce(((sparse, i) ->
    sparse[i] = 1
    sparse
  ), [])
  # Create array 0..highest number, and retain only those values for which
  # the sparse array has nothing at that index (and eliminate the 0 value).
  [].concat(_toConsumableArray(sparse.keys())).filter (i) ->
    i and !sparse[i]


module.exports = findMissingNumbers


#test
###
someArr = [2,5,3,1,4,7,10,15]
result = findMissingNumbers(someArr)
console.log result
###