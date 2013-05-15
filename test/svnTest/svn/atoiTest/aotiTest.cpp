#include <stdio.h>
#include <iostream>
#include <string.h>
#include <errno.h>

using namespace std;
int main(void)
{
  const char *str = "12347654";
  int out = atoi(str);
  cout << "out is" << out << endl;
  
  errno = 0;
  out = strtol(str,(char **)NULL,16);
  if(errno !=0)
    cout << strerror(errno) <<endl;
  cout << "out is " << out << endl;
}  
