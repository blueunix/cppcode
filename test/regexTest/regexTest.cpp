#include <fnmatch.h>
#include <fstream>
#include <vector>
#include <string>
#include <iostream>
#include <map>
using namespace std;

/*
 *  search specific string which conform to regex pattern
 * */

void openAndRead(const char *filename, vector<string>& vec)
{
  ifstream ifo(filename);
  
  char cstr[256];
  if(ifo)
  {
    while(ifo.good())
    {  
      ifo.getline(cstr,256);
      string str(cstr);
      vec.push_back(str);
      cout << "push back " << cstr << endl;
    }
    ifo.close();
  }
  else
  {
    cout << "could not open the file" << filename << endl; 
  }  
}  
struct stringInfo
{
  stringInfo(size_t l,size_t seq):lineno(l),wordSeq(seq)
  {}                                  
  size_t lineno;
  size_t wordSeq;
};

typedef multimap<string,stringInfo> mapStrInfo;//
typedef multimap<string,stringInfo>::iterator itMap; 
typedef vector<string>::const_iterator IT;
void regexSearch(const char* pattern,const vector<string>& vec,mapStrInfo &map)
{
  int result = -1;
  size_t lineno = 0;
  for(IT it = vec.begin();it != vec.end();it++)
  {
    lineno++;
    cout << "lineno is " << lineno << endl;
    cout << "string is " << (*it).c_str() << endl;
    result = fnmatch(pattern,(*it).c_str(),FNM_PATHNAME|FNM_PERIOD);  
    if(result = 0)
    {
      map.insert(make_pair(*it, stringInfo(lineno,0)));         
      cout << "find one match" << endl;
    }  
    else
    {
      cout << "line " << lineno << "dont have string match" << endl;
    }  
  }  
}

int main(void)
{
  vector<string> vec;
  mapStrInfo map;
  openAndRead("file",vec);
  //regexSearch("money[1-3]",vec,map);
  regexSearch("money[123]",vec,map);
  for(itMap it = map.begin();it != map.end();it++)
  {
    cout << "string is " << it->first<<"lineno is "  <<it->second.lineno << endl;
  }  
  return 0;
}  

