module.exports =
  dist:
    files: [
      expand: true
      cwd: '<%%= config.src %>/assets'
      src: ['**/*.{png,jpg,gif}']
      dest: '<%%= config.dist %>/assets'
    ]
  options:
    cache: false