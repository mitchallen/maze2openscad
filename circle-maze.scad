// Author: Mitch Allen
// File: circle-maze.scad

include <test/output/circle-maze-data.scad>


ringColor = [1,0,0];
function spokeColor(i) = i ? ( i == 1 ? "green": "red") : "blue";
function cutColor(i) = i ? ( i == 1 ? "green": "black") : "blue";
floorColor = "white";

// innerRadius = 6;
// middleRadius = 18;
// ringThickness = 1.5;
// outerThickness = ringThickness * 2;
// floorHeight = 2;
// ringHeight = 6;
// ringCutWidth = 5;
// spokeWidth = 0.5; // The width of the spokes

// middleHole = true;
// hasFloor = true;

spokeHeight = ringHeight; // The height (along the Z axis) of the spokes
ringCutHeight = ringHeight * 2; // to remove slivers

module drawMazeFloor() {
    
    if( hasFloor ) {
        // If hole in middle
        innerDiameter = middleHole ? innerRadius * 2 : 0;
    
        // thickness = (ringId != len(ringData)) ? ringThickness : ringThickness * 2;
    
        thickness = ringThickness 
            + innerRadius * (len(ringData)-1)
            + outerThickness - ringThickness
            + (middleHole ? 0 : middleRadius);
    
        yPos = 0 - floorHeight / 2 - ringHeight / 2;
      
        color(floorColor) 
            rotate_extrude() 
                // translate([(middleRadius)+(thickness/2),yPos,0]) 
                translate([(middleHole ? middleRadius : 0)+(thickness/2),yPos,0])
                square([thickness,floorHeight],center=true);
    }
}

module drawRing(ringId) {
    
    // innerDiameter = ringId * innerRadius * 2;
    innerDiameter = middleRadius * 2 + ( ringId - 1 ) * innerRadius * 2;
    
    thickness = (ringId != len(ringData)) ? ringThickness : outerThickness;
    
      
    color(ringColor) 
        rotate_extrude() 
            translate([(innerDiameter/2)+(thickness/2),0,0]) 
            square([thickness,ringHeight],center=true);
}

module drawRings() {
    
    for( i = [1 : rings]) {
        drawRing(i);
    }
}

module drawMazePanel() {
        
   drawRings();
    
   for(el = [1:len(ringData)-1]) {
       // start at one, skip ring 0 (center)
       rd = ringData[el];
       ringId = rd[0];
       arms = rd[1];
       // drawSpokes(rd, innerRadius, (ringId * innerRadius) );
       
       drawSpokes(rd, innerRadius, (middleRadius + (ringId - 1) * innerRadius) );
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
                translate([fromCenter,-spokeWidth/2,-spokeHeight/2]) // Center the arm around the X axis
                cube([armLength * rd[i * 2 + 2], spokeWidth, spokeHeight]); // 
            }
    } 
}

module cutSpokes(rd,armLength=5,fromCenter=5) {
    ringId = rd[0];
    arms = rd[1];
    
    padding = 0.9;
    
    cutCenter = fromCenter - ringThickness / 2;
 
    union() 
    { 
        rotate([0,0,-360/arms*0.5])  // offset from spokes
        for (i=[0:arms-1]) 
                color(cutColor(i))
                rotate([0,0,-360/arms*i]) // Rotate the arm after it's centered
                translate([cutCenter,-ringCutWidth/2,-ringCutHeight/2]) // Center the arm around the X axis
                cube(
                    [(padding + ringThickness) * (rd[ i * 2 + 3 ] ? 0 : 1), 
                    ringCutWidth, 
                    ringCutHeight * 2]
                );
    } 
}

module cutRings() {

    
   for(el = [1:len(ringData)-1]) {
       // start at one, skip ring 0 (center)
       rd = ringData[el];
       ringId = rd[0];
       arms = rd[1];
       armLength = innerRadius;
       // fromCenter = (ringId * innerRadius) - innerRadius * 0.5;
       fromCenter = middleRadius + ((ringId-1) * innerRadius);
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
        drawMazeFloor();
    }
}

main();