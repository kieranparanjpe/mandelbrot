scN proportionalEndpoint(scN current, scN target)
{
  scN y = scN.add(current, scN.divide(scN.subtract(target, current), new scN(4))); 
  return y;
}

void drawMandelbrotSetBig() {
        zoom += dz;

        scN posX = scN.map(new scN(mouseX), scN.zero(), new scN(backgroundGraphic.width), xLeft_, xRight_);
        scN posY = scN.map(new scN(mouseY), scN.zero(), new scN(backgroundGraphic.height), yLeft_, yRight_);
        


       /* xLeft = calcEndpoints(1, posX, zoom);
        xRight = calcEndpoints(-2, posX, zoom);
        
        yLeft = calcEndpoints(1.5, posY, zoom);
        yRight = calcEndpoints(-1.5, posY, zoom);*/
        
        xLeft_ = proportionalEndpoint(xLeft_, posX);
        xRight_ = proportionalEndpoint(xRight_, posX);
        
        yLeft_ = proportionalEndpoint(yLeft_, posY);
        yRight_ = proportionalEndpoint(yRight_, posY);

        int maxiterations = 1000;
        backgroundGraphic.loadPixels();
        for (int x = 0; x < backgroundGraphic.width; x++) {
            for (int y = 0; y < backgroundGraphic.height; y++) {
              

                //float a = map(x, 0, backgroundGraphic.width, -2 + posX + this.zoom, 1 +posX - this.zoom);
                //float b = map(y, 0, backgroundGraphic.height, -1.5 + posY + this.zoom, 1.5 + posY - this.zoom);

                scN a = scN.map(new scN(x), scN.zero(), new scN(backgroundGraphic.width), xLeft_, xRight_);
                scN b = scN.map(new scN(y), scN.zero(), new scN(backgroundGraphic.height), yLeft_, yRight_);

                var ca = a;
                var cb = b;

                var n = 0;
                

                while (n < maxiterations) {
                    var aa = scN.subtract(scN.multiply(a, a), scN.multiply(b, b));
                    var bb = scN.multiply(scN.multiply(a, b), new scN(2)); 
                    a = scN.add(aa, ca);
                    b = scN.add(bb, cb);
                    if (scN.add(scN.multiply(a, a), scN.multiply(b, b)).compareTo(new scN(16)) > 0) {
                        break;
                    }
                    n++;
                }

                float bright = map(n, 0, maxiterations, 0, 1);
                bright = map(sqrt(bright), 0, 1, 0, 255);

                if (n == maxiterations) {
                    bright = 0;
                }
                int pix = (x + y * backgroundGraphic.width);
                backgroundGraphic.pixels[pix + 0] = color(bright, bright, bright, 255);
            }
        }
        backgroundGraphic.updatePixels();



}
