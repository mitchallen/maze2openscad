// Author: Mitch Allen
// File: maze.scad

include <maze-data.scad>

cellSize = 10;
wallSize = 3;
wallCutPadding = 1; // so sliver not left behind when wall cut out
panelSize = cellSize + wallSize;

mazePanelWidth = columns * panelSize + wallSize;
mazePanelHeight = rows * panelSize + wallSize;
mazePanelThickness = 5;
mazeFloorThickness = 1;
// Wall height needs to be large enough to not leave sliver 
// at bottom when cut out
wallHeight = mazePanelThickness * 2;
// Put 25% below zero so it completely goes through panel bottom
wallHeightOffset = 0 - wallHeight / 4;

floorColor = [0,1,0];
wallColor = [0,0,0];

module drawMazePanel() {
    color(wallColor) 
        cube(size = [mazePanelWidth,mazePanelHeight,mazePanelThickness]);
}

module drawMazeFloor() {
    color(floorColor) 
        cube(size = [mazePanelWidth,mazePanelHeight,mazeFloorThickness]);
}

module cutWalls() {
    // subtract cube cells
    for(el = [0:len(connections)-1]) {
        cell = connections[el];
        echo("CELL: ", cell);
        x = cell[0];
        y = cell[1];
        southWall = cell[2];
        eastWall = cell[3];
        
        cx = mazePanelHeight - (panelSize * (x+1));
        cy = wallSize + panelSize * y;
        
        tx = [ cy, cx, wallHeightOffset ];
        translate( tx ) cube( size = [cellSize, cellSize, wallHeight] );
        
        if( southWall == 0) {
            
            // cut south wall
            
            tx = [
                cy, 
                cx - wallCutPadding * 4, 
                wallHeightOffset ];
            
            translate( tx ) cube( size = [
                cellSize, wallSize + wallCutPadding * 2, wallHeight] );
        }
       
        if( eastWall == 0 ) {
            
            // cut east wall
            
            tx = [
                cy + cellSize  - wallCutPadding, 
                cx, 
                wallHeightOffset ];

            translate( tx ) cube( size = [
                wallSize + wallCutPadding * 2, cellSize, wallHeight] );
        }
    }
}

module main() {
    union() {
        difference() {
            drawMazePanel();
            cutWalls();
        }
        drawMazeFloor();
    }
}

main();