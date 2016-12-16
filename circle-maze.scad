// Author: Mitch Allen
// File: circle-maze.scad

include <test/output/circle-maze-data.scad>


ringColor = [1,0,0];
function spokeColor(i) = i ? ( i == 1 ? "green": "red") : "blue";
function cutColor(i) = i ? ( i == 1 ? "green": "black") : "blue";

innerRadius = 8;
ringThickness = 1.5;
ringHeight = 5;
ArmWide = 1; // The width of the arms
cutWidth = 4;
ArmHigh = ringHeight; // The height (along the Z axis) of the arms
cutHeight = ringHeight * 2; // to remove slivers

module drawRing(ringId) {
    /*
    That’s it one simple ring that is 2.5mm wide, 1.5mm thick, and has a center cut out for a 16.1mm diameter finger
    */
    
    innerDiameter = ringId * innerRadius * 2;
      
    color(ringColor) 
        rotate_extrude() 
            translate([(innerDiameter/2)+(ringThickness/2),0,0]) 
            square([ringThickness,ringHeight],center=true);
}

module drawRings() {
    
    for( i = [1 : rings]) {
        drawRing(i);
    }
}

module drawMazePanel() {
        
    drawRings();
   
   // for( i = [1 : rings - 1]) {
   for(el = [1:len(ringData)-1]) {
       // start at one, skip ring 0 (center)
       rd = ringData[el];
       ringId = rd[0];
       arms = rd[1];
       drawSpokes(rd, innerRadius, (ringId * innerRadius) );
    }
}

module drawSpokes(rd,armLength=5,fromCenter=5) {
    ringId = rd[0];
    arms = rd[1];
    union()  // Union isn't strictly necessary because everything at the top level is implicitly unioned
    { 
        for (i=[0:arms-1]) {
                color(spokeColor(i))
                rotate([0,0,-360/arms*(i + 1)]) // Rotate the arm after it's centered
                translate([fromCenter,-ArmWide/2,-ArmHigh/2]) // Center the arm around the X axis
                cube([armLength * rd[i * 2 + 2], ArmWide, ArmHigh]); // 
            }
    } 
}

module cutSpokes(rd,armLength=5,fromCenter=5) {
    ringId = rd[0];
    arms = rd[1];
 
    union()  // Union isn't strictly necessary because everything at the top level is implicitly unioned
    { 
        rotate([0,0,-360/arms*0.5])  // offset from spokes
        for (i=[0:arms-1]) 
                color(cutColor(i))
                rotate([0,0,-360/arms*i]) // Rotate the arm after it's centered
                translate([fromCenter,-cutWidth/2,-cutHeight/2]) // Center the arm around the X axis
                cube([armLength * rd[ i * 2 + 3 ], cutWidth, cutHeight * 2]);
    } 
}

module cutRings() {

    
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
        difference() {
        // union() {
            drawMazePanel();
            cutRings();
        }
        // drawMazeFloor();
    }
}

main();