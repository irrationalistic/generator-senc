<%= modelUpper %> = require '../<%= modelLower %>'

<%= modelLower %>List = [
  {prop: 'test'}
]

module.exports = ()->
  new <%= modelUpper %>(<%= modelLower %>).save() for <%= modelLower %> in <%= modelLower %>List