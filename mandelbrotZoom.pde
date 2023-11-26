import java.math.*;


PGraphics backgroundGraphic;
float zoom = 0.01;
float dz = 1;

double startSize = 2;

 double xLeft = -2;
double xRight = 1; 
double yLeft = -1.5;
double yRight = 1.5;

BigDecimal xLeftBD = new BigDecimal(-2);
BigDecimal xRightBD = new BigDecimal(1); 
BigDecimal yLeftBD = new BigDecimal(-1.5);
BigDecimal yRightBD = new BigDecimal(1.5);

 scN xLeft_ = new scN(-2);
scN xRight_ = new scN(1);
scN yLeft_ = new scN(-1.5);
scN yRight_ = new scN(1.5);

float deltaTime = 1/60.0;
int lastTime;

ArrayList<coord> coords = new ArrayList<coord>();

ArrayList<coord> coordsTG = new ArrayList<coord>();

int coordPos = 0;


void setup()
{
  size(1080/4, 1920/4);
  backgroundGraphic = createGraphics(1080/4, 1920/4);
  colorMode(HSB, 255);
  
  double aspect = backgroundGraphic.height / (double)backgroundGraphic.width;
  yLeft = -1.5 * aspect;
  yRight = 1.5 * aspect;
  
  xLeft *= startSize;
  xRight *= startSize;
  yLeft *= startSize;
  yRight *= startSize;
          
  String[] cs = mousePos.split(";");
  for(String c : cs)
  {
    String[] i = c.split(",");
    coordsTG.add(new coord(Double.parseDouble(i[0]), Double.parseDouble(i[1])));
  }
  
  //CreateFile("pointsOfInterest.txt");
  
  String[] pois = ReadFile("pointsOfInterest.txt").split(";");
  
  if(pois.length < 2)
  {
    println(pois[0]);
    return;
  }
  for(String poi : pois)
  {
    String[] i = poi.split(",");
    pointsOfInterest.add(new coord(Double.parseDouble(i[0]), Double.parseDouble(i[1])));
  }
}

public class coord
{
 double x, y;
 
 public coord(double x, double y)
 {
  this.x = x;
  this.y = y;
 }
 
 public String toString()
 {
  return this.x + "," + this.y + ";"; 
 }
}

double map(double n, double min, double max, double newMin, double newMax)
{
  double range = abs(max - min);
  double progress = abs(min - n) / range;
  
  return newMin + progress * abs(newMax - newMin);
}

double abs(double n)
{
  return Math.abs(n);
}

void draw()
{
  deltaTime = (millis() - lastTime) / 1000.0;
  lastTime = millis();
  
  backgroundGraphic.beginDraw();
  drawMandelbrotSet();
  //showJuliaSet();
  backgroundGraphic.endDraw();
  
  image(backgroundGraphic, 0, 0);
  
  saveFrame("video1/" + frameCount + ".png");
}
