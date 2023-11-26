String mousePos = 
"-0.6772512909326726,-0.3108407456949963;-0.6772512707277465,-0.31084071009343894;-0.6772512718898914,-0.31084071027875465;-0.6772512704291196,-0.31084070952441883;-0.6772512703304073,-0.3108407095341012;-0.6772512703234225,-0.3108407095167265;-0.6772512703229938,-0.3108407095155915;-0.6772512703229419,-0.31084070951566095;-0.6772512703229577,-0.3108407095156421;-0.6772512703229578,-0.31084070951564186";


BigDecimal map(BigDecimal n, BigDecimal min, BigDecimal max, BigDecimal newMin, BigDecimal newMax)
{
    BigDecimal range = max.subtract(min).abs();
    BigDecimal progress = min.subtract(n).abs().divide(range, 2, RoundingMode.HALF_EVEN);
    return newMin.add(progress.multiply(newMax.subtract(newMin).abs()));
}

BigDecimal proportionalEndpointBD(BigDecimal current, BigDecimal target)
{
  BigDecimal y = current.add(target.subtract(current).multiply(new BigDecimal(deltaTime)));//current + (target - current) * (deltaTime);
  return y;
}

void drawMandelbrotSetBD() {
        zoom += dz;
        
        BigDecimal posX = map(new BigDecimal(mouseX), BigDecimal.ZERO, new BigDecimal(backgroundGraphic.width), xLeftBD, xRightBD);
        BigDecimal posY = map(new BigDecimal(mouseY), BigDecimal.ZERO, new BigDecimal(backgroundGraphic.height), yLeftBD, yRightBD);
        
        //double posX = map(mouseX, 0, backgroundGraphic.width, xLeft, xRight);
        //double posY = map(mouseY, 0, backgroundGraphic.width, yLeft, yRight);
        
        //double posX = -0.7475247690991199;
        //double posY = -0.08372561486261497;
        
        if(key == 'b')
        {
         print("(" + posX + ", " + posY + ")"); 
        }

       /* xLeft = calcEndpoints(1, posX, zoom);
        xRight = calcEndpoints(-2, posX, zoom);
        
        yLeft = calcEndpoints(1.5, posY, zoom);
        yRight = calcEndpoints(-1.5, posY, zoom);*/
        
        xLeftBD = proportionalEndpointBD(xLeftBD, posX);
        xRightBD = proportionalEndpointBD(xRightBD, posX);
        
        yLeftBD = proportionalEndpointBD(yLeftBD, posY);
        yRightBD = proportionalEndpointBD(yRightBD, posY);

        int maxiterations = 100;
        backgroundGraphic.loadPixels();
        for (int x = 0; x < backgroundGraphic.width; x++) {
            for (int y = 0; y < backgroundGraphic.height; y++) {
              BigDecimal a = map(new BigDecimal(x), BigDecimal.ZERO, new BigDecimal(backgroundGraphic.width), xLeftBD, xRightBD);
              BigDecimal b = map(new BigDecimal(y), BigDecimal.ZERO, new BigDecimal(backgroundGraphic.height), yLeftBD, yRightBD);
              
              BigDecimal ca = new BigDecimal(a.toString());
              BigDecimal cb = new BigDecimal(b.toString());
              
              int n = 0;
              while (n < maxiterations) {
                BigDecimal aa = a.pow(2).subtract(b.pow(2));
                BigDecimal bb = a.multiply(b).multiply(new BigDecimal(2));
                a = aa.add(ca);
                b = bb.add(cb);

                if (a.pow(2).add(b.pow(2)).compareTo(new BigDecimal(16)) > 0) {
                  break;
                }
                n++;
              }
              
              float hue = map(n, 0, maxiterations, 0, 1);
              hue = map(sqrt(hue), 0, 1, 0, 255);
              float saturation = map(hue, 0, 255, 100, 255);
              float brightness = map(hue, 0, 255, 100, 255);
              

              if (n == maxiterations) {
              brightness = 50;
              }
              int pix = (x + y * backgroundGraphic.width);
              backgroundGraphic.pixels[pix + 0] = color(hue, saturation, brightness, 255);
            }
        }
        backgroundGraphic.updatePixels();



}
