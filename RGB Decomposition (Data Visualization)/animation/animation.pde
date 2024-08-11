
 
import processing.opengl.*;
PImage img;
int[][] values, redValues, greenValues, blueValues;
int [][][] Varray; //array of values
int mode, res=8, outline;
float angleX, angleY, angleZ, Zω=0, colorchange=0;

void setup() {
  size(1024, 768, P3D);
  
  
  
  values = new int[width][height];
  redValues = new int[width][height];
  greenValues = new int[width][height];
  blueValues = new int[width][height];
  Varray = new int[4][width][height];

  // Extract the brightness of each pixel in the image
  // and store in the "values" array
  img = loadImage("XP.jpg");
  img.loadPixels();
  for (int i = 0; i < img.height; i++) {
    for (int j = 0; j < img.width; j++) {
      color pixel = img.pixels[i*img.width + j];
      values[j][i] = int(brightness(pixel));
      // Extract the R, G, and B channels using red(), green(), and blue() functions
      redValues[j][i] = int(red(pixel));
      greenValues[j][i] = int(green(pixel));
      blueValues[j][i] = int(blue(pixel));
    }
  }
  Varray[0] = values;
  Varray[1] = redValues;
  Varray[2] = greenValues;
  Varray[3] = blueValues;
  //frameRate(60);
}

void draw() {
  
  // Set black background
  background(0);                     

  mode=0;
  
  
  
  // Move to the center
  translate(width/2, height/2, -200); 
  
  //-------------------- uncomment this section for animation----------------
  
  //animation tools
  Zω +=.01;
  colorchange +=.02;
  mode=int(floor(mode+colorchange));
  while(mode>3){
    mode -=4;}
  //rotation animations
  rotateX(1); 
  rotateZ(Zω);
  
  //---------------------------------------------------------------------------
  
  
  // Update the angles
  rotateX(angleX); 
  rotateY(angleY);
  rotateZ(angleZ);
  
  
  
   // Display the image mass
  for (int i = 0; i < img.height; i += res) {
    //translate(0,0,2);
    for (int j = 0; j < img.width; j += res) {
      //translate(j,0,0);
      if(mode==0){ 
        // B&W case
        //stroke(values[j][i], 153);
        //fill(values[j][i]);
        // normal color case
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
      }
      if (outline==1){
        stroke(0);}
      float x1 = j-img.width/2;
      float y1 = i-img.height/2;
      translate(x1,y1,0);
      box(res,res,Varray[mode][j][i]); // display box
      translate(-x1,-y1,0);
    }

  }

  rotateZ(-angleZ);
  rotateY(-angleY);
  rotateX(-angleX); 
  translate(-width/2, -height/2, 200);
  
}
  
