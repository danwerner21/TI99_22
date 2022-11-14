#include <Arduino.h>

//========================================================================
// Hardwiring the ATtiny85
//========================================================================
/*
                             ____  ____
               /RESET (PB5) -|   \/   |- (Vcc)
                 LOCK (PB3) -|        |- (PB2) CAPS LED
                   nc (PB4) -|        |- (PB1) MATRIX PA6 (OUT)
                      (GND) -|________|- (PB0) MATRIX PB7 (IN)

*/

static int capslock = 0;
static int buttonState = LOW; //this variable tracks the state of the button, low if not pressed, high if pressed
static unsigned long lastDebounceTime = 0;  // the last time the output pin was toggled
static unsigned long debounceDelay = 50;    // the debounce time; increase if the output flickers

void setup()
{
  pinMode(3, INPUT);
  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);
}

void loop() {
  buttonState = digitalRead(3);

  if ( (millis() - lastDebounceTime) > debounceDelay) {
    if ( (buttonState == HIGH) && (capslock == 0) ) {
      digitalWrite(2, LOW); //turn LED on
      capslock=1;
      lastDebounceTime = millis(); //set the current time
    }
    else if ( (buttonState == HIGH) && (capslock != 0) ) {
      digitalWrite(2, HIGH); //turn LED off
      capslock=0;
      lastDebounceTime = millis(); //set the current time
    }
  }
}
