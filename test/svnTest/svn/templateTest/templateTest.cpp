#include <iostream>
using namespace std;

template<class T,size_t size = 1>
class Array
{
  public:
    Array(T* p1);
    ~Array();
    
    Array& operator+(size_t n);
    Array& operator-(size_t n);

    Array& operator+(const Array& );
//    Array& operator-(const Array& );

    operator T*();

    Array(const Array&);
    template<class U,size_t ssize>
    const Array& operator=(const Array<U,ssize>& a);
    
  //private:  
    T* ptr;
    size_t length;
    T* begin;
    T* end;//next to the end
    
    template<class U,size_t ssize>
    friend ostream& operator<<(ostream& os,const Array<U,ssize>& a);
};

template<class T,size_t size>
Array<T,size>& Array<T,size>::operator+(const Array& a)
{
   
  return *this;
}  


template<class T,size_t size >
Array<T,size>::Array(T* p = NULL):ptr(p),length(size),begin(p),end(p+size)
{
  cout << p <<endl;
  cout << begin <<endl;
  cout << end <<endl;
}

template<class T,size_t size>
Array<T,size>::~Array()
{
  if(begin && length > 1)
    delete []begin;
  else if (begin && length == 1)
    delete begin;
  length = 0;
}  

template<class T,size_t size>
Array<T,size>& Array<T,size>::operator+(size_t n)
{
  if (ptr + n < end && ptr+n >= begin)
    ptr += n;
  else
    cout << "n is out of bound" << endl;
  
  return *this;
} 

template<class T,size_t size>
Array<T,size>::operator T*()
{
  return ptr;
}  

template<class T,size_t size>
Array<T,size>::Array(const Array& a):ptr(new T[a.length]),length(a.length),begin(ptr),end(ptr+length)
{
  memcpy(begin,a.begin,length);
}  


template<class T,size_t size>
template<class U,size_t ssize>
const Array<T,size>& Array<T,size>::operator=(const Array<U,ssize>& a)
{
  if(length > 1)
    delete []begin;
  else if (length == 1)
    delete begin;

  ptr = new T[a.length];
  length = a.length;
  begin = ptr;
  end = ptr + length;
  memcpy(begin, a.begin, a.length );
}  
                          
template<class T,size_t size>
Array<T,size>& Array<T,size>::operator-(size_t n)
{
  if(ptr - n < end && ptr + n >= begin)
    ptr -= n;
  else 
    cout << n << " is out of bound" << endl;
  return *this;
}

template<class T,size_t size>
ostream& operator<<(ostream& os,const Array<T,size>& a)
{
  os << "p is " << a.ptr <<",size is " << a.length 
    <<",begin is" << a.begin << ",end is"<< a.end << endl;
  return os;
}  


int main(void)
{
  Array<int, 5> a(new int[5]);
  cout << a;
  
  a = a + 2;
  cout << a;
  
  a = a - 1;
  cout << a;
  
  Array<int> b;
  b = a;
  cout << b;
 
  Array<int> c(b);
  cout << c;
  
  Array<int,100> d(new int[100]);
  cout << d;
  return 0;
}

