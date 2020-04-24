import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import javax.swing.KeyStroke;
Serial MyPort;                                
String KeyString = "";
void setup()
{
  System.out.println("Hi");
  size(700, 500);
  printArray(Serial.list());
  MyPort = new Serial(this, "/dev/cu.usbmodem1401", 9600);// My Arduino is on COM3. Enter the COM on which your Arduino is on.
  MyPort.bufferUntil('\n');
}
//void draw(){//Not really necessary
//  background(0, 0, 0);
//  fill(255, 0, 0);
//  text("Press any key", 100, 175);
//}
void serialEvent(Serial MyPort)throws Exception {
   KeyString = MyPort.readStringUntil('\n');
   KeyString = KeyString.substring(0, KeyString.indexOf(':'));//The string is split. the whole string leaving the colon is taken
   System.out.println(KeyString);//prints the serial string for debugging purpose
   Robot Arduino = new Robot();//Constructor of robot class
   switch(KeyString){
     case "A" :
       Arduino.keyPress(KeyEvent.VK_UP);//presses up key.
       Arduino.keyRelease(KeyEvent.VK_UP);//releases up key
       break;
     case "B" :
       Arduino.keyPress(KeyEvent.VK_DOWN);
       Arduino.keyRelease(KeyEvent.VK_DOWN);      
       break;
   }
   
}
