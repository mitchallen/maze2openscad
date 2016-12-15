/**
    Module: @mitchallen/maze2openscad
    Author: Mitch Allen
*/

/*jshint node: true */
/*jshint esversion: 6 */

"use strict";

var squareMaze = require('./lib/square');

var createMaze = (spec) => {
    console.warn("@mitchallen/maze2openscad: .create is deprecated. Use .Square instead.");
    return squareMaze( spec );
};

module.exports = {
    create: createMaze,
    Square: squareMaze
};