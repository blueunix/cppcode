#ifndef STROPTEST_H
#define STROPTEST_H

#include <string.h>
#include <iostream>
#include <string>
#include <vector>
#include <deque>
using namespace std;


template<class T,
    template <typename ELEM,
              typename = std::allocator<ELEM> > 
              class Cont = std::vector >
class StrOpTest
{
  public:
    void findTokenInString(char* string,const char* delimiters);
    void walkThroughContainer();

  private:  
    Cont<T> con;
};


template<class T,template <typename,typename> class Cont>
void StrOpTest<T,Cont>::findTokenInString(char* string,const char* delimiters)
{
  char strs[128];
  memcpy(strs,string,strlen(string));
  char * token = strtok(strs,delimiters);
  if(token != NULL)
  {
    std::string str(token);
    con.push_back(str);
  }
  cout << "token is " << token << endl;
  while(token != NULL)
  {
    token = strtok(NULL,delimiters);
    if(token != NULL)
    {
      std::string str(token);
      con.push_back(str);
      cout << "token is " << token << endl;
    }  
  }
}  


template<class T,template <typename,typename> class Cont>
void StrOpTest<T,Cont>::walkThroughContainer()
{
  cout << "walk through container begin" << endl;
  for(typename Cont<T,std::allocator<T> >::iterator it = con.begin(); it != con.end();++it)
  {
    cout << *it << " " << endl;
  }  
  cout << "walk through container end" << endl;
}

#endif
