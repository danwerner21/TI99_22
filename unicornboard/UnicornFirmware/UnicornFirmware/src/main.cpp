#include <Arduino.h>

#define   D0 26  //25
#define   D1 13
#define   D2 14
#define   D3 25 //26
#define   D4 16
#define   D5 17
#define   D6 18
#define   D7 19

#define   GRMCLK 35 //32
#define   MO     34
#define   GS     32 //35
#define   GREADY 27
#define   M      39 //DBIN

volatile bool lowByte=true;
volatile uint16_t address=0;
volatile uint8_t dataByte;
volatile       uint8_t d0;
volatile       uint8_t d1;
volatile       uint8_t d2;
volatile       uint8_t d3;
volatile       uint8_t d4;
volatile       uint8_t d5;
volatile       uint8_t d6;
volatile       uint8_t d7;

volatile       uint8_t mo;
volatile       uint8_t m;


void setup() {
  pinMode(D0, INPUT);
  pinMode(D1, INPUT);
  pinMode(D2, INPUT);
  pinMode(D3, INPUT);
  pinMode(D4, INPUT);
  pinMode(D5, INPUT);
  pinMode(D6, INPUT);
  pinMode(D7, INPUT);

  pinMode(GRMCLK, INPUT);
  pinMode(MO, INPUT);
  pinMode(GS, INPUT);
  pinMode(GREADY,OUTPUT_OPEN_DRAIN );
  pinMode(M, INPUT);
  digitalWrite(GREADY,0);
  printf("STARTUP \n");
}

void loop() {

  if( digitalRead(GS)==0)
  {
      mo=digitalRead(MO);
      m=digitalRead(M);

    // SET ADDRESS
    if((mo==1) && (m==0))
    {
      d0=digitalRead(D0);
      d1=digitalRead(D1);
      d2=digitalRead(D2);
      d3=digitalRead(D3);
      d4=digitalRead(D4);
      d5=digitalRead(D5);
      d6=digitalRead(D6);
      d7=digitalRead(D7);

      dataByte = d0 | (d1 << 1) | (d2 << 2) | (d3 << 3) | (d4 << 4) | (d5 << 5) | (d6 << 6) | (d7 << 7);
///      printf("Address Byte %i %i %i %i %i %i %i %i\n",d7,d6,d5,d4,d3,d2,d1,d0);
      if(lowByte)
      {
        address=(dataByte <<8);
        lowByte=false;
        printf("Address HIGH %02x \n",dataByte);
      }
      else
      {
        address=address | dataByte;
        printf("Address LOW %02x \n",dataByte);
        lowByte=true;
        printf("Address %04x \n",address);
      }
    }

    // Read Address
    if((mo==1) && (m==1))
    {
     lowByte=true;
    }

    // Read Data
    if((mo==0) && (m==1))
    {
      delayMicroseconds(4);

      d0=digitalRead(D0);
      d1=digitalRead(D1);
      d2=digitalRead(D2);
      d3=digitalRead(D3);
      d4=digitalRead(D4);
      d5=digitalRead(D5);
      d6=digitalRead(D6);
      d7=digitalRead(D7);

      dataByte = d0 | (d1 << 1) | (d2 << 2) | (d3 << 3) | (d4 << 4) | (d5 << 5) | (d6 << 6) | (d7 << 7);
      printf("Data Byte %02x %i %i %i %i %i %i %i %i\n",dataByte,d7,d6,d5,d4,d3,d2,d1,d0);
    }

    digitalWrite(GREADY,1);
    while(digitalRead(GS)==0);
    digitalWrite(GREADY,0);
  }
  else
  {
    digitalWrite(GREADY,0);
  }

}