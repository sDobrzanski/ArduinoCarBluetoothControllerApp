#include <SoftwareSerial.h>
#include <Servo.h>

///Definitions
#define EN_MOTOR 11
#define MOTOR_PIN1 12
#define MOTOR_PIN2 13
#define SERVO_PIN 9
#define RX_PIN 3
#define TX_PIN 2

///Objects
Servo servo;
SoftwareSerial BTSerial(RX_PIN, TX_PIN);

///Setup
void setup() {
  BTSerial.begin(38400);
  Serial.begin(9600);
  Serial.println("Start");
  pinMode(EN_MOTOR, OUTPUT);
  pinMode(MOTOR_PIN1, OUTPUT);
  pinMode(MOTOR_PIN2, OUTPUT);

  pinMode(RX_PIN, INPUT);
  pinMode(TX_PIN, OUTPUT);

  servo.attach(SERVO_PIN);
  servo.write(0);
  digitalWrite(MOTOR_PIN1, LOW);
  digitalWrite(MOTOR_PIN2, LOW);     
}

String messageBuffer = "";
String message = "";
const String forward = "forward;";
const String backward = "backward;";

///Main loop
void loop() {
  while (BTSerial.available() > 0) {
    char data = (char) BTSerial.read();
    messageBuffer += data;
    if (data == ';'){
      message = messageBuffer;
      message.trim();
      messageBuffer = "";
      Serial.print(message); // send to serial monitor
      BTSerial.print("You sent " + message); // send back to bluetooth terminal

      if (message.equals(forward)) {
        analogWrite(EN_MOTOR, 0);
        digitalWrite(MOTOR_PIN1, LOW);
        digitalWrite(MOTOR_PIN2, HIGH);
        analogWrite(EN_MOTOR, 200);
      } else if (message.equals(backward)) {
        analogWrite(EN_MOTOR, 0);
        digitalWrite(MOTOR_PIN1, HIGH);
        digitalWrite(MOTOR_PIN2, LOW);
        analogWrite(EN_MOTOR, 100);
      } else { ///TODO make this condition more secure
        int angleValue = message.substring(5, message.length() - 1).toInt(); //value of angle taken from message i.e. angle15; or angle330;
        servo.write(angleValue);
      }
    }
  }
}