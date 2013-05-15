#include <iostream>
#include <vector>
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

Grade* g = new Grade();

    //void* operator new()(size_t num)
    void* operator new(size_t num)
    {
      cout << "here is the begining of overload operator new for Grade" <<endl;
      //Grade* g =  new Grade[num];
      cout << "here us the end of overload operator new for Grade" <<endl;
      return g; 
    }  

int main(void)
{
  void *g = operator new (4);
  Grade* p = static_cast<Grade*>(g);
  delete []p;
  return 0;
}  



  





