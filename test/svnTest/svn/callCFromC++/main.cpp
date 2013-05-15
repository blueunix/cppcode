//can include this .h ,or use extern "C"
//#include "Cfunction.h"


extern "C"{ 
  void f(int a,int b);
  void g(int a,int b,int c);
  }

int main(void)
{
  int a = 1;
  int b = 2;
  int c = 3;
  f(a,b);
  g(a,b,c);
}  
