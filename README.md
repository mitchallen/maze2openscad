
@mitchallen/maze2openscad
==
Code generate a maze as an OpenSCAD include file
--

Generate an include file to be used in __[OpenSCAD](http://www.openscad.org)__ to display a randomly generated maze. The maze can then be exported for 3D printing.

__OpenSCAD__ works on both Windows and Mac.

* * *
## Installation

You must use __npm__ __2.7.0__ or higher because of the scoped package name.

    $ npm init
    $ npm install @mitchallen/maze2openscad --save
  
* * *

## Usage

* If you don't have a copy of __OpenSCAD__ you can download it for free from here: __[http://www.openscad.org](http://www.openscad.org)__
* Create a new test folder and change to it
* Execute the following at the command line:

        $ npm init
        $ npm install @mitchallen/maze2openscad --save
        
* Browse to: __[https://github.com/mitchallen/maze2openscad/](https://github.com/mitchallen/maze2openscad/)__
* Find the file __maze.scad__ in the root of the project and make a local copy of it.
* Edit the include path at the top of the file and change it to:

        include <maze-data.scad>

* Create a file called __index.js__
* Add the following content to __index.js__ and save it:

	    var mazeFactory = require("@mitchallen/maze2openscad");

	    var mazeGenerator = mazeFactory.Square({ x: 5, y: 6 });
	
        mazeGenerator.generate();
    
        mazeGenerator.printBoard();
    
        mazeGenerator.writeDataFile('maze-data.scad');
        
* At the command line type:

        node index.js
        
* Start OpenSCAD and open __maze.scad__
* You should see a generated maze
* Leave OpenSCAD running and run __node index.js__ to see a new maze appear in OpenSCAD

## Examples

You can find examples, such as the one above in the the __examples__ folder on the repo.


## Customization

You can customize the __maze.scad__ file that you copied from __github__. Just remember that any customization to the code generated file will be overwritten unless you move it elsewhere.

## Testing

To test, go to the root folder and type (sans __$__):

    $ npm test
   
* * *
 
## Repo(s)

* [bitbucket.org/mitchallen/maze2openscad.git](https://bitbucket.org/mitchallen/maze2openscad.git)
* [github.com/mitchallen/maze2openscad.git](https://github.com/mitchallen/maze2openscad.git)

* * *

## Contributing

In lieu of a formal style guide, take care to maintain the existing coding style.
Add unit tests for any new or changed functionality. Lint and test your code.

* * *

## Version History

* added __Circle__ method

#### Version 0.2.2

* updated examples to use __Square__

#### Version 0.2.1

* The __create__ method is deprecated in favor of __Square__
* Bumped version number because breaking backward compatability

#### Version 0.1.3

* updated to latest maze generator to allow square, circle, hexagon and triangle

#### Version 0.1.2 

* uses latest maze generator to allow masked mazes

#### Version 0.1.1 

* updated examples to use published module

#### Version 0.1.0 

* initial release

* * *
