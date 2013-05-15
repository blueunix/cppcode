#include <pthread.h>

class ThreadTest
{
  public:
    ThreadTest();
    virtual ~ThreadTest();
    void setTest();
    static int getTest1();
    static int getTest2();

  private:
    
    static int test[1];
    static int i;
    pthread_t thread[2];
    pthread_mutext_t mutex;
    pthread_cond_t cond;

};
