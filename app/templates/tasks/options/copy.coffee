module.exports =
  js:
    files: [
      expand: true
      cwd: '<%%= config.src %>/assets'
      src: ['**/*.js']
      dest: '<%%= config.dist %>/assets'
    ]
  favicon:
    files:
      '<%%= config.dist %>/assets/common/favicon.ico': '<%%= config.src %>/assets/common/favicon.ico'