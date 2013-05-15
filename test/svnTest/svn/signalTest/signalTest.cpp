#include <sys/wait.h>
#include <iostream>
#include <unistd.h>
#include "signalTest.h"

using namespace std;

void signalTest::sigroutine(int signo)
{
  switch(signo)
  {
    case 1:
      cout << "SIGHUP" << endl;
      break;
    case SIGINT:
      cout << "SIGINT" << endl;
      break;
    case 3:
      cout << "SIGQUIT" << endl;
      break;

  } 
  return;
}

signalTest::signalTest()
{
  cout << "construct signalTest" <<"file name is "<<__FILE__ <<", line is " << __LINE__  << endl;
}


signalTest::~signalTest()
{
  cout << "destruct signalTest" << endl;
}  

void signalTest:: addSignal()
{
  cout << "process id is %d" << getpid() << endl;
  signal(SIGHUP,signalTest::sigroutine);
  signal(SIGINT,sigroutine);
  signal(SIGQUIT,sigroutine);
}  
void stop1(int i)
{
  cout << "I stoped ,1 ....." << endl;
}

void stop2(int i)
{
  cout << "I stoped ,2 ....." << endl;
}
void stop3(int i)
{
  cout << "I stoped ,3 ....." << endl;
}
void show_handler(int sig)
{
    printf("I got signal %d\n", sig);
    int i;
    for(i = 0; i < 5; i++) {
        printf("i = %d\n", i);
        sleep(1);
    }
}


int main()
{
  //signalTest* signal = new signalTest;
  //signal->addSignal();
#if 0  
  signalTest signal;
  signal.addSignal();
  
  sleep(20); 
#endif



#if 0
  int i = 0;
  struct sigaction act, oldact;
  act.sa_handler = show_handler;
  sigaddset(&act.sa_mask, SIGQUIT);
  

  //act.sa_flags = SA_RESETHAND | SA_NODEFER; 
  //act.sa_flags = SA_RESETHAND;
  act.sa_flags = SA_NODEFER;
  //act.sa_flags = 0; 

  sigaction(SIGINT, &act, &oldact);
  while(1) 
  {
    sleep(1);
    printf("sleeping %d\n", i);
    i++;
  }

#endif


  
  
//#if 0 
 
  int p1,p2; 
  while((p1=fork())==-1); 
  if(p1==0) 
  { 
    signal(SIGINT,SIG_IGN);
    signal(16,stop2); 
    pause(); 
    printf("p1 stop "); 
    exit(0); 
  } 
  else 
  { 
    while((p2=fork())==-1); 
    if(p2==0) 
    { 
      signal(SIGINT,SIG_IGN);
      signal(17,stop3); 
      pause(); 
      printf("p2 stop "); 
      exit(0); 
    } 
    else 
    { 
      sigset_t p;
      sigset_t newSet;
      sigemptyset(&p);
      sigemptyset(&newSet);
      sigaddset(&newSet,SIGINT);
  
      signal(SIGINT,stop1);
      sigprocmask(SIG_BLOCK,&newSet,0);
      int i = 0;
      while(i < 10)
      {  
        cout << i << endl;
        i++;  
        sleep(5);      
      }
 
      sigsuspend(&p); 
      kill(p1,16); 
      kill(p2,17); 
      waitpid(p1,0,0); 
      waitpid(p2,0,0); 
      //sleep(5);
      printf("parent stop "); 
      return 0; 
    } 
  } 
//#endif 
  
  
  
  
  
  
  return 0;
}

