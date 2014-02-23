module.exports =
    options:
        bare: true
      dev:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: '<%%= config.src %>/assets'
          src: ['**/*.coffee']
          dest: '<%%= config.dist %>/assets'
          ext: '.js'
        ] 
      dist:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: '<%%= config.src %>/assets'
          src: ['**/*.coffee']
          dest: '<%%= config.tempugl %>/assets'
          ext: '.js'
        ]
      server:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: '<%%= config.src %>'
          src: ['app/**/*.coffee', 'server.coffee']
          dest: '<%%= config.dist %>'
          ext: '.js'
        ]
      test:
        options:
          sourceMap: false
        files: [
          expand: true
          cwd: '<%%= config.src %>/test'
          src: ['**/*.coffee']
          dest: '<%%= config.test %>'
          ext: '.js'
        ]
