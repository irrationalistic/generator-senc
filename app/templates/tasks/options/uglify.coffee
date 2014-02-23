module.exports =
  dist:
    files: [
        expand: true
        cwd: '<%%= config.tempugl %>'
        src: ['**/*.js']
        dest: '<%%= config.dist %>'
        ext: '.js'
    ]