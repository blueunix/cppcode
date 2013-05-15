extern "C" void init_main();
//class initMain;
#include <unistd.h>
#include "initMain.h"

int main()
{
  init_main();
  
    //initMain* init = new sonInitMain1("string "); 


  //delete init;


   initMain * initmain = new initMain();
   
   //initmain->pushInit();
   //initmain->InstanceOperation();
   delete initmain;
  while(1)
    ;
}  
