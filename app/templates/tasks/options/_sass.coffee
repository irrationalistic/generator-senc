module.exports =
    dev:
        files: [
          expand: true
          cwd: '<%%= config.src %>/assets'
          src: ['**/*.{scss,sass}', '!**/_*.{scss,sass}', '!vendor/**/*.{scss,sass}']
          dest: '<%%= config.dist %>/assets'
          ext: '.css'
        ]
        options:
          compass: true
          style: 'expanded'
          lineNumbers: true
          loadPath: [
            <%if(framework=='bootstrap'){%>'bower_components/bootstrap-sass/lib/'<%}%>
          ]
      dist:
        files: '<%%= sass.dev.files %>'
        options:
          compass: true
          style: 'compressed'
          lineNumbers: false
          loadPath: '<%%= sass.dev.options.loadPath %>'