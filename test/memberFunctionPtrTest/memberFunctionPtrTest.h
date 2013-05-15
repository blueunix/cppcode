#ifndef _MEMBER_FUNCTION_PTR_TEST_H
#define _MEMBER_FUNCTION_PTR_TEST_H

class Base
{
  public:
    Base();
    virtual ~Base();
    void printClass();

};

class Child :public Base
{
  public:
    Child();
    ~Child();
    void printClass();

};             



#endif
