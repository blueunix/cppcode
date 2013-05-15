#ifndef STROPTEST_H
#define STROPTEST_H
#include <iostream>
#include <vector>
using namespace std;

template<class T,class Cont=std::vector<T> >
class StrOpTest
{
  public:
    void findTokenInString(char* string,const char* delimiters);
    void walkThroughContainer();
  private:
    Cont con;

};

template<class T,class Cont>
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

template<class T,class Cont>
void StrOpTest<T,Cont>::walkThroughContainer()
{
  cout << "walk through container begin" << endl;
  for(typename Cont::iterator it = con.begin(); it != con.end();++it)
  {
    cout << *it << " " << endl;
  }  
  cout << "walk through container end" << endl;
}
#endif
