/**
    Module: @mitchallen/maze2openscad
      Test: circle-smoke-test
    Author: Mitch Allen
*/

"use strict";

var request = require('supertest'),
    should = require('should'),
    modulePath = "../../index";

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

    it('Circle method with no spec should return object', function(done) {
        var mazeGenerator = _module.Circle();
        should.exist(mazeGenerator);
        done();
    });

    it('Circle method with valid x and y parameters should return object', function(done) {
        var mazeGenerator = _module.Circle({ rings: 5 });
        should.exist(mazeGenerator);
        done();
    });

    it('writeDataFile for a 5 ring maze should generate a maze data file', function(done) {
        var mazeGenerator = _module.Circle({ rings: 5 });
        should.exist(mazeGenerator);
        mazeGenerator.generate();
        mazeGenerator.printBoard();
        mazeGenerator.writeDataFile(_outputFolder + 'circle-maze-data.scad');
        done();
    });

    it('writeDataFile for a masked maze should generate a masked maze data file', function(done) {
        let xSize = 10;
        let ySize = 10;
        var mazeGenerator = _module.Circle({ rings: 5 });
        should.exist(mazeGenerator);
        let spec = {
            start: { c: 3, r: 3 },
            mask: [
                { c: 0, r: 0 },
                { c: 1, r: 2 },
                { c: 1, r: 4 },
            ]
        };
        mazeGenerator.generate(spec);
        mazeGenerator.printBoard();
        mazeGenerator.writeDataFile(_outputFolder + 'circle-maze-masked-data.scad');
        done();
    });
});
