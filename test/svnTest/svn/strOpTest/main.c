#include "strOpTeset.h"

int main(void)
{
  char *s = "a b c d e f g   h j \
             sdfa \
             sdfsAB_Modify-params \
             dfgsdfg";
   
  const char* deli = "\n\r\t ";
  StrOpTest<string> str;
  str.findTokenInString(s,deli);
  str.walkThroughContainer();


  StrOpTest<string,std::deque> strOpWithDeque;
  strOpWithDeque.findTokenInString(s,deli);
  strOpWithDeque.walkThroughContainer();
}  

