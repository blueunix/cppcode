#include "memberFunctionPtrTest.h"
#include <iostream>
using namespace std;

Base::Base()
{

}

Base::~Base()
{

}

void Base::printClass()
{
  cout << "this is Base" << endl;
}

Child::Child()
{
  
} 

Child::~Child()
{


}

void Child::printClass()
{
  cout << "this is Child" << endl;
}
//
//typedef void (*FP)();
//to do .how to use member function ptr
typedef void (Base::*FP)();
typedef void (Child::*CFP)();

void testMethodBase(Base* p,FP f)
{
  (p->*f)();
  //(*f)();
}

void testMethodChild(Child* p,CFP f)
{
  (p->*f)();

}  
int main(void)
{ 
  Child *c = new Child();
  testMethodChild(c,&Child::printClass);
  testMethodBase(c,static_cast<FP>(&Child::printClass));
  delete c;
  
  
  Base* p = new Base();
  testMethodBase(p,&Base::printClass);
  testMethodChild(static_cast<Child*>(p) ,static_cast<CFP>(&Base::printClass));
  delete p;
  
  
  return 0;
}  
