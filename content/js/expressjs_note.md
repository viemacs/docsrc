---
weight: 20
title: JS
---

## Note on Express Basic

### Routing

A route method is derived from one of the HTTP methods, and is attached to an instance of the express class.

#### Route methods
Express supports the following routing methods that correspond to HTTP methods:
`get, post, put, head, delete, options, trace, copy, lock, mkcol, move, purge, propfind, proppatch, unlock, report, mkactivity, checkout, merge, m-search, notify, subscribe, unsubscribe, patch, search, and connect`.

To route methods that translate to invalid JavaScript variable names, use the bracket notation. 
```app['m-search']('/', function(){})```

An extra routing method `app.all()` is used for loading middleware functions at a path for all request methods.

```
app.get('/', function(req, res) {
})
app.post('/', function(req, res) {
})
app.all('/', function(req, res, next) {
    ;
    next()
})
```

#### Route paths
Route path supports string, string pattern with *? + * ()*, and regular expression. 
In string, hyphen and dot are literal characters.
```
app.get('/ab*c(de)?f', function(req, res) {})
app.get(/.*foo$/, function(req, res) {})
```

**Route parameters**

Express captures named URL segments into *req.params* object.
> The name of route parameters must be made up of “word characters” ([A-Za-z0-9_]).

```
Route path: /users/:userId/books/:bookId
Request URL: http://localhost:3000/users/34/books/8989
req.params: { "userId": "34", "bookId": "8989" }

Route path: /flights/:from-:to
Request URL: http://localhost:3000/flights/LAX-SFO
req.params: { "from": "LAX", "to": "SFO" }

Route path: /plantae/:genus.:species
Request URL: http://localhost:3000/plantae/Prunus.persica
req.params: { "genus": "Prunus", "species": "persica" }
```

#### Route handlers
Route handlers are used to handle a request, and they're chained by `next()`.
You can use functions, and arrays of functions, and their mix.

```
var cb0 = function (req, res, next) {
  console.log('CB0')
  next()
}

var cb1 = function (req, res, next) {
  console.log('CB1')
  next()
}

app.get('/example', [cb0, cb1], function (req, res, next) {
  console.log('the response will be sent by the next function ...')
  next()
}, function (req, res) {
  res.send('Hello from D!')
})
```

#### Response methods
A response method sends a response to the client, and terminates the request-response cycle.
If no response method is called, the client request will be left hanging.

```
- **Method**    **Description**
- res.download()    Prompt a file to be downloaded.
- res.end()         End the response process.
- res.json()        Send a JSON response.
- res.jsonp()       Send a JSON response with JSONP support.
- res.redirect()    Redirect a request.
- res.render()      Render a view template.
- res.send()        Send a response of various types.
- res.sendFile()    Send a file as an octet stream.
- res.sendStatus()  Set the response status code and send its string representation as the response body.
```

#### app.route()
It creates a handler-chain for a given route path.
```
app.route('/book')
  .get(function (req, res) {
    res.send('Get a random book')
  })
  .post(function (req, res) {
    res.send('Add a book')
  })
  .put(function (req, res) {
    res.send('Update the book')
  })
```

#### express.Router
Use the express.Router class to create modular, mountable route handlers. A Router instance is a complete middleware and routing system; for this reason, it is often referred to as a “mini-app”.

The following example creates a router as a module, loads a middleware function in it, defines some routes, and mounts the router module on a path in the main app.

Create a router file named birds.js in the app directory, with the following content:

```
var express = require('express')
var router = express.Router()

// middleware that is specific to this router
router.use(function timeLog (req, res, next) {
  console.log('Time: ', Date.now())
  next()
})
// define the home page route
router.get('/', function (req, res) {
  res.send('Birds home page')
})
// define the about route
router.get('/about', function (req, res) {
  res.send('About birds')
})

module.exports = router
```

Then, load the router module in the app:

```
var birds = require('./birds')

// ...

app.use('/birds', birds)
```
The app will now be able to handle requests to /birds and /birds/about, as well as call the timeLog middleware function that is specific to the route.

****
