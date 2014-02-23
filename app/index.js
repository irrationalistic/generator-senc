'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var chalk = require('chalk');


var SencGenerator = yeoman.generators.Base.extend({
  init: function () {
    this.pkg = yeoman.file.readJSON(path.join(__dirname, '../package.json'));

    this.on('end', function () {
      if (!this.options['skip-install']) {
        this.npmInstall();
        this.bowerInstall();
      }
    });
  },

  askFor: function () {
    var done = this.async();

    // have Yeoman greet the user
    console.log(this.yeoman);

    // replace it with a short and sweet description of your generator
    console.log(chalk.magenta('You\'re using the fantastic Senc generator.'));

    var prompts = [
      {
        type: 'input',
        name: 'packageName',
        message: 'What is your project called?',
        default: this._.camelize(this._.slugify(this._.humanize(path.basename(process.cwd()))))
      },
      {
        type: 'list',
        name: 'framework',
        message: 'Would you like to use a framework?',
        choices: [
          {name:'None', value: 'none'},
          {name:'Bootstrap 3 (SASS)', value: 'bootstrap'}
        ],
        default: 0
      },
      {
        type: 'confirm',
        name: 'authentication',
        message: 'Authentication with passport.js?'
      }
    ];

    this.prompt(prompts, function (props) {
      this.packageName = props.packageName;
      this.framework = props.framework;
      this.authentication = props.authentication;

      done();
    }.bind(this));
  },

  app: function () {
    // create root application
    this.mkdir('src');
    this.mkdir('src/app');
    this.mkdir('src/app/models');
    this.mkdir('src/app/config');
    this.mkdir('src/app/routes');
    this.mkdir('src/app/views');

    this.mkdir('src/test');

    // scaffold assets
    this.mkdir('src/assets');
    if(this.authentication){
      this.mkdir('src/assets/public');
      this.mkdir('src/assets/public/images');
      this.mkdir('src/assets/common');
    }

    // APP
    var ignored = [];
    if(!this.authentication){
      ignored.push('passport.coffee');
      ignored.push('user.coffee');
      ignored.push('userSeed.coffee');
      ignored.push('_admin.coffee');
    }
    this._processDirectory('src/app', 'src/app', ignored);
    this.copy('src/server.coffee', 'src/server.coffee');
  },

  projectfiles: function () {
    // VIEWS
    var ignored = [];
    this._processDirectory('views/layouts', 'src/app/views/layouts');
    if(this.authentication){
      this._processDirectory('views/private', 'src/app/views/private');
    } else {
      ignored.push('login.jade');
    }
    this._processDirectory('views/public', 'src/app/views/public', ignored);

    // ASSETS
    var ignored = [];
    if(this.framework != 'bootstrap') ignored.push('bootstrap.scss');

    if(this.authentication){
      this._processDirectory('src/assets/private', 'src/assets/private', ignored);
    } else {
      ignored.push('login.scss');
    }
    this._processDirectory('src/assets/common', 'src/assets/common', ignored);
    this._processDirectory('src/assets/public', 'src/assets/public', ignored);

    // TESTS
    this._processDirectory('src/test', 'src/test');

    // TASKS
    var ignored = [];
    this._processDirectory('tasks', 'tasks', ignored);

    // UTILITIES
    this.template('_package.json', 'package.json');
    this.template('_bower.json', 'bower.json');
    this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
    this.copy('.gitignore', '.gitignore');
    this.copy('.slugignore', '.slugignore');
    this.template('Readme.md', 'Readme.md');
  }
});

SencGenerator.prototype._processDirectory = function(source, destination, ignore) {
  var root = this.isPathAbsolute(source) ? source : path.join(this.sourceRoot(), source);
  var files = this.expandFiles('**', { dot: true, cwd: root });

  for (var i = 0; i < files.length; i++) {
    var f = files[i];
    if(this._.contains(ignore, path.basename(f)) || path.basename(f) == '.DS_Store')
      continue;
    var src = path.join(root, f);
    if(path.basename(f).indexOf('_') == 0){
      var dest = path.join(destination, path.dirname(f), path.basename(f).replace(/^_/, ''));
      this.template(src, dest);
    }
    else{
      var dest = path.join(destination, f);
      this.copy(src, dest);
    }
  }
};

module.exports = SencGenerator;