module.exports =
  dev:
    files: [
      expand: true
      cwd: '<%%= config.src %>/app/views'
      src: ['**/*.jade']
      dest: '<%%= config.dist %>/app/views'
    ]
    options:
      context:
        production: false
  dist:
    files: '<%%= preprocess.dev.files %>'
    options:
      context:
        production: true