OBJECT = 'object'

dequals = (a, b) ->
  return true if a == b or (a != a and b != b)
  return false if !a or typeof a != OBJECT
  if at = types[toString.call a]
    if at == OBJECT
      return a == b if !isPlainObject a
      return false if !isPlainObject b
    if at == types[toString.call b]
      return comparators[at] a, b
  return false

module.exports = dequals

#
# Internal
#

toString = Object::toString

isPlainObject = (value) ->
  !value.__proto__?.__proto__

types = {}
['Array', 'Date', 'Error', 'Map', 'Object', 'RegExp', 'Set'
].forEach (type) ->
  types["[object #{type}]"] = type.toLowerCase()
  return

# compare arguments to arrays
types['[object Arguments]'] = 'array'

arrayEquals = (a, b) ->
  len = a.length
  if len != b.length
    return false
  i = -1
  while ++i < a.length
    if !dequals a[i], b[i]
      return false
  return true

dateEquals = (a, b) ->
  +a == +b

errorEquals = (a, b) ->
  a.name == b.name and a.message == b.message

mapEquals = (a, b) ->
  if a.size != b.size
    return false
  for [ak, av] from a
    return false if !dequals b.get(ak), av
  return true

objectEquals = (a, b) ->
  ak = Object.keys a
  bk = Object.keys b
  len = ak.length
  if len != bk.length
    return false
  i = -1
  while ++i < len
    return false if 0 > ak.indexOf bk[i]
  i = -1
  while ++i < len
    return false if !dequals a[ak[i]], b[ak[i]]
  return true

regexpEquals = (a, b) ->
  a.toString() == b.toString()

setEquals = (a, b) ->
  if a.size != b.size
    return false
  for av from a
    return false if !b.has av
  return true

comparators =
  array: arrayEquals
  arguments: arrayEquals
  date: dateEquals
  error: errorEquals
  map: mapEquals
  object: objectEquals
  regexp: regexpEquals
  set: setEquals
