#include <stdio.h>

class Closure
{
  public:
    virtual ~Closure(){}
    virtual ~Run(){}

  protected:
    Closure();
};

template <class T>
class Callback0
:public Closure
{
  public:
    typedef void (T::* funcPtr)();
    Callback0(T* object,funcPtr ptr)
    {
    
    }
    virtual Run()
    {
    
    }  
  private:
    T* object;
    funcPtr ptr;
};



