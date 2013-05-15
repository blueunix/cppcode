#include "ThreadTest.h"
#include <pthread.h>
#include <iostream>

using namespace std;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;

bool canGet =false;
bool canPut = true;
int ThreadTest::test[1];
int ThreadTest::i;

void* entry1(void *)
{
  int ret;
  for(;;)
  {
    pthread_mutex_lock(&mutex);
    while(canGet == false)
    {
      pthread_cond_wait(&cond,&mutex);
    }
    ret =  ThreadTest::getTest1();
    pthread_t pid = pthread_self();
    cout << "get thread" <<pid<< "test is" << ret << endl;
    canGet = false;
    canPut = true;
    pthread_cond_signal(&cond2);
    pthread_mutex_unlock(&mutex);
    
    //pthread_cond_signal(&cond2);  
  }
  return 0;
}  

void* entry2(void *)
{
  for(;;)
  {
    pthread_mutex_lock(&mutex);
    while(canPut == false)
    { 
      pthread_cond_wait(&cond2,&mutex);
    } 
    ThreadTest::putTest1();
    pthread_t pid = pthread_self();
    cout << "thread"<< pid << "put test now is"  << ThreadTest::geti() << endl; 
    canPut = false;
    canGet = true;
    pthread_cond_signal(&cond);
    
    //pthread_cond_wait(&cond2,&mutex);
    pthread_mutex_unlock(&mutex);
    
    //pthread_cond_signal(&cond);   
  }  
  return 0;
}  

int ThreadTest::getTest1()
{
  return test[0];
}  

void ThreadTest::putTest1()
{
  //pthread_t pid = pthread_self();
  i++; 
  test[0] = i;
  //cout << "thread"<< pid << ""put test now is"  << i << endl;
}



ThreadTest::ThreadTest()
{
  //pthread_mutex_init(&mutex,0);
  pthread_condattr_t condt;
  //pthread_condattr_init();
  pthread_cond_init(&cond,0);
  pthread_cond_init(&cond2,0);

  cout << "Construct ThreadTest" << endl;
  pthread_create(&thread[0],
      NULL,entry1,0); 
  pthread_create(&thread[0],
      NULL,entry2,0);
  pthread_create(&thread[0],
      NULL,entry2,0);
 pthread_create(&thread[0],
      NULL,entry2,0);
}  

ThreadTest::~ThreadTest()
{
  cout << "Destruct ThreadTest" << endl;

}  
