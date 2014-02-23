mongoose = require 'mongoose'

<%= modelLower %>Schema = mongoose.Schema
  prop:
    type: String
    required: true

module.exports = <%= modelUpper %> = mongoose.model '<%= modelUpper %>', <%= modelLower %>Schema