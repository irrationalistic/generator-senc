express = require 'express'
http = require 'http'
path = require 'path'

# Disable console on production
console.log = if global.process.env.NODE_ENV? and global.process.env.NODE_ENV is 'production' then () -> else console.log

app = module.exports = express()

# CONNECT AND SEED DATABASE
require('./config/mongoose')(app)

# INITIALIZE EXPRESS
require('./config/express')(app)

# START SERVER
port = app.get 'port'

http.createServer(app).listen port, () ->
    console.log "Express server listening on port #{port}"