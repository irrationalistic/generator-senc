flash = require 'connect-flash'
express = require 'express'
path = require 'path'
config = require './config'
<% if(authentication) { %>passport = require 'passport'<% } %>

module.exports = (app)->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', path.join(__dirname, '../views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  if config.env is 'development'
    app.use express.logger('dev')
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session({ secret: 'super secret string' })
  app.use flash()

  if config.env is 'development'
    app.use express.errorHandler()
  <% if(authentication) { %>  
  # SET UP PASSPORT
  app.use(passport.initialize())
  app.use(passport.session())
  require('../config/passport')(app)
  <% } %>
  # SET UP STATIC FILES
  app.use express.compress {threshold:0}
  app.use '/public', express.static(path.join(__dirname, '../../assets/public'))
  app.use '/common', express.static(path.join(__dirname, '../../assets/common'))
  app.use '/bower_components', express.static(path.join(__dirname, '../../../bower_components'))
  <% if(authentication) { %> 
  app.use (req,res,next)->
    if req.url.match(/^\/private\//)
      return next() if req.isAuthenticated()
      res.send 401
    else
      next()
  app.use '/private', express.static(path.join(__dirname, '../../assets/private'))
  <% } %>
  # USE THE APP ROUTER
  app.use app.router
  require('../config/routes')(app)