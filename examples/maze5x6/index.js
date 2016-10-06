
// var mazeFactory = require("@mitchallen/maze2openscad");
// TODO - replace with live package once published
var mazeFactory = require("../../index.js");

var mazeGenerator = mazeFactory.create({ x: 5, y: 6 });

mazeGenerator.generate();

mazeGenerator.printBoard();

mazeGenerator.writeDataFile('maze-data.scad');