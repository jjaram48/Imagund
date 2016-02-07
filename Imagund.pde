import processing.sound.*;

SinOsc[] sineWaves; 

PImage img;

int numRegions = 11;
int x = 0;
int avg;

float[] sineVolume;
float[] notes = 
  {
  261.626, 
  277.183, 
  293.665, 
  311.127, 
  329.628, 
  349.228, 
  369.994, 
  391.995, 
  415.305, 
  440, 
  466.164, 
  493.883 
};

int[] regions;
int numSines = 1;

void setup() {
  size(300, 300);
  
  img = loadImage("img-thing.jpg");
  frameRate(60);
  
  sineWaves = new SinOsc[numSines];
  sineVolume = new float[numSines];
  regions = new int[numRegions];

  for (int i = 0; i < numRegions; i++) {
    regions[i] = height*(i+1)/numRegions;
  }

  for (int i = 0; i < numSines; i++) {

    sineVolume[i] = (1.0 / numSines) / (i + 1);

    sineWaves[i] = new SinOsc(this);
    sineWaves[i].play();
    sineWaves[i].amp(0);
  }
}

void draw() {
  loadPixels();
  img.loadPixels();

  for (int y = 0; y < height; y++) {
    if (y >= height) {
      y = 0;
    }

    int loc = x + y * width;

    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    avg = int((r + g + b)/3);
    pixels[loc]= color(avg);

    for (int z = 0; z < numRegions; z++ ) {
    }

    int yoffset = int(map(avg, 0, 255, numRegions, 0));

    println(yoffset);
    println(avg);
    
    float frequency = notes[yoffset];

    for (int i = 0; i < numSines; i++) { 
      sineWaves[i].freq(frequency * (i + 1));
      sineWaves[i].amp(1/avg);
    }
  }
  //for (int i = 0; i < notes.length; i++) {
  //  float freq = notes[i];
  //  sineWaves.freq(freq);
  //  sineWaves[i].amp(avgs[x][i]);
  //}

  avg = 0;
  updatePixels();
  x++;
  if (x>=width) {
    x=0;
  }
}