# dequals v1.0.0

Deep equality test

- object property order is *not* validated
- array element order *is* validated
- `Set` and `Map` objects are validated
- `Arguments` objects are treated as arrays
- `Error` objects are treated as strings
- `RegExp` objects are validated
- `Date` objects are validated
- `NaN` values are always equal
- boxed primitives are *not* unboxed

```
npm install dequals
```

