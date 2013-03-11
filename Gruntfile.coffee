module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib"
  grunt.loadNpmTasks "grunt-growl"

  grunt.registerTask "default", ["clean", "copy", "jshint", "coffee", "concat", "compass:dev", "cssmin", "uglify"] # minify
  grunt.registerTask "test", ["clean", "copy", "jshint", "coffee", "concat", "connect", "qunit"]
  grunt.registerTask "x", ["growl:myMessage"]

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    # dir/files settings
    constants:
      js_files: ["app/assets/**/*.js", "vendor/assets/js/**/*.js"]
      test_files: "test/js/**/*.*"

    clean: ["public/assets"]

    copy:
      main:
        files: [
          expand: true # makes all src relative to cwd
          cwd: "app/assets/js/"
          src: ["*.js"]
          dest: "public/assets/js/"
        ,
          expand: true # makes all src relative to cwd
          cwd: "vendor/assets/"
          src: ["**"]
          dest: "public/assets/"
        ,
          src: ["app/assets/font/**"] # includes files in path
          dest: "public/assets/font/"
          filter: "isFile"
          expand: true # flattens results to a single level
          flatten: true
        ]

    jshint:
      options:
        browser: true
        devel: true
        jquery: true
        globals:
          _: false # This means that you must not overwrite '_' variable
        jshintrc: '.jshintrc'

      files: ["app/assets/**/*.js"]

    coffee:
      compile:
        # Can't use "dest: src" format
        files:
          "public/assets/js/user/user.js": "app/assets/js/user/user.coffee"
#        files:
#          "public/assets/all_coffee.js": "app/assets/javascripts/**/*.coffee"
      glob_to_multiple:
        expand: true
        cwd: "app/assets/js"
        src: ["*.coffee"]
        dest: "public/assets/js/"
        ext: ".js"
      options:
        bare: true

    concat:
      options:
        separator: ";\n"

      src:
        src: ["public/assets/**/*.js", "!public/assets/js/jquery-1.9.1.min.js", "!public/assets/js/bootstrap-2.3.1.min.js", "!public/assets/js/html5shiv.js", "!public/assets/js/underscore-1.4.4.min.js"]
        dest: "public/assets/all.js"

      test:
        src: ["<%= constants.test_files %>"]
        dest: "test/qunit/test_all.js"

    watch:
      compass:
        files: ["app/assets/sass/**/*.sass"]
        tasks: ["compass:dev"]
      src:
        files: ["<%= jshint.files %>", "app/assets/js/*.coffee", "test/qunit/tests.js"]
        tasks: ["compass:dev", "cssmin", "jshint", "coffee", "concat", 'uglify', 'test']
      full:
        files: ["<%= jshint.files %>", "app/assets/js/*.coffee", "test/qunit/tests.js"]
        tasks: ['default']
      autotest:
        files: ["<%= constants.js_files %>", "<%= constants.test_files %>", "app/assets/js/*.coffee", "test/js/qunit/qunit.html"]
        tasks: ['test']

    qunit:
      options:
        timeout: 10000
        "--cookies-file": "misc/cookies.txt"
      all:
        options:
          urls: ['http://localhost:8000/test/qunit/qunit.html']

    connect:
      server:
        options:
          port: 8000
          base: '.'

    compass:
      dist:
        options:
          sassDir: "app/assets/sass"
          cssDir: "public/assets/css"
          require: ["sassy-buttons"]
          environment: "production"

      dev:
        options:
          sassDir: "app/assets/sass"
          cssDir: "public/assets/css"
          require: ["sassy-buttons"]
          debugInfo: true
          noLineComments: false
          relativeAssets: true
          outputStyle: 'nested'

    cssmin:
      all:
      # Can't use "src: dest" format
        files:
          "public/assets/application.min.css": ["app/assets/stylesheets/application.css"]

    uglify:
      options:
        banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"

      dist:
        files: [
          src: "public/assets/all.js"
          dest: "public/assets/all.min.js"
        ]

    growl:
      myMessage:
        message: "Some message"
        title: "Notification Title"
#        image: "/foo.png"


#  grunt.event.on "qunit.spawn", (url) ->
#    grunt.log.ok "Running test: " + url
