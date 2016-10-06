
var mazeFactory = require("@mitchallen/maze2openscad");

var mazeGenerator = mazeFactory.create({ x: 5, y: 6 });

mazeGenerator.generate();

mazeGenerator.printBoard();

mazeGenerator.writeDataFile('maze-data.scad');