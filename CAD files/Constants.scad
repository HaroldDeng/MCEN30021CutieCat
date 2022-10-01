// render fidelity
$fn = 32;


// ====== general ======
WALL_THICKNESS = 0.04;
BASE_SPHERE_RADIUS = 1;
BASE_CUBE = [1, 1, 1];
RT_X_CW_90 = [90, 0, 0]; // rotage clockwise by 90 degree along x-aix (right-hand rule)


// ====== part final rotation, scale, and position ======
// control pars' scale number to unit size, as well as relative position to its origin
FINAL_SCALE = [100, 100, 100];
FINAL_HEAD_RT = [0, 2*sin(360*$t)+10, 0];
FINAL_HEAD_SCALE = [0.6, 0.6, 0.6];
FINAL_HEAD_POS = [BASE_SPHERE_RADIUS * 0.5, 0, BASE_SPHERE_RADIUS*0.2];
FINAL_ROD_POS = [BASE_SPHERE_RADIUS * 0.5, 0, BASE_SPHERE_RADIUS*0.2];


// ====== for motor holder ======

// real physical dimension of motor's wist in mm
// y value doesn't matter, just enought for cut a hole in the bed
MOTOR_SIZE = [13, WALL_THICKNESS * 100, 23];
HOLDER_BED_SIZE = [MOTOR_SIZE[0] * 2, MOTOR_SIZE[1] * 0.5, MOTOR_SIZE[2] * 10];
FRONT_HOLDER_POS = [18, -10, -6];
REAR_HOLDER_POS = [-25, -10, -6];
REAR_ANCHOR_POS = [-75, -5, -10];
ANCHOR_RADIUS = 1.5;
ANCHOR_LENGTH = 40;

// ====== for body ======
BODY_DISTORTION = [1.0, 0.6, 0.4];

// ====== for thigh and paw ======
SHOULDER_R = BASE_SPHERE_RADIUS * 0.13; // shoulder radius
WRIST_R = BASE_SPHERE_RADIUS * 0.08;    // wrist radius
SHOULDER_POS = [
    [BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 3, 
    BASE_SPHERE_RADIUS * BODY_DISTORTION[1] / 1.25, 0], // left
    [BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 3, 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[1] / 1.25, 0]  // right
];
WRIST_POS = [
    [BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 1.5, 
    BASE_SPHERE_RADIUS * BODY_DISTORTION[1] / 1.1, 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[2] * 1.1], // left
    [BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 1.5, 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[1] / 1.1, 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[2] * 1.1]  // right
];
FRONT_PAW_POS = [
    [WRIST_POS[0][0], WRIST_POS[0][1] / 1.01, WRIST_POS[0][2] * 1.1], // left
    [WRIST_POS[1][0], WRIST_POS[1][1] / 1.01, WRIST_POS[1][2] * 1.1]  // right
];
SHOULDER_JOINT_RT = [[90, 0, -35], [90, 0, 35]];
FRONT_PAW_RADIUS = WRIST_R * 1.5;

HIP_R = SHOULDER_R * 1.2;
HEEL_R = WRIST_R * 1.2;
_tmp = BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 1.1;
HIP_POS = [
    [-BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 2,
    BASE_SPHERE_RADIUS * BODY_DISTORTION[1]/ 1.5, 0], 
    [-BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 2,
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[1]/ 1.5, 0]];
HEEL_POS = [
    [-BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 3, 
    BASE_SPHERE_RADIUS * BODY_DISTORTION[1], 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[2] * 1.1], // left
    [-BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 3, 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[1], 
    -BASE_SPHERE_RADIUS * BODY_DISTORTION[2] * 1.1]  // right
];
REAR_PAW_POS = [
    [HEEL_POS[0][0], HEEL_POS[0][1] / 1.01, HEEL_POS[0][2] * 1.1], // left
    [HEEL_POS[1][0], HEEL_POS[1][1] / 1.01, HEEL_POS[1][2] * 1.1]  // right
];
//HIP_JOINT_RT = [[90, 0, -20], [90, 0, 20]];
HIP_JOINT_RT = [[90, 0, 0], [90, 0, 0]];
REAR_PAW_RADIUS = HEEL_R * 1.4;

INTRUDE_BODY_RATIO = [BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 2
    , BASE_SPHERE_RADIUS * BODY_DISTORTION[1] / 1.2, 
    BASE_SPHERE_RADIUS * BODY_DISTORTION[2] / 8];
TAIL_INTRUDE_POS = [-BASE_SPHERE_RADIUS * BODY_DISTORTION[0] / 1.1, 
    0, -BASE_SPHERE_RADIUS * BODY_DISTORTION[2] / 3];




// ====== for heads's rod ======
ROD_RADIUS = BASE_SPHERE_RADIUS * 0.05;
ROD_LENGTH = BASE_SPHERE_RADIUS * 1.6;

HORN_BED_SIZE = [BASE_SPHERE_RADIUS*0.35, BASE_SPHERE_RADIUS*0.02, ROD_RADIUS * 3];
HORN_HOLE_RADIUS = HORN_BED_SIZE[2] / 10;
HORN_HLOE_POS_1 = [-HORN_BED_SIZE[0] * 0.34, 0, 0];
HORN_HLOE_POS_2 = [HORN_BED_SIZE[0] * 0.34, 0, 0];
HORN_RT = [0, 50, 0];
HORN_POS = [0, BASE_SPHERE_RADIUS*0.1, 0];
HORN_COLOR = "white";


// ====== for head ======
HEAD_POS = [BASE_SPHERE_RADIUS / 1.85, 0, BASE_SPHERE_RADIUS / 1.4];
HERS_SIZE = BASE_SPHERE_RADIUS * 0.55;
EARS_DISTORTION = [0.4, 0.56, 1];
LF_EAR_RT = [-20, 10, 0];
RG_EAR_RT = [-LF_EAR_RT[0], LF_EAR_RT[1], LF_EAR_RT[2]];
LF_EAR_POS = [BASE_SPHERE_RADIUS*0.1, BASE_SPHERE_RADIUS*0.6, BASE_SPHERE_RADIUS*0.9];
RG_EAR_POS = [LF_EAR_POS[0], -LF_EAR_POS[1], LF_EAR_POS[2]];

INTRUDE_HEAD_RATIO = [BASE_SPHERE_RADIUS*0.3, BASE_SPHERE_RADIUS*0.4, BASE_SPHERE_RADIUS*0.4];
HEAD_INTRUDE_POS = [-BASE_SPHERE_RADIUS*0.5, 0, -BASE_SPHERE_RADIUS*0.5];
