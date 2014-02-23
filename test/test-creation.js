/*global describe, beforeEach, it */
'use strict';
var path = require('path');
var helpers = require('yeoman-generator').test;

var humanPackageName = 'Senc Test Package';
var packageName = 'sencTestPackage';

describe('senc generator', function () {
  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('senc:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates expected base files', function (done) {
    var expected = [
      'bower.json', 'package.json', 'Gruntfile.coffee'      
    ];
    var contentExpected = [
      ['bower.json', /test/]
    ];
    var contentNotExpected = [
      ['bower.json', /bootstrap\-sass/]
    ];

    helpers.mockPrompt(this.app, {
      'packageName': humanPackageName,
      'framework': 'none',
      'authentication': false
    });
    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      helpers.assertFileContent(contentExpected);
      helpers.assertNoFileContent(contentNotExpected);
      done();
    });
  });

  it('creates expected bootstrap files', function (done) {
    var expected = [
      'src/assets/common/css/bootstrap.scss'
    ];
    var contentExpected = [
      ['bower.json', /test/],
      ['bower.json', /bootstrap\-sass/]
    ];
    var contentNotExpected = [
      
    ];

    helpers.mockPrompt(this.app, {
      'packageName': humanPackageName,
      'framework': 'bootstrap',
      'authentication': false
    });
    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      helpers.assertFileContent(contentExpected);
      helpers.assertNoFileContent(contentNotExpected);
      done();
    });
  });

  it('creates expected authentication files', function (done) {
    var expected = [
      'src/app/config/passport.coffee',
      'src/app/models/user.coffee',
      'src/app/models/seeds/userSeed.coffee',
      'src/app/routes/admin.coffee'
    ];
    var contentExpected = [
      ['bower.json', /test/]
    ];
    var contentNotExpected = [
      
    ];

    helpers.mockPrompt(this.app, {
      'packageName': humanPackageName,
      'framework': 'none',
      'authentication': true
    });
    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      helpers.assertFileContent(contentExpected);
      helpers.assertNoFileContent(contentNotExpected);
      done();
    });
  });
});
