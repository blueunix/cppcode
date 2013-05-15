#include "strOpTest.h"
#include <list>
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

  StrOpTest<string,std::list<string> > str1;
  str1.findTokenInString(s,deli);
  str1.walkThroughContainer();
}  
