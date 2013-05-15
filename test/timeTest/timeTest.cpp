//#include <time.h>
#include <sys/time.h>
#include <iostream>
using namespace std;



int main()
{
  //time_t now;
  //char * p = ctime(&now);

  //std::cout << "now the time is " << p  << std::endl;
  
  struct timeval now;
  gettimeofday(&now,0);
  cout << now.tv_sec<< "second " << now.tv_usec << "micro second" << endl;
#if 0
  struct tm *tmnow = localtime(&now);

  cout << "tm now is " << tmnow->tm_sec << "second"<< 
    tmnow->tm_min << "minute"<< tmnow->tm_hour << "hour" << tmnow->tm_mday << "day" << tmnow->tm_mon << "month"
    << tmnow->tm_year << "year" << endl; 
#endif  
  
  return 0;
}  
