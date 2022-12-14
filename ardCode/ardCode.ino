/**
   Name: Zhihao Deng, Jovan Tjindra
   Last modify: Oct. 16
*/

#include<Servo.h> // using servo motors

#define echo A4    // echo pin for proximity sensor
#define trig A5
#define FRAC_OF_SOUND_SPEED 29.1 // in microsecond/cm

#define btm A3 // button pin to trigger program fire the sensor

#define HEAD_SERVO_PIN        6
#define TAIL_SERVO_PIN        10
#define HEAD_SERVO_AMPLITUDE  15 // define post limits
#define HEAD_SERVO_MEAN       45
#define TAIL_SERVO_AMPLITUDE  60
#define TAIL_SERVO_MEAN       80
#define HEAD_ELAPSE          (PI / 20) // rad rotate in each loop
#define TAIL_ELAPSE          (PI / 10)

short MEH[][8] = { // pixel art
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 1, 1, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};


short SMILING[][8] = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 0, 0, 1, 0, 0},
  {0, 0, 0, 1, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};

short PLAYFUL[][8] = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 0, 0, 0, 0, 1, 0},
  {0, 0, 1, 0, 0, 1, 0, 0},
  {0, 1, 0, 0, 0, 0, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 1, 1, 0, 0},
  {0, 0, 0, 1, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};

short ALL_ON[][8] = {
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1}
};

/**
   specify Arduino pin to control LED dot matrix, detail matrix pin configuration refer to
   @func set8x8DotMatrix

   Setup
   ---
   Use jumpwire connect dot matrix from pin A to P. Use the Pin configuration look-up table in
   @func set8x8DotMatrix to identify functionality of each pin, plug them into the Arduino board.
   Save Adruino pin number as follow
*/
int rowPins[] = {
  // Arduino pin controls matrix row 0 to 7
  // but since we don't need row 0 and 7, just replace with -1
  -1, 15, 9, 13, 2, 8, 3, -1
};
int colPins[] = {
  // control from column 0 to 7
  // but since we don't need 0 and 7, just replace with -1
  -1, 4, 5, 11, 7, 12, 16, -1
};


double distance = 9999;
float headRad = 0; // current post
float tailRad = 0;
bool isBtmPressing = false;
long pressTime = -1;
bool isRtHead = false;

Servo headServo;
Servo tailServo;

void setup() {
  Serial.begin(9600); // serial communication to USB

  //  set pin mode
  for (int i = 1; i < 7; ++i) {
    pinMode(rowPins[i], OUTPUT);
    pinMode(colPins[i], OUTPUT);
    digitalWrite(rowPins[i], LOW);
    digitalWrite(colPins[i], LOW);
  }
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(btm, INPUT);
  headServo.attach(HEAD_SERVO_PIN);
  tailServo.attach(TAIL_SERVO_PIN);
  headServo.write(HEAD_SERVO_MEAN); // init pose
  tailServo.write(TAIL_SERVO_MEAN);
}

/**
  infinite loop

  Logic
  ---
  the program at first detects button presses. If button signal is high, program will
  trigger the ultrasonic sensor to read distance as long as the button is pressed. At the
  sametime, randomly select either head motor or tail motor to rotate, code snippet
  runs once, during any long press.
  With detected distance, if it's less than 10 cm, play playful emoji in dot matrix, at
  the same time move head and tail. If distance is between 10 and 30 cm, play smiling
  emoji, move head or tail according to randomizer result, If distance is neither about
  play meh emoji only.
*/
void loop() {
  if (analogRead(btm) > 1000) {
    if (pressTime == -1) {
      pressTime = millis();
    } else if (millis() - pressTime > 100 /*&& !isBtmPressing*/) {
      if (!isBtmPressing) {
        trigSensor();
        distance = readSensor();
        isRtHead = random(0, 2) == 0 ? true : false;
        isBtmPressing = true;
      }
    }
  } else {
    // reset
    pressTime = -1;
    isBtmPressing = false;
  }

  if (distance < 10) {
    set8x8DotMatrix(PLAYFUL, 40, 4);
    rtHeadMotor(); // rotate both motors
    rtTailMotor();
  } else if (distance < 30) {
    set8x8DotMatrix(SMILING, 40, 4);
    if (isRtHead) {  // rotate motor depends on randomized result
      rtHeadMotor();
    } else {
      rtTailMotor();
    }
  } else {
    set8x8DotMatrix(MEH, 40, 4);
  }

  Serial.println(analogRead(btm)); // view distance in Tools -> Serial Monitor
}

