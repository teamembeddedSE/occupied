//HelperFunctions.cpp
#include <ESP8266WiFi.h>
#include "gpio.h"
#include "Arduino.h"

extern const char* host;


void wificonnect( void ) {

  const char* ssid     = "Molk";
  const char* password = "Molk0901";

   // We start by connecting to a WiFi network

  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  //WiFi.config(IPAddress(192,168,153,139), IPAddress(192,168,153,1), IPAddress(255,255,255,0),IPAddress(192,168,153,1));
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

int doGet(int SensorID, int status){

  Serial.print("connecting to ");
  Serial.println(host);
  
  // Use WiFiClient class to create TCP connections
  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return 1;
  }
  
  // We now create a URI for the request
  String url = "/set.php?bathroomID=";
         url += SensorID;
         url += "&status=";
         url += status;
         url += "&VCC=";
         url += ESP.getVcc();
         url += "&RSSI=";
         url += WiFi.RSSI();
  
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  // This will send the request to the server
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return 1;
    }
  }
  
  // Read all the lines of the reply from server and print them to Serial
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");

  return 0;
  }
