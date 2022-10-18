#include <SoftwareSerial.h>
 
const byte rxPin = 3;
const byte txPin = 2;
SoftwareSerial BTSerial(rxPin, txPin); // RX TX
 
void setup() {
  pinMode(rxPin, INPUT);
  pinMode(txPin, OUTPUT);
  BTSerial.begin(38400);
  Serial.begin(9600);
}
 
String messageBuffer = "";
String message = "";
 
void loop() {
  while (BTSerial.available() > 0) {
    char data = (char) BTSerial.read();
    messageBuffer += data;
    if (data == ';'){
      message = messageBuffer;
      messageBuffer = "";
      Serial.print(message); // send to serial monitor
      message = "You sent " + message;
      BTSerial.print(message); // send back to bluetooth terminal
    }
  }
}