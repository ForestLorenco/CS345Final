
const int SW_pin = 2; // digital pin connected to SW
const int X_pin = 0; // analog pin connected to VRx
const int Y_pin = 1; 


const int abuttonPin = 6;
const int bbuttonPin = 5;

const int xbuttonPin = 7;
const int ybuttonPin = 8;


int ypos = 500;
int xpos = 500;
int abuttonState = 0;
int bbuttonState = 0;
int xbuttonState = 0;
int ybuttonState = 0;


void setup() {
  // put your setup code here, to run once:
  pinMode(SW_pin, INPUT);
  digitalWrite(SW_pin, HIGH);

  pinMode(abuttonPin, INPUT);
  pinMode(bbuttonPin, INPUT);
  pinMode(xbuttonPin, INPUT);
  pinMode(ybuttonPin, INPUT);
  
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  abuttonState = digitalRead(abuttonPin);
  bbuttonState = digitalRead(bbuttonPin);
  xbuttonState = digitalRead(xbuttonPin);
  ybuttonState = digitalRead(ybuttonPin);


  if(abuttonState == HIGH){
    Serial.println("A:");
    delay(100);
  }else if(bbuttonState == HIGH){
    Serial.println("B:");
    delay(100);
  }
  
//  Serial.print(abuttonState);
//  Serial.print(" b: ");
//  Serial.print(bbuttonState);
//  Serial.print(" x: ");
//  Serial.print(xbuttonState);
//  Serial.print(" y: ");
//  Serial.print(ybuttonState);
//  
//  ypos = analogRead(Y_pin);
//  xpos = analogRead(X_pin);
//  Serial.print(" X: ");
//  Serial.print(analogRead(X_pin));
//  Serial.print(" Y: ");
//  Serial.print(analogRead(Y_pin));
//  Serial.print(" Z: ");
//  Serial.println(digitalRead(SW_pin));
  
}
