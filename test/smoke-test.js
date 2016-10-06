/**
    Module: @mitchallen/maze2openscad
      Test: smoke-test
    Author: Mitch Allen
*/

"use strict";

var request = require('supertest'),
    should = require('should'),
    modulePath = "../index";

describe('module smoke test', function() {

    var _module = null;

    // assumes test run from project root folder
    var _outputFolder = "test/output/";

    before(function(done) {
        // Call before all tests
        delete require.cache[require.resolve(modulePath)];
        _module = require(modulePath);
        done();
    });

    after(function(done) {
        // Call after all tests
        done();
    });

    beforeEach(function(done) {
        // Call before each test
        done();
    });

    afterEach(function(done) {
        // Call after eeach test
        done();
    });

    it('module should exist', function(done) {
        should.exist(_module);
        done();
    });

    it('create method with no spec should return null', function(done) {
        var mazeGenerator = _module.create();
        should.not.exist(mazeGenerator);
        done();
    });

    it('create method with valid x and y parameters should return object', function(done) {
        var mazeGenerator = _module.create({ x: 5, y: 5 });
        should.exist(mazeGenerator);
        done();
    });

    it('writeDataFile for a 5 x 6 maze should generate a maze data file', function(done) {
        var mazeGenerator = _module.create({ x: 5, y: 6 });
        should.exist(mazeGenerator);
        mazeGenerator.generate();
        mazeGenerator.printBoard();
        mazeGenerator.writeDataFile(_outputFolder + 'maze-data.scad');
        done();
    });
});
