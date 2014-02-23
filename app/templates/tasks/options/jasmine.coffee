module.exports =
  src: '<%%= config.dist %>/assets/**/*.js'
  options:
    specs: '<%%= config.test %>/client/**/*.js'
    vendor: [
      'http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js'
    ]