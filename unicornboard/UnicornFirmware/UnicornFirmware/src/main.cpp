#include <Arduino.h>
#include "grom.h"

#define   D0 26
#define   D1 13
#define   D2 14
#define   D3 25
#define   D4 16
#define   D5 17
#define   D6 18
#define   D7 19

#define   RESET  33
#define   GRMCLK 32
#define   MO     34
#define   GS     35
#define   GREADY 27
#define   M      39

#define   inMask 0xf9f09fff
#define   outMask 0x060f6000

volatile bool lowByte=true;
volatile bool readLowByte=true;
volatile uint16_t address=0;
volatile uint8_t dataByte;
volatile uint16_t dataWord;
volatile uint32_t output=0x060f6000;
volatile uint32_t temp;

volatile       uint8_t mo;
volatile       uint8_t m;
volatile       uint8_t outbyte;

void incrementAddress();
void outGromData();

void setup() {
  pinMode(GREADY,OUTPUT_OPEN_DRAIN );
  digitalWrite(GREADY,0);

  pinMode(RESET,OUTPUT);
  digitalWrite(RESET,0);

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
  pinMode(M, INPUT);

  delay(500);
  digitalWrite(RESET,1);
  pinMode(RESET,INPUT);
}

void loop() {

  if(!(REG_READ(GPIO_IN1_REG) & 0x08))
  {
      mo=REG_READ(GPIO_IN1_REG) & 0x04;
      m=REG_READ(GPIO_IN1_REG) & 0x80;

    // SET ADDRESS
    if((mo!=0) && (m==0))
    {
      readLowByte=true;

      dataWord= (REG_READ(GPIO_IN_REG)>>12);
      dataByte=(dataWord & 0xf6) + ((dataWord>>14)&0x01) + ((dataWord>>10)&0x08);

      if(lowByte)
      {
        address=(dataByte <<8);
        lowByte=false;
      }
      else
      {
        address=address | dataByte;
        lowByte=true;
      }
    }

    // Read Address
    if((mo!=0) && (m!=0))
    {
     lowByte=true;
     if(readLowByte)
     {
        outbyte=((address+1)&0xff00)>>8;
        readLowByte=false;
     }
     else
     {
      outbyte=(address+1)&0xff;
      readLowByte=true;
     }
      temp=REG_READ(GPIO_ENABLE_REG);
      REG_WRITE(GPIO_ENABLE_REG,(temp | outMask));
      outGromData();
    }

    // write Data
    if((mo==0) && (m==0))
    {
      readLowByte=true;
      lowByte=true;
      incrementAddress();
    }

    // Read Data
    if((mo==0) && (m!=0))
    {
      readLowByte=true;
      lowByte=true;
      if(((address>=0x0000) && (address<=0x17ff)) || ((address>=0x2000) && (address<=0x37ff)) || ((address>=0x4000) && (address<=0x57ff)) ||
        ((address>=0x6000) && (address<=0x77ff)) || ((address>=0x8000) && (address<=0x97ff)) || ((address>=0xA000) && (address<=0xB7ff)) ||
        ((address>=0xC000) && (address<=0xD7ff)) || ((address>=0xE000) && (address<=0xF7ff)) )
      {
        outbyte=GROM[address];
        temp=REG_READ(GPIO_ENABLE_REG);
        REG_WRITE(GPIO_ENABLE_REG,(temp | outMask));
        outGromData();
      }
     incrementAddress();
    }


    REG_WRITE(GPIO_OUT_W1TS_REG, BIT27);
    while(!(REG_READ(GPIO_IN1_REG) & 0x08));
    REG_WRITE(GPIO_OUT_W1TC_REG, BIT27);

    temp=REG_READ(GPIO_ENABLE_REG);
    REG_WRITE(GPIO_ENABLE_REG,(temp & inMask));
  }

}


void incrementAddress()
{
   address++;
      switch(address)
      {
        case 0x1800:
            address=0x0000;
            break;
        case 0x3800:
            address=0x2000;
            break;
        case 0x5800:
            address=0x4000;
            break;
        case 0x7800:
            address=0x6000;
            break;
        case 0x9800:
            address=0x8000;
            break;
        case 0xb800:
            address=0xa000;
            break;
        case 0xd800:
            address=0xc000;
            break;
        case 0xf800:
            address=0xe000;
            break;
        }
}

void outGromData()
{
    output=0x060f6000;
    REG_WRITE(GPIO_OUT_W1TC_REG, output);
    output=((outbyte&0xf6)<<12) + ((outbyte&0x1)<<26)+ ((outbyte&0x8)<<22);
    REG_WRITE(GPIO_OUT_W1TS_REG, output);
}