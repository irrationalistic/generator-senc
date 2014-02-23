passport = require 'passport'
express = require 'express'
LocalStrategy = require('passport-local').Strategy
User = require './../models/user'

module.exports = (app)->
  passport.serializeUser (user, done)->
    done null, user.id
  passport.deserializeUser (id, done)->
    User.findById id, (err, user)->
      done err, user

  passport.use new LocalStrategy (username, password, done)->
    User.findOne {username: username}, (err, user)->
      return done(err) if err

      if(!user)
        return done(null, false, {message: 'Incorrect username.'})

      user.comparePassword password, (err, isMatch)->
        return done(err) if err
        return done(null, user) if isMatch
        return done(null, false, {message:'Incorrect password.'})