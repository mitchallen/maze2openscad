
var mazeFactory = require("@mitchallen/maze2openscad");

var mazeGenerator = mazeFactory.Square({ x: 20, y: 15 });

mazeGenerator.generate();

mazeGenerator.printBoard();

mazeGenerator.writeDataFile('maze-data.scad');