import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

ArrayList is = new ArrayList();
ArrayList cs = new ArrayList();

int duration = 120; 
int start;

int maxInstructions = 100;
int maxChange = 50;
float position = 0;
Score changeScore;
Score intensityScore;

AudioInput src;

Minim minim;
BeatDetect bd;
BeatListener bl;
Tree tree;
int onsets = 0;

void setup() {
  frameRate(20);
  size(768, 768, P2D);
  smooth();
  
  start = millis();
  
  intensityScore = new Score("intensity.png");
  changeScore = new Score("change.png");

  minim = new Minim(this);
  
  src = minim.getLineIn(Minim.STEREO, int(1024));

  bd = new BeatDetect(src.bufferSize(), src.sampleRate());
  //bd = new BeatDetect();
  //bd.detectMode(BeatDetect.SOUND_ENERGY);

  bd.setSensitivity(275);  
  bl = new BeatListener(bd, src);  
  textFont(createFont("Helvetica", 16));
  textAlign(CENTER);
  
  tree = new Tree(is);
}

void stop() {
  src.close();
  minim.stop();
  super.stop();
}

void syncInstructions(int n) {
  boolean change = false;
  
  //print("instructions: " + n + "\n");
  while (is.size() < n) {
    is.add(new Instruction());
    change = true;
  }
  if (!change) {
    while (is.size() > n) {
      is.remove(int(random(is.size())));
      change = true;
    }
  }
  if (change && is.size() > 1) {
     tree.connect();
  }
}

void showClock(float position) {
  stroke(44, 117, 255,50);
  intensityScore.show(200);
  changeScore.show(200);
  strokeWeight(5);
  stroke(90,90,90,150);
  float h = height/2;
  float w = width/2;
  float x = cos(TWO_PI * position - HALF_PI);
  float y = sin(TWO_PI * position - HALF_PI);
  line(w,h,w+x*w*0.9,h+y*h*0.9);
  strokeWeight(1.5);
  
  float intensity = intensityScore.at(position);
  float change = changeScore.at(position);

  fill(150,150,150,150);
  textSize(11);
  textAlign(LEFT);

  float x2 = (w+(x*intensity*w));
  float y2 = (h+(y*intensity*h));
  ellipse(x2, y2, 6, 6);
  text(String.format(" intensity %.2f", intensity),x2,y2);

  x2 = (w+(x*change*w));
  y2 = (h+(y*change*h));
  ellipse(x2, y2, 6, 6);
  text(String.format(" change %.2f", change),x2,y2);

}

void draw() {
  background(0);
  fill(255);
  position = (millis() / 1000.0) / (float) duration;
  if (position > 1) {
    return;
  }
  
  float change = changeScore.at(position) * (float) maxChange;
  float intensity = intensityScore.at(position);
  
  //print("change: " + change + " intensity: " + intensity + "\n");
  syncInstructions(int(intensity * (float) maxInstructions));
  boolean kick = false;
  boolean snare = false;
  boolean hat = false;
//  if (bd.isOnset()) {
//   print("onset" + (onsets++) +
 // "\n");
   kick = bd.isKick();
   snare = bd.isSnare();
   hat = bd.isHat();
/*   if (kick) print("kick\n");
   if (snare) print("snare\n");
   if (hat) print("hat\n");
*/  
  for(int i = 0; i < is.size(); ++i) {
    Instruction instruct = (Instruction) is.get(i);
    switch (instruct.drum) {
      case 0:
      if (kick) {
        instruct.addEnergy(change);
      }
      break;
      case 1:
      if (snare) {
        instruct.addEnergy(change);
      }
      break;
      case 2:
        if (hat) {
          instruct.addEnergy(change);
        }
    };
    instruct.move();
  }
  if (is.size() > 1) {
    tree.connect();
  }
  
  showClock(position);
  
  strokeWeight(2);
  stroke(200);
  for (int i = 0; i < is.size(); ++i) {
    Instruction from = (Instruction) is.get(i);
    for (int j = 0; j < from.cxs.size(); ++j) {
      Instruction to = (Instruction) from.cxs.get(j);
      line(from.x, from.y, to.x, to.y);
    }
  }
  for(int i = 0; i < is.size(); ++i) {
    Instruction instruct = (Instruction) is.get(i);
    instruct.show();
  }
}
