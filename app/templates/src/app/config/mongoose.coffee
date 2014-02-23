mongoose = require 'mongoose'
config = require './config'

module.exports = (app)->
  mongoose.connect config.dbURI
  db = mongoose.connection
  db.on 'error', console.error.bind(console, 'connection error')

  # Seed the database on the dev environment
  if config.env is 'development'
    require('fs').exists '../models/seeds/', (exists)->
      if exists
        db.once 'open', ()->
          seedPath = require('path').join(__dirname, '../models/seeds/')
          require("fs").readdirSync(seedPath).forEach (file)->
            require(seedPath + file)()