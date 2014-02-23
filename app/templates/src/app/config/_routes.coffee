express = require 'express'
routesIndex = require './../routes/'
routesApi = require './../routes/api'
<% if(authentication){%>routesAdmin = require './../routes/admin'
passport = require 'passport'
<%}%>
module.exports = (app)->
  <% if(authentication){%># LOGIN/OUT
  app.get '/admin/login', routesIndex.login
  app.post '/admin/login', routesAdmin.loginPost
  app.get '/admin/logout', routesAdmin.logout

  # ADMIN PAGES
  app.get '/admin', ensureAuthenticated, routesAdmin.index
  <%}%>
  # API
  app.get '/api', routesApi.index

  # INDEX
  app.get '/', routesIndex.index
<% if(authentication){%>
ensureAuthenticated = (req, res, next)->
  return next() if req.isAuthenticated()
  res.redirect '/admin/login'
ensureAuthenticatedCode = (req, res, next)->
  return next() if req.isAuthenticated()
  res.send 401
<%}%>