/**
    Module: @mitchallen/maze2openscad
    Author: Mitch Allen
*/

/*jshint esversion: 6 */

"use strict";

var fs = require('fs'),
    util = require('util'),
    mazeFactory = require("@mitchallen/maze-generator");

module.exports.create = function (spec) {
    if(!spec) {
        return null;
    }
    if(!spec.x || !spec.y) {
        return null;
    }
    let _x = spec.x;
    let _y = spec.y;
    let _gridSpec = {
        x: _x,
        y: _y
    };
    var _maze = mazeFactory.create(_gridSpec);
    if(!_maze) {
        return null;
    }
    return Object.assign( _maze, {

        writeDataFile: function(filename) {
            var stream = fs.createWriteStream(filename);
            var fd = "// code generated maze data\n";
            fd += util.format("rows = %s;\n", _y);
            fd += util.format("columns = %s;\n", _x);
            var perfect = true;
            let dirMap = this.getDirMap();
            fd += "connections = [\n";
            fd += "//  [r,c,S,E]\n// S = 0, cut South Wall\n// E = 0, cut East Wall\n";
            for(var y = 0; y < _y; y++) {
                for(var x = 0; x < _x; x++) {
                    if( this.get(x,y)===0) {
                        perfect = false;
                    }
                    var sData = this.connects( x, y, "S" ) ? "0" : "1";
                    var eData = this.connects( x, y, "E" ) ? "0" : "1";
                    fd += util.format("\t[%d,%d,%s,%s]", y, x, sData, eData );
                    fd += (y == (_y-1) && x == (_x-1)) ? "\n" : ",\n";
                }
            }
            fd += "];";
            
            stream.write(fd);
            stream.close();
            if(!perfect) {
                console.log("WARNING: Not a perfect maze");
            }
            console.log("data written to: ", filename);
        }
    });
};
