passport = require 'passport'

module.exports.logout = (req,res)->
  req.logout()
  res.redirect '/'

module.exports.loginPost = (req,res,next)->
  passport.authenticate('local', (err, user, info)->
    return next(err) if err
    if not user
      req.session.messages = [info.message]
      return res.redirect '/admin/login'
    req.logIn user, (err)->
      return next(err) if err
      return res.redirect '/admin'
  )(req,res,next)

module.exports.index = (req,res)->
  res.render 'private/index',
    title: 'Admin'
    assetPath: 'private'