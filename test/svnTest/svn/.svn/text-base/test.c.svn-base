#include <stdio.h>
//#include <cstdlib>
#include <stdlib.h>
#include <pthread.h>

unsigned int g_test = 0;
void * thread_test(void *ptr)
{
  int i = 0;
  printf("...................children thread\n");
  //while(g_test < 100)
  while(1 < 100)
  {
    printf("...................children thread\n"); 
    printf("children_g_test is %u\n", g_test); 
    g_test++;
  }
}  

int main()
{
  int res;
  pthread_t pid;
  void *thread_result;

  int i = 0;
  res = pthread_create(&pid, NULL, thread_test, NULL);
  if(0 != res)
  {
    perror("Thread create failed\n");
    //exit(EXIT_FAILURE);
    exit(-1);
  }
  //while(g_test < 100)
  while(1 < 100) 
  {
    printf("         parent thread\n"); 
    printf("parent_g_test is %u\n", g_test); 
    g_test++;
  }
  printf("Waiting for thread to finish ...\n"); 
#if 0 
  res = pthread_join(pid, &thread_result);
  if(0 != res)
  {
    perror("Thread join failed\n");
    //exit(EXIT_FAILURE);
    exit(-1);
  }
#endif
#if 0
  unsigned long i = 266UL;
  i = i - 267UL;
  printf("%u\n", i);
#endif
  
  return 0;
}  

