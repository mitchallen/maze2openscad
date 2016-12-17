/**
    Module: @mitchallen/maze2openscad/lib/circle
    Author: Mitch Allen
*/

/*jshint node: true */
/*jshint esversion: 6 */

"use strict";

var fs = require('fs'),
    util = require('util'),
    mazeFactory = require("@mitchallen/maze-generator");

module.exports = function (spec) {
    
    spec = spec || {};
    let rings = spec.rings || 5;

    var _maze = mazeFactory.Circle( { rings: rings });
    if(!_maze) {
        return null;
    }
    return Object.assign( _maze, {

        // code generated maze data

        // rings = 7;
        // ringData = [
        //     // [id,spokes,{wall=1,cut=1} ...]
        //     [0,1],
        //     [1,6,1,1,1,1,1,1,1,1,1,1,1,1],
        //     [2,12,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        //     [3,24,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        //     [4,24,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        //     [5,24,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        //     [6,48,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 ]
        // ];

        writeDataFile: function(filename) {
            var stream = fs.createWriteStream(filename);
            var fd = "// code generated circle maze data\n";
            var perfect = true;
            let dirMap = this.dirMap;
            fd += util.format("rings=%d;\n", rings );
            fd += "ringData = [\n";
            fd += "//  [ringId,size,W0,C0,W1,C1,...]\n// W = 0, cut spoke\n// C = 0, cut inner wall\n";
            for(var ring = 0; ring < rings; ring++) {
                var ringSize = _maze.ringSize(ring);
                fd += util.format("\t[%d,%d", ring, ringSize);
                for(var pos = 0; pos < ringSize; pos++) {
                    var wData = this.connects( ring, pos, "CW" ) ? "0" : "1";
                    var cData = this.connectsAny( ring, pos, ["T","T0","T1"] ) ? "0" : "1";
                    fd += util.format(",%s,%s", wData, cData );
                }
                fd += "]";
                if( ring !== rings - 1) {
                    fd += ",";
                }
                fd += "\n";
            }
            fd += "];";
            
            stream.write(fd);
            stream.close();
            console.log("data written to: ", filename);
        }
    });
};
