
class Score {
  float[] values;
  Score(String fn) {
    PImage img = loadImage(fn);
    color black = color(0,0,0);
    values = new float[img.width];
    //double[img.width] values; 
    for (int x = 0; x < img.width; ++x) {
      values[x] = 0;
      for (int y = 0; y < img.height; ++y) {
        if (img.pixels[x + (y*img.width)] == black) {
          values[x] = (float) (img.height - y) / (float) img.height;
          break;
        }
      }
    }
  }
  
  float at(float pos) {
    pos *= (float) values.length;
    int posI = (int) Math.floor(pos);
    float value = values[posI];
    // linear interpolation
    if (posI < (values.length - 1)) {
      float value2 = values[posI+1];
      value += (value2 - value) * (pos - Math.floor(pos));
      //print(pos + " = (" + values[posI] + ", " + value2 + ") = " + value + "\n");
    }
    return(value);
  }
  
  void show(int steps) {
    float w = width/2;
    float h = height/2;
    float startx = -1;
    float starty = -1;
    for(int i = 1; i < steps; ++i) {
      float posa = float(i-1)/steps;
      float posb = float(i)/steps;
      float valuea = at(float(i-1)/steps);
      float valueb = at(float(i)/steps);
      float x = cos(TWO_PI * posa - HALF_PI) * valuea;
      float y = sin(TWO_PI * posa - HALF_PI) * valuea;
      float x2 = cos(TWO_PI * posb - HALF_PI) * valueb;
      float y2 = sin(TWO_PI * posb - HALF_PI) * valueb;

      line(w+x*w,h+y*h,w+x2*w,h+y2*h);
      if (startx == -1) {
        startx = x;
        starty = y;
      }
      if (i == steps-1) {
        line(w+startx*w,h+starty*h,w+x2*w,h+y2*h);
      } 
    }
  }
}
