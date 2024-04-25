#include "svdpi.h"
#include <stdio.h>
#include <math.h>



double calculate_alpha(double attenuation, int N) {
  double A = pow(10.0, attenuation / 20.0);
  double x1 = pow(A, 2.0);
  double x2 = sqrt((x1 - 1.0));
  double Wc = (1.0/x2)*2*3.14;
  double alpha = exp(-Wc / N);
  printf("A = %f , x1 = %f , x2 = %f , Wc =%f , alpha = %f , atten = %f , N = %f" , A,x1,x2,Wc,alpha,attenuation,N);
  return alpha;
}