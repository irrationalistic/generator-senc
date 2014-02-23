mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

SALT_WORK_FACTOR = 10

userSchema = mongoose.Schema
  username:
    type: String
    required: true
    unique: true
  email:
    type: String
    required: true
    unique: true
  password:
    type: String
    required: true

userSchema.pre 'save', (next)->
  user = @
  if(!user.isModified('password'))
    return next()
  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt)->
    if(err)
      return next(err)
    bcrypt.hash user.password, salt, (err, hash)->
      if(err)
        return next(err)
      user.password = hash
      next()

userSchema.methods.comparePassword = (candidatePassword, cb)->
  bcrypt.compare candidatePassword, @password, (err, isMatch)->
    if(err)
      return cb(err)
    cb(null, isMatch)

module.exports = User = mongoose.model 'User', userSchema