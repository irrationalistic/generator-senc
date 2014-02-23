module.exports =
    html: '<%%= config.src %>/app/views/**/*.jade'
    options:
        dest: '.'
        flow:
          steps:
            'js': ['concat']
          post: []