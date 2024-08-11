

import controlP5.*;
ControlP5 cp5;
Slider XSlider, YSlider, ZSlider, channel, resolution, Oline;
 
 
import processing.opengl.*;
PImage img;
int[][] values, redValues, greenValues, blueValues, full_color;
int [][][] Varray; //array of values
int mode, res, outline;
float angleX, angleY, angleZ, Zω=0, colorchange=0;

void setup() {
  size(1024, 768, P3D);
  
  // GUI control 
  cp5 = new ControlP5(this);
  //first row
  XSlider = cp5.addSlider("X angle").setRange(-PI/2, PI/2).setPosition(10, 10);
  YSlider = cp5.addSlider("Y angle").setRange(-PI/2, PI/2).setPosition(10+140, 10);
  ZSlider = cp5.addSlider("Z angle").setRange(-PI/2, PI/2).setPosition(10+2*140, 10);
  channel = cp5.addSlider("Channel").setRange(0, 4.99).setPosition(10+3*140, 10);
  resolution = cp5.addSlider("resolution").setValue(4).setRange(2, 10).setPosition(10+4*140, 10);
  Oline = cp5.addSlider("outline").setRange(0, 1.99).setPosition(20+5*140, 10);  
  
  
  values = new int[width][height];
  redValues = new int[width][height];
  greenValues = new int[width][height];
  blueValues = new int[width][height];
  full_color = new int[width][height];
  Varray = new int[5][width][height];

  // Extract the brightness of each pixel in the image
  // and store in the "values" array
  img = loadImage("XP.jpg");
  img.loadPixels();
  for (int i = 0; i < img.height; i++) {
    for (int j = 0; j < img.width; j++) {
      color pixel = img.pixels[i*img.width + j];
      values[j][i] = int(brightness(pixel));
      // extract the rgb channels using red(), green(), and blue() functions
      redValues[j][i] = int(red(pixel));
      greenValues[j][i] = int(green(pixel));
      blueValues[j][i] = int(blue(pixel));
      full_color[j][i] = int(brightness(pixel));
    }
  }
  Varray[0] = full_color;
  Varray[1] = redValues;
  Varray[2] = greenValues;
  Varray[3] = blueValues;
  Varray[4] = values;
}

void draw() {
  
  // Set black background
  background(0);                     
  
  // read sliders
  angleX = XSlider.getValue();
  angleY = YSlider.getValue();
  angleZ = ZSlider.getValue();
  mode = floor(int(channel.getValue()));
  res = floor(int(resolution.getValue()));
  outline = floor(int(Oline.getValue()));

  
  
  
  
  // Move to the center
  translate(width/2, height/2, 0); 
  
  //-------------------- uncomment this section for animation----------------
  /*
  //animation tools
  Zω +=.01;
  colorchange +=.1;
  mode=int(floor(mode+colorchange));
  while(mode>3){
    mode -=4;}
  //rotation animations
  rotateX(.7); 
  rotateZ(Zω);
  */
  //---------------------------------------------------------------------------
  
  
  // Update the angles
  rotateX(angleX); 
  rotateY(angleY);
  rotateZ(angleZ);
  
  
  
   // display the array of boxes 
  for (int i = 0; i < img.height; i += res) {
    //translate(0,0,2);
    for (int j = 0; j < img.width; j += res) {
      //translate(j,0,0);
      if(mode==0){ // B&W case
        stroke(img.pixels[i*img.width + j]);
        fill(img.pixels[i*img.width + j]);
      }else if(mode==1){// red case
        stroke(redValues[j][i],0,0);
        fill(redValues[j][i],0,0);
      }else if(mode==2){// green case
        stroke(0,greenValues[j][i],0);
        fill(0,greenValues[j][i],0);
      }else if(mode==3){// blue case
        stroke(0,0,blueValues[j][i]);
        fill(0,0,blueValues[j][i]);
      }else if(mode==4){// red case
        stroke(values[j][i], 153);
        fill(values[j][i]);
      }
      if (outline==1){
        stroke(0);}
      float x1 = j-img.width/2;
      float y1 = i-img.height/2;
      translate(x1,y1,-200);
      box(res,res,Varray[mode][j][i]); // display box
      translate(-x1,-y1,200);
    }

  }
  rotateZ(-angleZ);
  rotateY(-angleY);
  rotateX(-angleX); 
  
  translate(-width/2, -height/2, 0);
  
}
  
