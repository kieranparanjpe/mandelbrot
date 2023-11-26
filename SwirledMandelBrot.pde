void drawMandelbrotSetSwirl() {
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
                double a = map((backgroundGraphic.width/ 2) + backgroundGraphic.width * 0.5 * sin(x), 0, backgroundGraphic.width, xLeft, xRight);
                double b = map((backgroundGraphic.height/ 2) + backgroundGraphic.height * 0.5 * cos(y), 0, backgroundGraphic.height, yLeft, yRight);
                
                println((backgroundGraphic.width/ 2) + backgroundGraphic.width * 0.5 * sin(x));

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
                
                int pix = (x + y * backgroundGraphic.width);
                backgroundGraphic.pixels[pix + 0] = color(hue, saturation, brightness, 255);
            }
        }
        backgroundGraphic.updatePixels();
}
