User = require '../user'

userList = [
  {username: 'test', password: 'test', email: 'test@test.test'}
]

module.exports = ()->
  new User(user).save() for user in userList