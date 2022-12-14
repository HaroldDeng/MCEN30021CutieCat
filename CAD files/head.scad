include <./Constants.scad>;
include <./headRod.scad>;
include <./utils.scad>;

// create soild ear, the ear is make out of a distorted sphere
module ear(radius){
    scale(EARS_DISTORTION) sphere(radius);
}

// create soild face (empty ball)
module face(radius){
    sphere(radius);
}

// create hollow face and ears
module hollowFaceAndEars(){
    difference(){
        union() {
            // face
            face(BASE_SPHERE_RADIUS);
            // ears
            translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE);
            translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE);
        }

        translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS * 1.5);
        translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS * 1.5);
        face(BASE_SPHERE_RADIUS - WALL_THICKNESS);
        translate([0, 0, 1]) cube([0.1, 0.2, 1], center=true);
        translate([0.04, 0, 1.2]) cube([0.05, 0.8, 0.4], center=true);
    }
}

module intrudeHead() {
    difference() {
        hollowFaceAndEars();
        translate(HEAD_INTRUDE_POS) scale(INTRUDE_HEAD_RATIO) sphere(1);    
    }
}



module catHead(){
    scale(FINAL_SCALE) union(){  //rotate(FINAL_HEAD_RT) 
        translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) {
            translate(HEAD_POS) {
                intrudeHead();
            }
            headRod();
        }
    }
    
    translate([70, 0, 126]) rotate([0, -10, 0]) disk();
    translate([45, 0, 19]) rotate([0, -100, 0]) disk();
}

color("grey") translate([50, -50, 0])difference(){
    catHead();
    translate([150, 150, 100]) cube(300, center=true);
}
color("grey") translate([50, -50, 0]) rotate([0, 0, -90]) difference(){
    catHead();
    translate([150, 150, 100]) cube(300, center=true);
}
//color("grey") translate([50, 50, 0])intersection(){
//    catHead();
//    translate([150, 150, 100]) cube(300, center=true);
//}

//color("grey") translate([250, 50, 0]) rotate([0, 0, -90])intersection(){
//    catHead();
//    translate([150, 150, 100]) cube(300, center=true);
//}

//color("grey"){
//    catHead();
//
//    translate([250, -75, 0]) rotate([-90, -90, 0]) catHead();
//
//    translate([0, -250, 0]) rotate([90, 180, 180]) catHead();
//
//    translate([250, -240, 0]) rotate([50, 120, 180]) catHead();
//}


//color("blue", 0.2) translate([18, 6, 17]) rotate([0, 0, 90]) import("./sensor.stl");
