#include <signal.h>
#include <iostream>
#include <unistd.h>
using namespace std;
int p[200];
//#if 0
void signal_handler(int signum)
{
  cout << "oops,i get down ,byebye" << endl;
  for(int i = 0;i < 240;i++)
    cout << "i = "<< i << "      p is "<< p[i] << endl;
    
  exit(0);
}  
//#endif

//int p[200];
int main()
{
//#if 0  
  signal(SIGSEGV,signal_handler);
//#endif
  
  int i;
  for(int i =0; i < 500;i++)
  {
    p[i] = i;
  
  }  
  return 0;
}  
