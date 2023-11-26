public class scN
{
  public double base;
  public long exponent;
  
  public scN(double n)
  {
    int sign = n >= 0 ? 1 : -1;
    
    n = Math.abs(n);
    
    if(n==0){
      exponent = zero().exponent;
      base = zero().base;
      return;
    }
    
    long e = 0;
    while(n >= 10)
    {
      n /= 10;
      e++;
    }
    while(n < 1)
    {
     n*=10;
     e--;
    }
    
    base = n  * sign;
    exponent = e;
  }
  
  public static scN zero()
  {
    return new scN(0, 1);
  }
  
  public scN(double b, long e)
  {
     base = b;
     exponent = e;
  }
  
  public int compareTo(scN n)
  {
    if(exponent > n.exponent)
      return 1;
    if(exponent < n.exponent)
      return -1;
      
    if(base > n.base)
      return 1;
    if(base < n.base)
      return -1;
      
    return 0;
  }
  
  public scN reduce(){
    
    if(base == 0)
    {
      base = 0;
      exponent = 1;
      
      return this;
    }
    
    while(Math.abs(base) > 10)
    {
      base /= 10;
      exponent++;
    }
    while(Math.abs(base) < 1)
    {
      base*=10;
      exponent--;
    }
   
    return this;
  }
  
  public static scN add(scN n1, scN n2)
  {
    return new scN(n1.base + convertToExponent(n2, n1.exponent).base, n1.exponent).reduce();
  }
  
  public static scN subtract(scN n1, scN n2)
  {
    return new scN(n1.base - convertToExponent(n2, n1.exponent).base, n1.exponent).reduce();
  }
  
  public static scN multiply(scN n1, scN n2)
  {
    return new scN(n1.base * n2.base, n1.exponent + n2.exponent).reduce();
  }
  
  public static scN divide(scN n1, scN n2)
  {
    return new scN(n1.base / n2.base, n1.exponent - n2.exponent).reduce();
  }
  
  private static scN convertToExponent(scN num, long e)
  {
    scN n = new scN(num.base, num.exponent);
    
    if(n.base == 0)
    {
      n.exponent = e;
      return n;
    }

    while(n.exponent >= e)
    {

      n.base *= 10;
      n.exponent--;
    }
    while(n.exponent < e)
    {
      n.base/=10;
      n.exponent++;
    }

    return n;
  }
  
  public static scN abs(scN n)
  {
    return new scN(Math.abs(n.base), n.exponent);
  }
  
  public static scN map(scN n, scN min, scN max, scN newMin, scN newMax)
  {
    scN range = scN.abs(scN.subtract(min, max));
    
    //System.out.println(range);
    scN progress = scN.divide(scN.abs(scN.subtract(min, n)), range);
    
    scN newRange = scN.abs(scN.subtract(newMin, newMax));
   // System.out.println(scN.add(newMin, scN.multiply(progress, (newRange))));
    

    return scN.add(newMin, scN.multiply(progress, newRange));
  }
  
  @Override
  public String toString()
  {
    return base + " x 10^" + exponent;
  }
}
