#include <stdio.h>

#include "f1.h"

int main(void)
{
  int i,total;

  total = 0;

  for(i = 0;i < 10;i++)
    total += i;

  if(total != 45)
    printf("Failure\n");
  else
    printf("Success\n");
  
  f1();
  return 0;
}  
