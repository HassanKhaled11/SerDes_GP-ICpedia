#include "stdio.h"
#include "math.h"
#include "svdpi.h"


#define PI 3.14159265359

using namespace std;

extern "C" double calc_ssc_val (int ppm  , int ssc_iteration);


extern "C" double calc_ssc_val (int ppm  , int ssc_iteration) {
	double x = ppm - abs(ssc_iteration % (2*ppm) - ppm);
	double new_period =  1.0/(-5*pow(10,-6)*x+5);
	return abs(new_period-0.2);
}
