import processing.serial.*;
Serial port;

String data[];
String dataStr = "";

void setup() {
//Setup serial port
    port = new Serial(this, Serial.list()[12], 115200); 
    //Init txt file from server
    data = loadStrings("http://108.61.72.9/arduino.txt");
    if (data.length > 0)
    {
      String temp = data[0];
      if (temp.length() == 4)
      {
        dataStr = temp;
      }
    }
 }
void draw() {    
    data = loadStrings("http://108.61.72.9/arduino.txt");
    if (data.length > 0)
    {
      String temp = data[0];
      if (temp.length() == 4)
      {
    //If change is detected -> update Arduino
        if (temp.equals(dataStr) == false)
        {
          dataStr = temp;
          char x = dataStr.charAt(0);
          char y = dataStr.charAt(1);
          char z = dataStr.charAt(2);
          byte out[] = new byte[5];
          out[0] = byte(x);
          out[1] = byte(' ');
          out[2] = byte(y);
          out[3] = byte(' ');
          out[4] = byte(z);
          port.write(out);
        }
      }
    }
 }
