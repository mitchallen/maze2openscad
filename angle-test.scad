$fa=15;
$fs=1;

module face(x) {
  translate([x,0]) difference() {
    square(10,center=true);
    circle(4);
  }
}

module face2(x) {
  translate([x,0]) difference() {
    circle(5);
    translate([0,-5])square(10);
  }
}

// test negative partial angles and geometries on -X side
rotate_extrude(angle=45) face(10);
rotate_extrude(angle=45) face(-10);
rotate_extrude(angle=-45) face(20);
rotate_extrude(angle=-45) face(-20);

// test small angles
rotate([0,0,90]) rotate_extrude(angle=5) face(10);
rotate([0,0,90]) rotate_extrude(angle=5) face(-10);

// no show
rotate_extrude(angle=0) face(5); 

// various angles treated as full circle
translate([-40,40]) rotate_extrude() face2(10);
translate([0,40]) rotate_extrude(angle=0/0) face2(10);
translate([40,40]) rotate_extrude(angle=1/0) face2(10);
translate([-40,0]) rotate_extrude(angle=-1/0) face2(10);
translate([40,0]) rotate_extrude(angle=360) face2(10);
translate([-40,-40]) rotate_extrude(angle=-360) face2(10);
translate([0,-40]) rotate_extrude(angle=1000) face2(10);
translate([40,-40]) rotate_extrude(angle=-1000) face2(10);