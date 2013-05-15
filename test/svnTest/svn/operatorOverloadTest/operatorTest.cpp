#include "operatorTest.h"
#include <iostream>
#include <stdlib.h>
#include <string.h>

using namespace::std;

MyClass * MyClass::instance = 0;

//########################################################
//MyClass Implementation
//
//########################################################
MyClass::MyClass(char *p):str(new char[strlen(p)+1])
{
  memcpy(str,p,strlen(p));
}  

MyClass::~MyClass()
{
  delete str;
}  

int MyClass::printMyClass()
{
  cout << "this is MyClass"<< endl;
  return 0;
}  

MyClass* MyClass::BuildMyClass()
{
  if(instance == NULL)  
    instance = new MyClass("Iloveunix");
  return instance;
}  

//########################################################
//MyClassChildA implementation
//
//########################################################
MyClassChildA::MyClassChildA():MyChild(),identity("MychildClassA")
{
  
}                               
    
MyClassChildA::~MyClassChildA()
{

}  

MyClassChildA::MyClassChildA(const MyClassChildA& child)
{


}

const MyClassChildA& MyClassChildA::MyClassChildA(const MyChildClassA& rhs)
{
  if(this != &rhs)
  {
    
  }  

}  


//########################################################
//MyClassRef implementation
//
//########################################################
MyClassRef::MyClassRef():ptr(MyClass::BuildMyClass())
//MyClassRef::MyClassPtr():ptr(0)
{
//  ptr = MyClass::BuildMyClass();

}             

MyClassRef::~MyClassRef()
{
  if(ptr)
    delete ptr;
}  

MyClass& MyClassRef::operator*()
{
  return *ptr;
}  


MyClass* MyClassRef::operator->()
{
  return ptr;

}  

char MyClassRef::operator[](size_t n)
{
  return ptr->getChar(n);
}


int main(void)
{
  //MyClassRef *ref = new MyClassRef();
  
  MyClassRef ref =  MyClassRef();
  (*ref).printMyClass();
  ref->printMyClass();
  
  char a = ref[2];
  cout << "a is " << a << endl;
}  
