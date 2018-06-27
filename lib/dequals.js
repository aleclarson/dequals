// Generated by CoffeeScript 2.3.0
var OBJECT, arrayEquals, comparators, dateEquals, dequals, errorEquals, isPlainObject, mapEquals, objectEquals, regexpEquals, setEquals, toString, types;

OBJECT = 'object';

dequals = function(a, b) {
  var at;
  if (a === b || (a !== a && b !== b)) {
    return true;
  }
  if (!a || typeof a !== OBJECT) {
    return false;
  }
  if (at = types[toString.call(a)]) {
    if (at === OBJECT) {
      if (!isPlainObject(a)) {
        return a === b;
      }
      if (!isPlainObject(b)) {
        return false;
      }
    }
    if (at === types[toString.call(b)]) {
      return comparators[at](a, b);
    }
  }
  return false;
};

module.exports = dequals;


// Internal

toString = Object.prototype.toString;

isPlainObject = function(value) {
  var ref;
  return !((ref = value.__proto__) != null ? ref.__proto__ : void 0);
};

types = {};

['Array', 'Date', 'Error', 'Map', 'Object', 'RegExp', 'Set'].forEach(function(type) {
  types[`[object ${type}]`] = type.toLowerCase();
});

// compare arguments to arrays
types['[object Arguments]'] = 'array';

arrayEquals = function(a, b) {
  var i, len;
  len = a.length;
  if (len !== b.length) {
    return false;
  }
  i = -1;
  while (++i < a.length) {
    if (!dequals(a[i], b[i])) {
      return false;
    }
  }
  return true;
};

dateEquals = function(a, b) {
  return +a === +b;
};

errorEquals = function(a, b) {
  return a.name === b.name && a.message === b.message;
};

mapEquals = function(a, b) {
  var ak, av, x;
  if (a.size !== b.size) {
    return false;
  }
  for (x of a) {
    [ak, av] = x;
    if (!dequals(b.get(ak), av)) {
      return false;
    }
  }
  return true;
};

objectEquals = function(a, b) {
  var ak, bk, i, len;
  ak = Object.keys(a);
  bk = Object.keys(b);
  len = ak.length;
  if (len !== bk.length) {
    return false;
  }
  i = -1;
  while (++i < len) {
    if (0 > ak.indexOf(bk[i])) {
      return false;
    }
  }
  i = -1;
  while (++i < len) {
    if (!dequals(a[ak[i]], b[ak[i]])) {
      return false;
    }
  }
  return true;
};

regexpEquals = function(a, b) {
  return a.toString() === b.toString();
};

setEquals = function(a, b) {
  var av;
  if (a.size !== b.size) {
    return false;
  }
  for (av of a) {
    if (!b.has(av)) {
      return false;
    }
  }
  return true;
};

comparators = {
  array: arrayEquals,
  arguments: arrayEquals,
  date: dateEquals,
  error: errorEquals,
  map: mapEquals,
  object: objectEquals,
  regexp: regexpEquals,
  set: setEquals
};