{test} = require 'testpass'

eq = require '..'

all = (t, arr) ->
  for val, i in arr
    if val isnt true
      t.fail "Case #{i} failed with: #{val}"
  return

test 'arrays', (t) ->
  all t, [
    eq [], [] # empty array
    eq [1], [1]
    eq [[1]], [[1]] # nested array
    !eq [], [1]
    !eq [1], [2]
    !eq [[1]], [[2]]
    !eq [1, 2], [2, 1] # same values, different order
  ]

test 'objects', (t) ->
  all t, [
    eq {}, {}
    eq {}, Object.create(null)
    eq Object.create(null), Object.create(null)
    eq {a: 1}, {a: 1}
    !eq {a: 1}, {a: 2}
    !eq {a: 1}, {b: 1}
    !eq {}, {a: 1}
    !eq {}, []
  ]

test 'class instances', (t) ->
  Foo = ->
  all t, [
    !eq new Foo(), {}
    !eq new Foo(), new Foo()
  ]

test 'Set objects', (t) ->
  all t, [
    eq new Set(), new Set()
    eq new Set([1]), new Set([1])
    eq new Set([1, 2]), new Set([2, 1])
    !eq new Set(), new Set([1])
    !eq new Set([1]), new Set([2])
  ]

test 'Map objects', (t) ->
  all t, [
    eq new Map(), new Map()
    eq new Map([[1, 2]]), new Map([[1, 2]])
    !eq new Map(), new Map([[1, 2]])
    !eq new Map([[1, 2]]), new Map([[1, 2], [3, 4]])
  ]

test 'Date objects', (t) ->
  all t, [
    eq new Date(), new Date()
    !eq new Date(1), new Date(2)
    !eq new Date(), Date.now()
  ]

test 'Error objects', (t) ->
  all t, [
    eq new Error(), new Error()
    eq new Error('foo'), new Error('foo')
    !eq new Error('foo'), new Error('bar')
    !eq new Error('foo'), new TypeError('foo')
  ]

test 'RegExp objects', (t) ->
  all t, [
    eq /./, /./
    !eq /./, /./g
    !eq /./, /.+/
  ]

test 'Arguments objects', (t) ->
  args = -> arguments
  all t, [
    eq args(), args()
    eq args(1, 2), args(1, 2)
    eq args(), []
    eq args(1, 2), [1, 2]
    !eq args(), args(1)
    !eq args(1, 2), args(2, 1)
  ]

test 'NaN == NaN', (t) ->
  t.eq eq(NaN, NaN), true

test '-0 == +0', (t) ->
  t.eq eq(-0, +0), true
