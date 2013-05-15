#include <stdio.h>
#include <stdlib.h>
#include <mcheck.h>

/*
 *  need to set env variable MALLOC_TRACE to keep logs
 *
 * */

int main()
{
  mtrace();
  
  char* p = malloc(10);

  free(p);

  p= malloc(20);
  return 0;

}  
