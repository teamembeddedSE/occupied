#include <ESP8266WiFi.h>
#include "gpio.h"
ADC_MODE(ADC_VCC);

#include "HelperFunctions.h"

const char* host = "toa.teamembedded.se";
int OCCUPIED = 1;
int AVAILABLE = 0;
int GPIO0 = 0;
int GPIO2 = 2;

int SensorID = 1; // "IS" Bathroom name
int value = 0;

#define disableBlueLed PIN_FUNC_SELECT(PERIPHS_IO_MUX_U0TXD_U, FUNC_GPIO1) 
//use pin as GPIO1 instead of UART TXD - See more at: http://www.esp8266.com/viewtopic.php?f=6&t=1033#sthash.VT6hKFfm.dpuf


void setup() {
  pinMode(GPIO0,OUTPUT);
  digitalWrite(GPIO0,HIGH); //Holds CH_PD HIGH
  pinMode(GPIO2,INPUT_PULLUP);

  //digitalWrite(GPIO2, HIGH);       // turn on pullup resistors
  Serial.begin(115200);
  delay(10);

  wificonnect();

  
}

void loop() {
  //Serial.print("VCC: ");
  //Serial.println(ESP.getVcc());

  int ret;
  ret = doGet(SensorID, OCCUPIED);
  while (digitalRead(GPIO2) == HIGH){
      delay(10);
  }

  ret = doGet(SensorID, AVAILABLE);
  delay(10);
  if (ret == 0){
    ESP.deepSleep(0);
  }

}



