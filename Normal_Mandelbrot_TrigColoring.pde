void drawMandelbrotSetTrigColoring() {
        zoom += dz;

        double posX = map(mouseX, 0, backgroundGraphic.width, xLeft, xRight);
        double posY = map(mouseY, 0, backgroundGraphic.width, yLeft, yRight);

        if(key == 'b')
        {
         print("(" + new BigDecimal(posX).toString() + ", " + new BigDecimal(posY).toString() + ")"); 
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
                double a = map(x, 0, backgroundGraphic.width, xLeft, xRight);
                double b = map(y, 0, backgroundGraphic.height, yLeft, yRight);

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
                hue = map(pow(hue, 0.25) + tan(n*n)/10, 0, 1, 0, 255);
                float saturation = map(hue + cos(n)/20, 0, 255, 100, 200);
                float brightness = map(hue + cos(n)/20, 0, 255, 100, 255);


                if (n == maxiterations) {
                    hue = map(y, 0, height, 50, 170) + 20 * tan(y*pow(x, 1.3) * 0.0001);
                    brightness = 60 + 40 * sin(x*y * 0.01);
                    saturation = 215 + 40 * sin(x*y + x);
                }
                
                int pix = (x + y * backgroundGraphic.width);
                backgroundGraphic.pixels[pix + 0] = color(hue, saturation, brightness, 255);
            }
        }
        backgroundGraphic.updatePixels();
}
