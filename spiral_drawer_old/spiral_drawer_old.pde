/*
  Spiral Drawer (OLD)
  -------------------
  
  THIS IS AN OLD VERSION - a newer prettier version now exists on the github page for this project
  
  This program uses stacked orbiting points to draw interesting spirals
  This is kind of like the code version of a spirograph
  
  written by Adrian Margel, Fall 2018
*/

//each Drawer is a rotating pen containing another Drawer at its tip
//basically this will draw an orbiting point but that point can recursively have more points orbitting it
class Drawer{
  //angle of the point being drawn
  float angle;
  //how fast the drawer rotates
  float spin;
  //the radius of the point's orbit
  float rad;
  //the child drawer orbitting this drawer's point
  Drawer child;
  
  //simple consturctor
  Drawer(float a, float s, float r){
    angle=a;
    spin=s;
    rad=r;
  }
  
  //draw the point based on a set time (t) value relative to an anchor pos (ax,ay)
  void display(float t,float ax,float ay){
    //calculate the position of the point
    float x=cos(t*spin+angle)*rad+ax;
    float y=sin(t*spin+angle)*rad+ay;
    
    //draw the point
    if(fade){
      stroke(hue,255,255,255);
    }else{
      stroke(hue,255,255,5);
    }
    point(x*zoom,y*zoom);
    
    //if the Drawer has a child draw the child using the point drawn as the new anchor pos
    if(child!=null){
      child.display(t,x,y);
    }
  }
  
  //generates children recursively to a set depth
  void generate(int deep){
    if(deep>0){
      
      //----------SAFE TO MODIFY THIS CODE----------
      
      //the code here is arbitrary, it was discovered by playing around, feel free to change
      
      float spin=deep;
      float rad=2000f-deep;//(1000-deep);
      float angle=deep/2000f*TWO_PI;
      
      if(deep%3==0){
        spin*=-2;
      }
      //--------------------------------------------
      
      //create the child and attempt to generate grand-children
      child=new Drawer(angle,spin,rad);
      child.generate(deep-1);
    }
  }
}

//----------SAFE TO MODIFY THIS CODE----------

//how fast the drawers rotate
float speed=0.00005;
//float speed=0.00001;

//the current time being rendered
//this also acts as the start time
float time=1.5;
//float time=5.0;

//how much the drawers are scaled by
float zoom=0.1;

//the hue of the drawers
float hue=0;

//if the spiral slowly fades, this should be turned off for slow speeds
boolean fade=true;
//--------------------------------------------

//the depth the seed will generate to
int depth=2000;

//the seed/first drawer, acts as the parent of all other drawers
Drawer seed=new Drawer(0,0,0);

void setup(){
  //set color mode to use hue
  colorMode(HSB);
  //set the size of the display
  size(800,800);
  //set a black background
  background(0);
  
  //set the framerate absurdly high to ensure it will always be maxed out
  frameRate(2000);
  //generate to the seed to the set depth
  seed.generate(depth);
}
void draw(){
  
  //draw a semi-transparent background
  if(fade){
    fill(0,20);
    noStroke();
    rect(0,0,1200,800);
  }
  
  //increase the time being rendered
  time+=speed;
  //display the spiral from the seed in the center of the screen
  seed.display(time,width/2/zoom,height/2/zoom);
}
