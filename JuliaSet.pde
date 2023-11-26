int startIndex = 0;
float juliaSpeed = 0.07;

void showJuliaSet()
{
  //juliaSpeed += map(mouseX, 0, width, -0.001, 0.001);
  //println(frameRate);
  int size = pointsOfInterest.size();
  //double index = ((size / 2.0) + (0.5 * size * sin(frameCount/40000.0)));
  float index = startIndex + abs(((frameCount * juliaSpeed) % (pointsOfInterest.size()-1)));
  //int index = (int)map(sin(frameCount / 1000.0), -1, 1, 0, pointsOfInterest.size()/10);
  
  //index = (int)map(mouseX, 0, width, 0, pointsOfInterest.size());
  
  //
  println((int)index + " / " + size);
  double ca = lerp((float)(pointsOfInterest.get((int)index).x), (float)(pointsOfInterest.get((int)index + 1).x), (float)(index - (int)index));
  double cb = lerp((float)(pointsOfInterest.get((int)index).y), (float)(pointsOfInterest.get((int)index + 1).y), (float)(index - (int)index));
  
   // double ca = map(mouseX, 0, width, -0.75, 0.75);
    //double cb = Math.sqrt(0.5628294841 + ca * ca);

    //let ca = map(mouseX, 0, width, -1, 1); //-0.70176;
     //let cb = map(mouseY, 0, height, -1, 1); //-0.3842;

    //let ca = sin(JuliaSetVisualiser.angle) * 0.4;
    //let cb = sin(JuliaSetVisualiser.angle ) * 0.4;

    //console.log(frameRate());
    // Establish a range of values on the complex plane
    // A different range will allow us to "zoom" in or out on the fractal

    // It all starts with the width, try higher or lower values
    //let w = abs(sin(angle)) * 5;
    //double w = map(mouseX, 0, width, 0, 5);
    double w = 1.8;
    double h = (w * height) / width;
    // Start at negative half the width and height
    double xmin = -w/2;
    double ymin = -h/2;

    // Make sure we can write to the pixels[] array.
    // Only need to do this once since we don't do any other drawing.
    backgroundGraphic.loadPixels();

    // x goes from xmin to xmax
    double xmax = xmin + w;
    // y goes from ymin to ymax
    double ymax = ymin + h;

    // Calculate amount we increment x,y for each pixel
    double dx = (xmax - xmin) / backgroundGraphic.width;
    double dy = (ymax - ymin) / backgroundGraphic.height;


     int maxIterations = 50;
    // Start y
    double y = ymin;
    for (int j = 0; j < backgroundGraphic.height; j++) {
        // Start x
        double x = xmin;
        for (int i = 0; i < backgroundGraphic.width; i++) {
            // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
            double a = x;
            double b = y;
            int n = 0;
            while (n < maxIterations) {
                double aa = a * a;
                double bb = b * b;
                // Infinity in our finite world is simple, let's just consider it 16
                if (aa + bb > 2.0) {
                    break; // Bail
                }
                double twoab = 2.0 * a * b;
                a = aa - bb + ca;
                b = twoab + cb;
                n++;
            }

            // We color each pixel based on how long it takes to get to infinity
            // If we never got there, let's pick the color black
            //int hue;
            //int saturation;
            //int brightness;
            
            float hue = map(n, 0, maxIterations, 0, 1);
                hue = map(pow(hue, 0.25) + tan(n*n)/10, 0, 1, 0, 255);
                float saturation = map(hue + cos(n)/20, 0, 255, 100, 200);
                float brightness = map(hue + cos(n)/20, 0, 255, 100, 255);
            
            if (n == maxIterations) {
                hue = (float)map(j, 0, height, 150, 210) + 30 * sin((float)(j*i) * 0.0001* sin(index*2));
                brightness = 140+ 10 * sin((float)(i*j) * 0.001*index);
                saturation = 150 + 40 * cos((float)(i*j * index * 0.01));
            }
             int pix = (i + j * backgroundGraphic.width);
              backgroundGraphic.pixels[pix + 0] = color(hue, saturation, brightness, 255);
            
            x += dx;
        }
        y += dy;
    }
    backgroundGraphic.updatePixels();
    //console.log(frameRate());
}
