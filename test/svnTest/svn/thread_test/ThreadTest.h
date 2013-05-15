#ifndef _thread_test_h
#define _thread_test_h
#include <pthread.h>

class ThreadTest
{
  public:
    ThreadTest();
    virtual ~ThreadTest();
    static int getTest1();
    static void putTest1();
    static int geti()
    {
      return i;
    }  
  private:
    
    static int test[1];
    static int i;
    pthread_t thread[2];
    //pthread_mutex_t mutex;
    //pthread_cond_t cond;

};

#endif
