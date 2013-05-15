#include "ThreadTest.h"
#include <iostream>


int ThreadTest::test[2];
int ThreadTest::i;

void* (*entry1)(void *)
{
  int ret;
  for(;;)
  {
    pthread_mutex_lock(&mutex);
    pthread_cond_wait(&cond,&mutex);
    ret =  ThreadTest::getTest1();
    cout << "test is %d" << ret << endl;
    pthread_mutex_unlock(&mutex);
  }  
  return 0;
}  

void* (*entry2)(void *)
{
  for(;;)
  {
    pthread_mutex_lock(&mutex);
    ThreadTest::putTest1();
    pthread_cond_signal(&cond);
    pthread_mutex_unlock(&mutex);
  }  
  return 0;
}  

int ThreadTest::getTest1()
{
  return test[0];
}  

void ThreadTest::putTest1()
{
  i++; 
  test[0] = i;
  cout << "put test now is %d" << i << endl;
}



ThreadTest::ThreadTest()
{
  pthread_mutex_init(&mutex,0);
  pthread_cond_init(&cond,0);

  cout << "Construct ThreadTest" << endl;
  pthread_create(&pthread[0],
      NULL,entry1,0); 
  pthread_create(&pthread[0],
      NULL,entry1,0);
}  

ThreadTest::~ThreadTest()
{
  cout << "Destruct ThreadTest" << endl;

}  
void ThreadTest::settest()
{
  pthread_
}  
