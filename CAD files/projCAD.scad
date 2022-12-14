include <./head.scad>
include <./body.scad>
include <./tail.scad>
include <./headRod.scad>
include <./motorWithHorn.scad>
include <./Constants.scad>


// ====== just for demonstration ======

module placeFrontMotro(){
    translate([18, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(FINAL_HEAD_RT[1]+170);
    color("green") translate([18-sin(360*$t+10)/2, 4.5, 7]) rotate([0, -35+sin(-360*$t+180)/2, 0]) cube([35, 3, 1]);
}

module placeRearMotor(){
    translate([-25, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(-FINAL_HEAD_RT[1]*2 + 195);
    color("green") translate([-67-sin(360*$t+10), 15.5, -16]) rotate([0, -30, -16]) cube([50, 3, 1]);
}

module placeTail(){
    translate(REAR_ANCHOR_POS - [0, 0, 3]) rotate([0, 0, 180]) catTail(FINAL_HEAD_RT[1]-40);
}

// ====================================


//removeTop();
//catBody();

module abc(){
    if (SHOW_FRONT_MECH){
        placeFrontMotro();
    }
    if (SHOW_REAR_MECH){
        placeRearMotor();
        
    }
    translate([-1, 0, 5]) placeTail();
    catHead();
}

color("grey"){
    abc();
    
    translate([200, 0, 0]) rotate([-90, -90, 0]) abc();

    translate([-120, -100, 0]) rotate([90, 0, 180]) abc();

    translate([180, -100, 0]) rotate([135, 0, 180]) abc();

}









//// Ardurio UNO
//if (SHOW_ARDUINO){
//    color("orange") translate([0, 20, -17]) 
//        rotate([22, 0, 0]) cube(ARD_SIZEs, center=true);
//}
