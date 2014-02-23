module.exports =
  dev:
    script: './<%%= config.dist %>/server.js'
    options:
      watch: ['dist/app']
      callback: (nodemon)->
        nodemon.on 'config:update', ()->  
          setTimeout ()->
            require('open')('http://localhost:3000');
          , 1000