void rtHeadMotor() {
  headServo.write(sin(headRad) * HEAD_SERVO_AMPLITUDE + HEAD_SERVO_MEAN); // rotate servo
  headRad += HEAD_ELAPSE;
  if (headRad >= PI * 2) {
    headRad = 0; // reser
  }
}

void rtTailMotor() {
  tailServo.write(sin(tailRad) * TAIL_SERVO_AMPLITUDE + TAIL_SERVO_MEAN);
  tailRad += TAIL_ELAPSE;
  if (tailRad >= PI * 2) {
    tailRad = 0;
  }
}

/**
   control logic for 1588BS LED dot matrix

   Intro.
   ---
   1588BS is eight by eight LED dot matrix display ("BS" indicat it's common anode),
   16 pins on the back of the matrix controls these LEDs. Each pin is either the common
   ground of a column of LEDs, or the common source of a row of LEDs. Thus, we need two
   pins to control one LED, one of the pin specify its row, the other pin specify its
   column.

   Identify pins configuration
   ---
   We identify the positive orientation as follows: metal pins pointing downward, LEDs
   facing upward, the side with text or small bump facing toward us.
   With positive orientation, mark row of pins closer to you as A to H from left to right,
   mark row of pins away from you as I to P from right to left. As shown below:

    P O N M L K J I
   -----------------
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   -------u-1588BS--
    A B C D E F G H

   Follwing the coding convension, identify upper left corner as row 0 column 0, lower
   right corner as row 7 column 7. Pin configuration look-up table (LUT) shown below:
   Common VCC of row 0 is pin I; Common GND of column 0 is pin M;
   Common VCC of row 1 is pin N; Common GND of column 1 is pin C;
   Common VCC of row 2 is pin H; Common GND of column 2 is pin D;
   Common VCC of row 3 is pin L; Common GND of column 3 is pin J;
   Common VCC of row 4 is pin A; Common GND of column 4 is pin F;
   Common VCC of row 5 is pin G; Common GND of column 5 is pin K;
   Common VCC of row 6 is pin B; Common GND of column 6 is pin O;
   Common VCC of row 7 is pin E; Common GND of column 7 is pin P;

   Control logic
   ---
   1588BS doesn't have internal memory to "save" LEDs' state, thus
   we need to apply multiplexing technique. Multiplexing is the technique
   employed to operate LED matrices. By multiplexing, only one row
   of the LED matrix is activated at any time. [1] By flashing leds
   fast in sequence, human proceed as continuous pixel arts.

  [1] (2013, July 11). https://docs.broadcom.com/doc/AV02-3697EN. Docs.
        https://docs.broadcom.com/doc/AV02-3697EN#:~:text=Multiplexing%
        20is%20the%20technique%20employed,tied%20to%20a%20single%20row.
   ---
   @param value      an 8 by 8 2D array. 0 is OFF, anything else is ON
   @param frameRate  frame per second
   @param frameCount amount of frame will be display
*/
bool set8x8DotMatrix(short value[8][8], int frameRate, int frameCount) {
  int dTime = (int)(1000 / 8 / (double)frameRate); // lit up time per line in microsecond
  while (frameCount > 0) {
    for (int y = 1; y < 7; ++y) {

      // set up which led to turn on
      // turn off the led by provides 5V to cathode
      for (int x = 1; x < 7; ++x) {
        digitalWrite(colPins[x], value[y][x] ^ 0b1);
      }

      // provide power to entire row
      digitalWrite(rowPins[y], HIGH);
      delay(dTime); // lit up time

      // reset row
      digitalWrite(rowPins[y], LOW);
    }
    --frameCount;
  }
}

void trigSensor() {
  digitalWrite(trig, HIGH);
}
double readSensor() {
  digitalWrite(trig, LOW);

  // read wave travel time in microseconds
  return pulseIn(echo, HIGH) / 2 / FRAC_OF_SOUND_SPEED;;
}
