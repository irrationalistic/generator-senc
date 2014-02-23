module.exports.index = (req, res)->
  res.render 'public/index',
    title: '<%= packageName %>'
    assetPath: 'public'
<% if(authentication){%>
module.exports.login = (req, res)->
  res.render 'public/login',
    title: 'Login'
    assetPath: 'public'
<%}%>