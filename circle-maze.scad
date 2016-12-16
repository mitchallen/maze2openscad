// Author: Mitch Allen
// File: circle-maze.scad

include <test/output/circle-maze-data.scad>

wallCutPadding = 1; // so sliver not left behind when wall cut out

floorColor = [0,1,0];
wallColor = [0,0,0];
ringColor = [1,0,0];

function spokeColor(i) = i ? ( i == 1 ? "green": "red") : "blue";

function cutColor(i) = i ? ( i == 1 ? "green": "black") : "blue";

module drawSpokes(rd,armLength=5,fromCenter=5) {
    ringId = rd[0];
    arms = rd[1];
    ArmWide = 1; // The width of the arms
    ArmHigh = 3; // The height (along the Z axis) of the arms
 
    ArmsOnEdges = true; // Should the arms intersect the edge or vertices of the polygon

    CircRadius = 30; // The radius of the polygon
    
    union()  // Union isn't strictly necessary because everything at the top level is implicitly unioned
    { 
        for (i=[0:arms-1]) {
                color(spokeColor(i))
                rotate([0,0,360/arms*i]) // Rotate the arm after it's centered
                translate([fromCenter,-ArmWide/2,0]) // Center the arm around the X axis
                cube([armLength * rd[i * 2 + 2], ArmWide, ArmHigh]); // 
            }
    } 
}



module cutSpokes(rd,armLength=5,fromCenter=5) {
    ringId = rd[0];
    arms = rd[1];
    ArmWide = 2; // The width of the arms
    ArmHigh = 3; // The height (along the Z axis) of the arms
 
    ArmsOnEdges = true; // Should the arms intersect the edge or vertices of the polygon

    CircRadius = 30; // The radius of the polygon

    union()  // Union isn't strictly necessary because everything at the top level is implicitly unioned
    { 
        rotate([0,0,360/arms*0.5])  // offset from spokes
        for (i=[0:arms-1]) 
                color(cutColor(i))
                rotate([0,0,360/arms*i]) // Rotate the arm after it's centered
                translate([fromCenter,-ArmWide/2,0]) // Center the arm around the X axis
                cube([armLength * rd[ i * 2 + 3 ], ArmWide, ArmHigh]);
    } 
}

module drawRing(innerDiameter=16.1,thickness=1.5,height=5.0) {
    /*
    That’s it one simple ring that is 2.5mm wide, 1.5mm thick, and has a center cut out for a 16.1mm diameter finger
    */
      
    color(ringColor) 
        rotate_extrude() 
            translate([(innerDiameter/2)+(thickness/2),0,0]) 
            square([thickness,height],center=true);
}



module drawMazePanel() {
    // dodo();
        
    ringThickness = 1.5;
    
    for( i = [1 : rings]) {
        drawRing(i * innerRadius * 2, ringThickness);
    }
    
   innerRadius = 8;
 
   // for( i = [1 : rings - 1]) {
   for(el = [1:len(ringData)-1]) {
       // start at one, skip ring 0 (center)
       rd = ringData[el];
       ringId = rd[0];
       arms = rd[1];
       drawSpokes(rd, innerRadius, (ringId * innerRadius) );
    }
 
}

module drawMazeFloor() {

}

module cutWalls() {
    // subtract cube cells
   
    innerRadius = 8;
    
   for(el = [1:len(ringData)-1]) {
       // start at one, skip ring 0 (center)
       rd = ringData[el];
       ringId = rd[0];
       arms = rd[1];
       armLength = innerRadius;
       fromCenter = (ringId * innerRadius) - innerRadius * 0.5;
       cutSpokes(rd,armLength, fromCenter );
    }
}

module main() {
    union() {
        // difference() {
        union() {
            drawMazePanel();
            cutWalls();
        }
        // drawMazeFloor();
    }
}

main();