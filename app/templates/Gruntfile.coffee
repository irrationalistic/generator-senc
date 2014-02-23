path = require 'path'

module.exports = (grunt)->
  _ = grunt.util._
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  config = require('./tasks/config.coffee')

  gruntConfig = _.extend {},
    config: config
    availabletasks:
      tasks:
        options:
          sort: false
          filter: 'include'
          tasks: ['dev', 'dist', 'build','test']
          descriptions:
            'dev':    'Development task for watching, compiling, and testing files'
            'dist':   'Build task that compiles and minifies files'
            'build':  'Alias for dist task'
            'test':   'Run client and server tests'
    
    concurrent:
      dev:
        tasks: ['nodemon', 'watch']
        options:
          logConcurrentOutput: true
      distCoffee:
        tasks: [
          'coffee:dist'
          'coffee:server'
          'coffee:test'
        ]
      distStyles:
        tasks: [
          'sass:dist'
        ]
      distOther: [
        'copy'
      ]
  
    watch:
      options:
        livereload: true

      coffeeServer:
        files: [
          '<%%= config.src %>/app/**/*.coffee'
          '<%%= config.src %>/server.coffee'
        ]
        tasks: ['newer:coffee:server', 'jasmine_node']
      coffeeClient:
        files: ['<%%= config.src %>/assets/**/*.coffee']
        tasks: ['newer:coffee:dev', 'jasmine']
      coffeeTestClient:
        files: ['<%%= config.src %>/test/client/**/*.coffee']
        tasks: ['newer:coffee:test', 'jasmine']
        options:
          livereload: false
      coffeeTestServer:
        files: ['<%%= config.src %>/test/server/**/*.coffee']
        tasks: ['newer:coffee:test', 'jasmine_node']
        options:
          livereload: false

      sass:
        files: ['<%%= config.src %>/assets/**/*.{scss,sass}']
        tasks: ['sass:dev']

      preprocess:
        files: ['<%%= config.src %>/app/views/**/*.jade']
        tasks: ['newer:preprocess:dev', 'useminPrepare', 'concat']

      copyJS:
        files: ['<%%= config.src %>/assets/**/*.js']
        tasks: ['newer:copy:js']

      imagemin:
        files: ['<%%= config.src %>/assets/*/images/*']
        tasks: ['newer:imagemin:dist']
  ,
    require('load-grunt-config') grunt,
      configPath: path.join(__dirname, 'tasks/options')
      init: true


  grunt.registerTask 'dev', [
    'clean'
    'coffee:dev', 'coffee:server', 'coffee:test'
    'sass:dev'
    'imagemin:dist', 'copy'
    'preprocess:dev', 'useminPrepare', 'concat'
    'concurrent:dev'
  ]

  grunt.registerTask 'dist', [
    'clean'
    'concurrent:distCoffee', 'concurrent:distStyles', 'concurrent:distOther'
    'preprocess:dist', 'useminPrepare', 'concat'
    'uglify'
    'clean:temp'
    'jasmine', 'jasmine_node'
    'imagemin:dist'
    'clean:test', 'clean:sass'
  ]

  grunt.registerTask 'build', ['dist']

  grunt.registerTask 'test', [
    'clean:test'
    'coffee:test', 'coffee:dev'
    'jasmine', 'jasmine_node'
    'clean:test'
  ]

  grunt.registerTask 'default', 'availabletasks'


  grunt.initConfig(gruntConfig)