import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import javax.swing.KeyStroke;


Serial MyPort;                                
String KeyString = "";
boolean pressed[] = {false,false,false,false};

//drawing and testing variables
boolean test_draw = true;
boolean lines = true;
boolean saving = false;
boolean blend = false;

color c1 = color(252, 186, 3);
color c2 = color(214, 15, 204);
color c3 = color(90, 250, 98);

int w = 1000;
int h = 500;
int sides = 4;
int size = 20;

float x =  250;
float y = 250;
float new_x = 500;
float new_y = 500;
float speed = 2;
float x2 =  250;
float y2 = 250;
float new_x2 = 500;
float new_y2 = 500;
void setup()
{
  System.out.println("Hi");
  size(1000,500);
  printArray(Serial.list());
  MyPort = new Serial(this, "/dev/cu.usbmodem1401", 9600);// My Arduino is on COM3. Enter the COM on which your Arduino is on.
  MyPort.bufferUntil('\n');
}
void draw(){//Not really necessary
  if(test_draw){
    if(blend){
      blendMode(LIGHTEST);
    }else{
      blendMode(REPLACE);
    }
    //System.out.println(lines);
    if(!saving){
    if(!lines){
      
      PImage img = loadImage("test.jpg");
      print(img.width, img.height, "\n");
      background(img);
    }
    //first joystick
    if(new_x2 < 250){
     size ++;
    }
    if(new_y2 > 750){
     speed = speed + 0.5;
    }
    
    if(new_x2 > 750){
     if(size>1){
       size--;
     }
    }
    if(new_y2 < 250){
     if(speed > 0){
      speed = speed - 0.5; 
     }
    }
    
    //second joystick
    if(new_x < 250){
     y = (y +speed)%h; 
    }
    if(new_y > 750){
     x = (x +speed)%w; 
    }
    
    if(new_x > 750){
     y = (y -speed); 
     if(y<0){
       y = h;
     }
    }
    if(new_y < 250){
     x = (x -speed); 
     if(x<0){
       x = w;
     }
    }
    if ((millis()%15000) < 5001){
       fill(lerpColor(c1, c2, (millis()%5000)/5000.0));
    }else if((millis()%15000) < 10001){
      fill(lerpColor(c2, c3, (millis()%5000)/5000.0));
    }else{
       fill(lerpColor(c3, c1, (millis()%5000)/5000.0));
    }
    
    pushMatrix();
    
    polygon(x, y, size, sides);  // Triangle
    //rotate(frameCount / 200.0);
    popMatrix();
  }
  }
}
void serialEvent(Serial MyPort)throws Exception {
   KeyString = MyPort.readStringUntil('\n');
   KeyString = KeyString.substring(0, KeyString.indexOf(':'));//The string is split. the whole string leaving the colon is taken
   String string_list [] = KeyString.split(";");
   //prints the serial string for debugging purpose
   Robot Arduino = new Robot();//Constructor of robot class
   if(string_list[0].equals("Cord")){
     if(string_list[1].equals("1")){
        new_x = float(string_list[2]);
        new_y = float(string_list[3]);
        if(new_x < 250){
         Arduino.keyPress(KeyEvent.VK_DOWN);//presses up key.
         Arduino.keyRelease(KeyEvent.VK_DOWN);//releases up key
        }
        if(new_y > 750){
         Arduino.keyPress(KeyEvent.VK_RIGHT);
         Arduino.keyRelease(KeyEvent.VK_RIGHT);  
        }
        
        if(new_x > 750){
         Arduino.keyPress(KeyEvent.VK_UP);
         Arduino.keyRelease(KeyEvent.VK_UP); 
        }
        if(new_y < 250){
          Arduino.keyPress(KeyEvent.VK_LEFT);
          Arduino.keyRelease(KeyEvent.VK_LEFT); 
        }
     }else{
       new_x2 = float(string_list[2]);
       new_y2 = float(string_list[3]);
     }
   }else{
     switch(KeyString){
       case "Ah" :
         if (!pressed[0]){
           System.out.println(string_list[0]);
           Arduino.keyPress(KeyEvent.VK_X);//presses up key.
           Arduino.keyRelease(KeyEvent.VK_X);//releases up key
           pressed[0] = true;
           sides ++;
         }
        
         break;
       case "Al":
          pressed[0] = false;
          break;
       case "Bh" :
         if(!pressed[1] ){
           System.out.println(string_list[0]);
           Arduino.keyPress(KeyEvent.VK_Z);//presses up key.
           Arduino.keyRelease(KeyEvent.VK_Z);//releases up key
           pressed[1] = true;
           if (sides > 3){
           sides --;
           }
         }
         break;
        case "Bl":
          pressed[1] = false;
          break;
          
       case "Xh" :
         if (!pressed[2]){
           System.out.println(string_list[0]);
           Arduino.keyPress(KeyEvent.VK_ENTER);//presses up key.
           Arduino.keyRelease(KeyEvent.VK_ENTER);//releases up key
           if(test_draw){
             print("save");
             saving = true;
             save("test.jpg");
             saving = false;
             
             lines = !lines;
           }
           
           pressed[2] = true;
         }
        
         break;
       case "Xl":
          pressed[2] = false;
          break;
       case "Yh" :
         if(!pressed[3] ){
           System.out.println(string_list[0]);
           Arduino.keyPress(KeyEvent.VK_BACK_SPACE);
           Arduino.keyRelease(KeyEvent.VK_BACK_SPACE);
           blend = !blend;
           pressed[3] = true;
         }
         break;
        case "Yl":
          pressed[3] = false;
          break;
     }
   }
   
}
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
