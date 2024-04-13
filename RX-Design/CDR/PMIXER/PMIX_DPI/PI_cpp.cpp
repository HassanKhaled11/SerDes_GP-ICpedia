#include <iostream>
#include <cmath>



#define PI             3.14159265359
#define TABLE_SIZE     1024


using namespace std;
  
   double y     [TABLE_SIZE];
   double y_45  [TABLE_SIZE];
   double y_90  [TABLE_SIZE];
   double y_135 [TABLE_SIZE];
   double y_180 [TABLE_SIZE];
   double y_225 [TABLE_SIZE];
   double y_270 [TABLE_SIZE];
   double y_315 [TABLE_SIZE];

extern "C" void generate_sin_waves(double amplitude,long long frequency);
extern "C" double generate_LUTs(double code , double index , double amplitude,long long frequency);
extern "C" double Do_Interpolation(double code ,double index);

  
 extern "C" double Do_Interpolation(double code ,double index)
  {
  unsigned short x =  ((unsigned short)code >> 8) & 7;
  double b  =  ((unsigned int)code & 255) / 255.0 ;
  double b_ = 1 - b ; 
  
  cout << "\nx = " << x ;
  cout << "\ncode = " << b << "\n\n";

  unsigned int index_ = (unsigned int) index;

  switch(x){
  
    case 0: return b_ * y[index_] + b * y_45[index_]       ;
     break;
    
    case 1: return b_ * y_45[index_] + b * y_90[index_]    ;
     break;
    
    case 2: return b_ * y_90[index_] + b * y_135[index_]   ;
     break;  
  
    case 3: return b_ * y_135[index_] + b * y_180[index_]  ;
     break;
    
     case 4: return b_ * y_180[index_] + b * y_225[index_] ;
     break;   
    
    case 5: return b_ * y_225[index_] + b * y_270[index_]  ;
     break;
    
     case 6: return b_ * y_270[index_] + b * y_315[index_] ;
     break;   
    
     case 7: return b_ * y_315[index_] + b * y[index_]     ;
     break;     
  }
 
  throw std::runtime_error("NO RETURN");

}

/////////////////////////////////////////////////////////////

extern "C" void generate_sin_waves(double amplitude,long long frequency)
{

  double sampling_rate = 0.04/frequency ;

  for(int i = 0 ; i < TABLE_SIZE; i+= 1)
   {
        double t = i * sampling_rate ;

        y[i]     = amplitude * sin(2*PI*frequency * t + 0.0)   ;
        y_45[i]  = amplitude * sin(2*PI*frequency * t + PI/4)  ;
        y_90[i]  = amplitude * sin(2*PI*frequency * t + PI/2)  ;
        y_135[i] = amplitude * sin(2*PI*frequency * t + 3*PI/4);
        y_180[i] = amplitude * sin(2*PI*frequency * t + PI)    ;
        y_225[i] = amplitude * sin(2*PI*frequency * t + 5*PI/8);
        y_270[i] = amplitude * sin(2*PI*frequency * t + 3*PI/2);
        y_315[i] = amplitude * sin(2*PI*frequency * t + 7*PI/8);
   }
}


//////////////////////////////////////////////////////////////////
 
extern "C" double generate_LUTs(double code , double index , double amplitude , long long frequency)
{

  cout << "freq =" << frequency;
  generate_sin_waves(amplitude,frequency);
   
  double out = Do_Interpolation(code,index) ;

  unsigned int index_ = (unsigned int) index;

  cout << "out = "<<out;
  cout << "\nindex = " << index;
  cout << "\ny = " << y[index_];
  cout << "\ny45 = " << y_45[index_];
  
  return out;

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
