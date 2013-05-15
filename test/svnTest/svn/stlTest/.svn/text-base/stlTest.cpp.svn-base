#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
using namespace std;

class Ball
{
  public:
    Ball(size_t d=1):deli(d)
    {
    }
    ~Ball(){}
    size_t deli;
    bool operator < (const Ball& rhs)const
    {
      return this->deli < rhs.deli;
    }

    bool operator > (const Ball& rhs) const
    {
      return this->deli > rhs.deli;
    }  
};


class Grade
{
  public:
    Grade():name(""),math(0),chinese(0),english(0),ball(1)
    {
    }

    Grade(string strName,size_t iMath,size_t iChinese,size_t iEnglish,size_t d=2):name(strName),math(iMath),chinese(iChinese),english(iEnglish),ball(d)
    {
    
    }                                                                   
    
    friend ostream& operator<<(ostream& os,const Grade& g) 
    {
      os << "name is "<< g.name << endl;
      os << "math is "<< g.math << endl;

      os << "chinese is "<< g.chinese << endl;
      os << "english is "<< g.english << endl;
      os << "ball is " << g.ball.deli << endl;

      os << endl;
      return os;
    }  
  private:  
    friend class Compare;
    string name;
    size_t math;
    size_t chinese;
    size_t english;
    Ball ball;
};

class Compare
{
  public:
    bool operator()(const Grade& lhs,const Grade& rhs)
    {
      if(lhs.math > rhs.math)
        return true;
      else if(lhs.math == rhs.math)
      {
        if(lhs.chinese > rhs.chinese)
          return true;
        else if(lhs.chinese == rhs.chinese)
        {
          if(lhs.english > rhs.english)
            return true;
          else if(lhs.english == rhs.english)
          {
            if(lhs.ball > rhs.ball)
              return true;
          }  
        }  
      } 
      return false;
    }
};

int main(void)
{
  vector<Grade> vec;
  Grade g1("xiaohong",23,40,58,7),g2("xiaoqiang",45,43,32,2),
        g3("xiaozhang",23,40,90,3),
        g4("xiaolan",76,23,45,4),
        g5("xiaozhao",23,44,87,5),
        g6("xiaoer",2,4,6),
        g7("xiaoball",23,40,58,9);
 
  vec.push_back(g1);
  vec.push_back(g2);
  vec.push_back(g3);
  vec.push_back(g4);
  vec.push_back(g5);
  vec.push_back(g6);
  vec.push_back(g7);
  vector<Grade>::iterator it = vec.begin();
  for(;it != vec.end();++it)
  {
    cout << *it;
  }
  Compare compare;
  cout << "##############################################" << endl;
  sort(vec.begin(),vec.end(),compare);
  it = vec.begin();
  for(;it != vec.end();++it)
  {
    cout << *it;
  }

  return 0;
}  
