'use strict';
var util = require('util');
var yeoman = require('yeoman-generator');


var ModelGenerator = yeoman.generators.NamedBase.extend({
  init: function () {
    console.log('You called the model subgenerator with the argument ' + this.name + '.');

    this.modelLower = this._.camelize(this._.slugify(this._.humanize(this.name)));
    this.modelUpper = this._.capitalize(this.modelLower);
  },

  files: function () {
    // this.copy('somefile.js', 'somefile.js');
    this.template('_model.coffee', 'src/app/models/' + this.modelLower + '.coffee');
    this.template('_seed.coffee', 'src/app/models/seeds/' + this.modelLower + 'Seed.coffee');
  }
});

module.exports = ModelGenerator;