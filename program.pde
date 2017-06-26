/* 

ROTATIONAL ROSE FORMATIONS (A PROJECT BY JORDAN ACCINELLI)

Here is the code for the "Rotational Rose Formations", a project currently running on my Instagram Account (@sines_n_lines).
It's designed as an exploration of Rhondonea Curve rotated through 3D spaces, and the interactivity of the layers.
In order to use yourself, just follow the following steps:

1. Refer to the variables 'n' and 'd' and change. 
   An image referring to the different results can be found at:
   https://en.wikipedia.org/wiki/Rose_(mathematics)#/media/File:Rose-rhodonea-curve-7x9-chart-improved.svg
   
2. Refer to the lines between render.pushMatrix() and render.popMatrix() and comment out the different rotate() functions.
   Different combinations will garner different results.

This code is primitive as of current, and will be built upon with a UI to aide in user experience.
This has simply been redistributed to allow for other experimentation.
Any questions about the software can be sent to jtaccinelli@gmail.com, or can be asked through my Instagram Account.

Enjoy!

*/

Rose r;
float increm = 1000;
float rotate = 0;
int n = 1;
int d = 1;
PGraphics render;

void setup() {
  size(1000,1000,P3D);
  render = createGraphics(3000,3000,P3D);
  r = new Rose(0,0,1100,n,d,0);
  render.beginDraw();
  render.background(255);
  render.endDraw();
}

void draw() {render.rotateX(rotate);
  render.beginDraw();
  //Actual Render for Generation Purposes
  render.translate((render.height)/2,(render.width)/2);
  if(rotate <= TWO_PI) {
    render.pushMatrix();
      render.rotateX(rotate);
      //render.rotateY(rotate);
      render.rotateZ(rotate);
      r.display();
    render.popMatrix();
    rotate += PI/increm;
  }
  render.endDraw();
  //Scaled Render for Demonstration Purposes
  PImage disp = render.get(0,0,render.width,render.height);
  disp.resize(width,height);
  image(disp,0,0);
}

void keyPressed() {
  render.save("output/high-res-" + r.dimen.x + "-" + r.dimen.y + ".tif");
}

class Rose {
  
  float radius, size;
  PVector draw, trans, dimen;
  color stroke;

  Rose(float x, float y, float s, float n, float d, color c) {
    
    trans = new PVector(x,y);
    dimen = new PVector(n,d);
    draw = new PVector(0,0);
    size = s;
    stroke = c;
  
  }
  
  void display() {
    
    render.stroke(stroke,5);
    render.strokeWeight(1);
    render.noFill();
    
    render.beginShape();
      for(float angle = 0; angle < TWO_PI*dimen.y; angle += 0.01) {
        radius = size*cos((dimen.x/dimen.y)*angle);
        draw.set((radius*cos(angle)+trans.x),(radius*sin(angle)+trans.x));
        render.vertex(draw.x, draw.y);
      }
    render.endShape(CLOSE);
  }
}
