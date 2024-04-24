#include "stdio.h"
#include "math.h"
#include "headerDPI.h"


#define PI 3.14159265359

using namespace std;

extern double calc_jitter_val (double amplitude , int freq , double time_sec);

extern double calc_jitter_val (double amplitude , int freq , double time_sec) {
	return amplitude*sin(2*PI*5e09*time_sec);
}