class Instruction {

  String instructions[] = {"left", "right", "up", "down", 
                           "1", "2", "3",
                           "loop", "if"};
  String instruction;
  Float x,y,w;
  float seed;
  int moves = 0;
  int flipx = 0;
  int flipy = 0;
  int drum = 0;
  float energy = 0;
  float angle = 0;
                     
  ArrayList cxs = new ArrayList();
  
  Instruction() {
    setInstruction(instructions[int(random(instructions.length))]);
    x = random(width);
    y = random(height);
    seed = random(10000);
    flipx = random(1) > 0.5 ? 0 : 1;
    flipy = random(1) > 0.5 ? 0 : 1;
    drum = int(random(3));
  }

  int getDrum() {
    return(this.drum);
  }

  void setInstruction(String instruction) {
    this.instruction = instruction;
    w = textWidth(instruction);
  }
  
  void move() {
    float amount = energy * 0.25;
    energy -= amount;
    float dir = angle + noise(seed + (moves * 0.01)) * TWO_PI;
    float ox = cos(dir) * amount;
    float oy = sin(dir) * amount;
    x += ox;
    y += oy;
    
    if (x < 0) {
      x = 0 - x;
      angle += 0 - dir;
    }
    if (x >= width) {
      x = width - (x - width);
      angle += PI - dir;
    }
    if (y < 0) {
      y = 0 - y;
      angle += (HALF_PI) - dir;
    }
    if (y >= height) {
      y = height - (y -height);
      angle += (PI * 1.5) - dir;
    }

    moves++;
  }
  
  void show() {
    textSize(30);
    //print("show " + instruction + " at " + x + "x" + y);
    fill(255);
    text(instruction, x + (w/2), y);
  }
  void addEnergy(float energy) {
    this.energy += energy;
  }
}
