#include <iostream>
#include <cmath>

#define PI 3.14159265359
#define TABLE_SIZE 2048

using namespace std;

double y[TABLE_SIZE];
double y_45[TABLE_SIZE];
double y_90[TABLE_SIZE];
double y_135[TABLE_SIZE];
double y_180[TABLE_SIZE];
double y_225[TABLE_SIZE];
double y_270[TABLE_SIZE];
double y_315[TABLE_SIZE];

extern "C" void generate_sin_waves(double amplitude, long long frequency);
extern "C" void generate_LUTs(double amplitude, long long frequency);

extern "C" void write(double *arr_0, double *arr_45, double *arr_90, double *arr_135, double *arr_180,
                      double *arr_225, double *arr_270, double *arr_315);

/////////////////////////////////////////////////////////////

extern "C" void generate_sin_waves(double amplitude, long long frequency)
{

  double sampling_rate = 0.0004 / frequency; //(1/2048) * T

  for (int i = 0; i < TABLE_SIZE; i += 1)
  {
    double t = i * sampling_rate;

    y[i] = amplitude * sin(2 * PI * frequency * t + 0.0);
    y_45[i] = amplitude * sin(2 * PI * frequency * t + PI / 4);
    y_90[i] = amplitude * sin(2 * PI * frequency * t + PI / 2);
    y_135[i] = amplitude * sin(2 * PI * frequency * t + 3 * PI / 4);
    y_180[i] = amplitude * sin(2 * PI * frequency * t + PI);
    y_225[i] = amplitude * sin(2 * PI * frequency * t + 5 * PI / 8);
    y_270[i] = amplitude * sin(2 * PI * frequency * t + 3 * PI / 2);
    y_315[i] = amplitude * sin(2 * PI * frequency * t + 7 * PI / 8);
  }

  write(y, y_45, y_90, y_135, y_180, y_225, y_270, y_315);
}

//////////////////////////////////////////////////////////////////

extern "C" void generate_LUTs(double amplitude, long long frequency)
{

  cout << "freq =" << frequency;
  generate_sin_waves(amplitude, frequency);
}

////////////////////////////////////////////////////////////////////

// int main()
// {
//   double x =  generate_LUTs(128.0 , 0.0 , 1.0 , 5000000000);
//   //cout <<"\nx ="<< x <<"\n";

//    for(int i = 0 ; i < 1024 ; i++){
//        cout<<"y["<<i<<"] = "<< y[i] <<endl;
//        cout<<"\ny_45["<<i<<"] = "<< y_45[i] <<endl;
//    }

//   double y =  Do_Interpolation(128.0 ,60.0);
//   //cout <<"\ny ="<< y <<"\n";

// }
