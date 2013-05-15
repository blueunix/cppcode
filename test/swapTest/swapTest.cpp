#include <iostream>
using namespace std;
inline int atomicSwap(volatile void *p, int val)
{
#ifdef __x86_64__
  asm volatile("xchgl %k0,%1"
      :"=r" (val)
      :"m" (*(int*)p), "0" (val)
      :"memory");
  return val;
#else
  asm volatile("xchgl %0,%1"
      :"=r" (val)
      :"m" (*(int*)p), "0" (val)
      :"memory");
  return val;
#endif
}


main()
{
  int *p1 = new int(20);
  int *p2 = new int(100);
  cout << "before swap," << "p1 = " << *p1 <<",p2 = " << *p2 << endl;
  int a =atomicSwap(&p1,(int)p2);
  cout << "a is " << (*(int*) a) << endl;
  cout << "after swap," << "p1 = " << *p1 <<",p2 = " << *p2 << endl;
  delete p1,p2;
}
