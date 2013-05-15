#include<string>
using namespace std;

class MyClass
{
  public: 
    MyClass(char* p='');
    virtual ~MyClass();
    virtual int printMyClass();
    static MyClass* BuildMyClass();
    char getChar(size_t n)
    {
      return str[n];
    }
    virtual void handle_event(){}
  private:
    static MyClass* instance;
    char* str;
};

class MyClassChildA : public MyClass
{
  public:
    MyClassChildA();
    ~MyClassChildA();
    MyClassChildA(const MyClassChildA& child);
    const MyClassChildA& operator=(const MyClassChildA& child);

    int printMyClass();
    void handle_event();
  private:  
    string identity;

};   

class MyClassManager
{


};

class MyClassRef
{
  public:
    MyClassRef();
    ~MyClassRef();
    MyClass& operator*();
    MyClass* operator->();
    char operator[](size_t n);

  private:
    MyClass* ptr;

};
