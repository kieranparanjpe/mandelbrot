double posX = new BigDecimal("-1.283819029162028169110953967901878058910369873046875").doubleValue();
double posY = new BigDecimal("0.43319113422786481581994166845106519758701324462890625").doubleValue();

ArrayList<coord> pointsOfInterest = new ArrayList<coord>();

double calcEndpoints(double a1, double a2, double x)
{
  double y = (-(a1 - a2)/2) * (x/Math.sqrt(x*x + 100000)) + (a1 + a2)/2;
  return y;
}

double proportionalEndpoint(double current, double target)
{
  double y = current + (target - current) * (deltaTime / 2 /*.025*/);
  return y;
}

void drawMandelbrotSet() {
        zoom += dz;

        double posX = map(mouseX, 0, backgroundGraphic.width, xLeft, xRight);
        double posY = map(mouseY, 0, backgroundGraphic.width, yLeft, yRight);

        if(key == 'b')
        {
         //print("(" + new BigDecimal(posX).toString() + ", " + new BigDecimal(posY).toString() + ")"); 
         savePointsToText();
        }

       /* xLeft = calcEndpoints(1, posX, zoom);
        xRight = calcEndpoints(-2, posX, zoom);
        
        yLeft = calcEndpoints(1.5, posY, zoom);
        yRight = calcEndpoints(-1.5, posY, zoom);*/
        
        xLeft = proportionalEndpoint(xLeft, posX);
        xRight = proportionalEndpoint(xRight, posX);
        
        yLeft = proportionalEndpoint(yLeft, posY);
        yRight = proportionalEndpoint(yRight, posY);

        int maxiterations = 1000;
        backgroundGraphic.loadPixels();
        for (int x = 0; x < backgroundGraphic.width; x++) {
            for (int y = 0; y < backgroundGraphic.height; y++) {
                double startA = map(x, 0, backgroundGraphic.width, xLeft, xRight);
                double startB = map(y, 0, backgroundGraphic.height, yLeft, yRight);
                double a = startA;
                double b = startB;

                double ca = a;
                double cb = b;

                int n = 0;

                while (n < maxiterations) {
                    double aa = a * a - b * b;
                    double bb = 2 * a * b;
                    a = aa + ca;
                    b = bb + cb;
                    if (a * a + b * b > 16) {
                        break;
                    }
                    n++;
                }
                float hue = map(n, 0, maxiterations, 0, 1);
                hue = map(pow(hue, 0.5), 0, 1, 0, 255);
                float saturation = map(hue, 0, 255, 100, 200);
                float brightness = map(hue, 0, 255, 100, 255);


                if (n == maxiterations) {
                    brightness = 40;
                    saturation = 60;
                }
                
                
                if (n > maxiterations / 2 - maxiterations * 0.05 && n < maxiterations / 2 + maxiterations * 0.05 && startB < 0) {
                    brightness = 255;
                    saturation = 0;
                    
                    pointsOfInterest.add(new coord(startA, startB));
                }
                
                int pix = (x + y * backgroundGraphic.width);
                backgroundGraphic.pixels[pix + 0] = color(hue, saturation, brightness, 255);
            }
        }
        backgroundGraphic.updatePixels();
}

public void savePointsToText()
{
  pointsOfInterest = BubbleSort(pointsOfInterest);
  String r = "";
  for(int i = 0; i < pointsOfInterest.size(); i++)
  {
    r += pointsOfInterest.get(i);
  }
  
  println(pointsOfInterest.size());
  
  WriteToFile("pointsOfInterest.txt", r);
}
